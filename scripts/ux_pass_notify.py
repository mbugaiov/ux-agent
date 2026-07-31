#!/usr/bin/env python3
"""Teams Adaptive Card notification when an Athena UX pass starts.

Webhook (optional; same Power Automate channel as Hephaestus when URLs match):
  UX_FACTORY_TEAMS_WEBHOOK_URL  (preferred)
  AGENT_TEAMS_WEBHOOK_URL       (shared fallback)
  DEV_FACTORY_TEAMS_WEBHOOK_URL (shared fallback)

Usage:
  python3 scripts/ux_pass_notify.py --slug lrm --ticket RQ-1 --branch feat/x \\
    --surfaces 'components/Foo.tsx' --mode hephaestus-kick
  python3 scripts/ux_pass_notify.py --slug lrm --smoke
"""
from __future__ import annotations

import argparse
import json
import os
import sys
from typing import Any
from urllib.error import HTTPError, URLError
from urllib.parse import parse_qs, urlparse
from urllib.request import Request, urlopen

PASS_NOTIFY_FAILED = "UX_PASS_NOTIFY_FAILED"
NEXT_RUN = "on-demand (Hephaestus kick / charter)"


def load_env_file(path: str) -> dict[str, str]:
    out: dict[str, str] = {}
    if not os.path.exists(path):
        return out
    with open(path, encoding="utf-8") as fh:
        for line in fh:
            line = line.strip()
            if not line or line.startswith("#") or "=" not in line:
                continue
            k, v = line.split("=", 1)
            out[k.strip()] = v.strip().strip('"').strip("'")
    return out


def get_teams_webhook_url(env: dict[str, str] | None = None) -> str | None:
    src = env if env is not None else os.environ
    for name in (
        "UX_FACTORY_TEAMS_WEBHOOK_URL",
        "AGENT_TEAMS_WEBHOOK_URL",
        "DEV_FACTORY_TEAMS_WEBHOOK_URL",
    ):
        url = (src.get(name) or "").strip()
        if url:
            return url
    return None


def check_webhook_url(raw: str | None) -> dict[str, Any]:
    url = (raw or "").strip()
    if not url:
        return {
            "ok": False,
            "problem": "not_configured",
            "detail": "UX_FACTORY_TEAMS_WEBHOOK_URL is not set — Teams pass notification disabled",
        }
    try:
        parsed = urlparse(url)
    except Exception:
        return {
            "ok": False,
            "problem": "not_absolute",
            "detail": f"not a valid absolute URL (length {len(url)}) — likely truncated",
        }
    if not parsed.scheme or not parsed.netloc:
        return {
            "ok": False,
            "problem": "not_absolute",
            "detail": f"not a valid absolute URL (length {len(url)}) — likely truncated",
        }
    if parsed.scheme != "https":
        return {
            "ok": False,
            "problem": "not_https",
            "detail": f"expected https, got {parsed.scheme}:",
        }
    host = parsed.hostname or ""
    needs_sig = host.endswith("logic.azure.com") or host.endswith("azure.com") or "powerplatform.com" in host
    if needs_sig and not parse_qs(parsed.query).get("sig"):
        return {
            "ok": False,
            "problem": "missing_signature",
            "detail": "missing sig query parameter — value was truncated (quote the URL in .secrets/jira.env)",
        }
    return {"ok": True, "url": url}


def build_pass_notify_summary(
    *,
    slug: str,
    ticket: str,
    branch: str,
    surfaces: str,
    mode: str,
) -> str:
    scope = surfaces.strip() or "(no surfaces listed)"
    return (
        f"[{slug}] UX pass started — {ticket} on {branch} ({mode}). "
        f"Scope: {scope}. Next: {NEXT_RUN}"
    )


def build_pass_notify_webhook_body(
    *,
    slug: str,
    ticket: str,
    branch: str,
    surfaces: str,
    mode: str,
) -> dict[str, Any]:
    summary = build_pass_notify_summary(
        slug=slug, ticket=ticket, branch=branch, surfaces=surfaces, mode=mode
    )
    facts = [
        {"title": "Project", "value": slug},
        {"title": "Ticket", "value": ticket or "(none)"},
        {"title": "Branch", "value": branch or "(unknown)"},
        {"title": "Scope / surfaces", "value": (surfaces.strip() or "(none)")[:500]},
        {"title": "Mode", "value": mode},
        {"title": "Next run", "value": NEXT_RUN},
    ]
    return {
        "type": "message",
        "summary": summary,
        "attachments": [
            {
                "contentType": "application/vnd.microsoft.card.adaptive",
                "content": {
                    "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
                    "type": "AdaptiveCard",
                    "version": "1.4",
                    "msteams": {"width": "Full"},
                    "body": [
                        {
                            "type": "TextBlock",
                            "text": "UX pass started",
                            "weight": "Bolder",
                            "size": "Medium",
                            "color": "Accent",
                            "wrap": True,
                        },
                        {"type": "FactSet", "facts": facts, "spacing": "Medium"},
                    ],
                },
            }
        ],
    }


def should_report_outcome(outcome: dict[str, Any]) -> bool:
    return (not outcome.get("delivered")) and outcome.get("reason") != "not_configured"


def format_pass_notify_failure(slug: str, outcome: dict[str, Any]) -> str:
    if not should_report_outcome(outcome):
        raise ValueError("format_pass_notify_failure called on delivered/unconfigured outcome")
    payload: dict[str, Any] = {
        "slug": slug,
        "reason": outcome.get("reason"),
        "detail": outcome.get("detail"),
        "remediation": (
            "Teams UX pass notification was NOT delivered. Verify UX_FACTORY_TEAMS_WEBHOOK_URL "
            "is quoted in projects/<slug>/.secrets/jira.env (same URL as DEV_FACTORY_TEAMS_WEBHOOK_URL)."
        ),
    }
    if "status" in outcome and outcome["status"] is not None:
        payload["status"] = outcome["status"]
    return f"{PASS_NOTIFY_FAILED} {json.dumps(payload)}"


def post_ux_pass_notify(
    *,
    slug: str,
    ticket: str = "",
    branch: str = "",
    surfaces: str = "",
    mode: str = "hephaestus-kick",
    webhook_url: str | None = None,
    timeout: float = 20.0,
) -> dict[str, Any]:
    check = check_webhook_url(webhook_url if webhook_url is not None else get_teams_webhook_url())
    if not check["ok"]:
        if check["problem"] == "not_configured":
            return {"delivered": False, "reason": "not_configured", "detail": check["detail"]}
        return {
            "delivered": False,
            "reason": "invalid_webhook_url",
            "detail": f"{check['problem']}: {check['detail']}",
        }

    body = build_pass_notify_webhook_body(
        slug=slug, ticket=ticket, branch=branch, surfaces=surfaces, mode=mode
    )
    data = json.dumps(body).encode("utf-8")
    req = Request(
        check["url"],
        data=data,
        headers={"Content-Type": "application/json"},
        method="POST",
    )
    try:
        with urlopen(req, timeout=timeout) as res:
            status = getattr(res, "status", 200)
            if 200 <= int(status) < 300:
                return {"delivered": True, "status": int(status)}
            detail = f"webhook responded {status}"
            try:
                text = res.read().decode("utf-8", errors="replace").strip()
                if text:
                    detail += f": {text[:300]}"
            except Exception:
                pass
            return {"delivered": False, "reason": "http_error", "detail": detail, "status": int(status)}
    except HTTPError as err:
        detail = f"webhook responded {err.code}"
        try:
            text = err.read().decode("utf-8", errors="replace").strip()
            if text:
                detail += f": {text[:300]}"
        except Exception:
            pass
        return {"delivered": False, "reason": "http_error", "detail": detail, "status": err.code}
    except URLError as err:
        return {"delivered": False, "reason": "exception", "detail": str(err.reason or err)}
    except Exception as err:
        return {"delivered": False, "reason": "exception", "detail": str(err)}


def main() -> int:
    ap = argparse.ArgumentParser(description="Athena UX pass Teams notify")
    ap.add_argument("--slug", required=True)
    ap.add_argument("--project", help="projects/<slug> (loads .secrets/jira.env)")
    ap.add_argument("--ticket", default="")
    ap.add_argument("--branch", default="")
    ap.add_argument("--surfaces", default="")
    ap.add_argument(
        "--mode",
        default="hephaestus-kick",
        choices=("hephaestus-kick", "charter"),
    )
    ap.add_argument("--smoke", action="store_true")
    a = ap.parse_args()

    root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    proj = a.project or os.path.join(root, "projects", a.slug)
    cfg = load_env_file(os.path.join(proj, ".secrets", "jira.env"))
    for k, v in cfg.items():
        os.environ.setdefault(k, v)

    ticket = a.ticket or ("SMOKE-TEST" if a.smoke else "")
    branch = a.branch or ("smoke/ux-pass-notify" if a.smoke else "")
    surfaces = a.surfaces or ("components/Smoke.tsx" if a.smoke else "")
    mode = a.mode

    outcome = post_ux_pass_notify(
        slug=a.slug,
        ticket=ticket,
        branch=branch,
        surfaces=surfaces,
        mode=mode,
    )

    if a.smoke:
        if outcome.get("delivered"):
            print(
                f'UX_PASS_NOTIFY_SMOKE_OK {{"slug":"{a.slug}","status":{outcome.get("status")}}}'
            )
            return 0
        check = check_webhook_url(get_teams_webhook_url())
        if not check["ok"] and check["problem"] == "not_configured":
            print(
                f'UX_PASS_NOTIFY_SMOKE_FAILED {{"slug":"{a.slug}","problem":"not_configured","detail":{json.dumps(check["detail"])}}}',
                file=sys.stderr,
            )
            print(
                "Teams notification is optional. Set a QUOTED UX_FACTORY_TEAMS_WEBHOOK_URL "
                f"(same URL as DEV_FACTORY) in projects/{a.slug}/.secrets/jira.env",
                file=sys.stderr,
            )
            return 1
        if should_report_outcome(outcome):
            print(format_pass_notify_failure(a.slug, outcome), file=sys.stderr)
        return 1

    if outcome.get("delivered"):
        print(json.dumps({"delivered": True, "status": outcome.get("status")}))
        return 0
    if should_report_outcome(outcome):
        print(format_pass_notify_failure(a.slug, outcome), file=sys.stderr)
        return 1
    print(json.dumps({"delivered": False, "reason": outcome.get("reason")}))
    return 0


if __name__ == "__main__":
    sys.exit(main())
