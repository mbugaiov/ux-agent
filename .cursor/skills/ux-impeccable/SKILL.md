---
name: ux-impeccable
description: Impeccable detect/audit/critique/polish — final anti-slop pass after architect, visual direction, browser, UI rules, and a11y. Prefer audit/polish/harden on mature dashboards.
---

# Impeccable (**last** polish, not the whole UX brain)

Upstream: https://github.com/pbakaus/impeccable · Docs: https://impeccable.style

Impeccable is taste rules + deterministic detectors. It does **not** replace
`ux-architect`, browser review, or product `DESIGN.md`. Run it **after** those steps
(see `docs/UX-PIPELINE.md`).

## Install (app repo, pilot / feature branch)

```bash
cd "$APP_REPO"
git switch <feature-or-pilot-branch>   # never invent main commits for redesign
npx impeccable install --providers=cursor --scope=project --no-hooks
```

Enable hooks only after reviewing merge with existing `.cursor/hooks.json`.

Then: `/impeccable init` → **product** surface; encode brand tokens into **`DESIGN.md`**.

## Preferred commands (mature product UI)

| Command | Use |
|---------|-----|
| `audit` | a11y, responsive, performance |
| `critique` | hierarchy / clarity |
| `polish` | shipping readiness |
| `harden` | overflow, errors, edge UI |
| `detect` (CLI) | deterministic CI/local scan |

## Avoid unless explicitly requested

`craft`, `overdrive`, `delight`, `bolder` — high risk of fighting established brand UI
or re-introducing failed aesthetics (glow, fantasy temple, purple wash).

## CLI detect (no LLM)

```bash
npx impeccable detect --json components/
npx impeccable detect --json app/
```

Engine wrapper: `bash scripts/ux_detect.sh <slug> [relative-paths…]`

## Brand / waivers

Record brand exceptions in app `.impeccable/config.json` and `project-memory.md`.
