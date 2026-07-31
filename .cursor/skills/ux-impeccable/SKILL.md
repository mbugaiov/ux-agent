---
name: ux-impeccable
description: Install and run Impeccable (detect, audit, critique, polish, DESIGN.md) for product UI. Use for Athena design spine work; prefer audit/polish/harden on mature dashboards.
---

# Impeccable (design spine)

Upstream: https://github.com/pbakaus/impeccable · Docs: https://impeccable.style

## Install (app repo, pilot branch)

```bash
cd "$APP_REPO"
git switch <pilot_branch>   # never invent main commits for redesign
npx impeccable install --providers=cursor --scope=project --no-hooks
```

Enable hooks only after reviewing merge with existing `.cursor/hooks.json`.

Then: `/impeccable init` → **product** surface; encode brand tokens.

## Preferred commands (mature product UI)

| Command | Use |
|---------|-----|
| `audit` | a11y, responsive, performance |
| `critique` | hierarchy / clarity |
| `polish` | shipping readiness |
| `harden` | overflow, errors, edge UI |
| `detect` (CLI) | deterministic CI/local scan |

## Avoid unless explicitly requested

`craft`, `overdrive`, `delight`, `bolder` — high risk of fighting established the app/brand UI.

## CLI detect (no LLM)

```bash
npx impeccable detect --json components/
npx impeccable detect --json app/
```

Engine wrapper: `bash scripts/ux_detect.sh <slug> [relative-paths…]`

## Brand / waivers

Record brand exceptions in app `.impeccable/config.json` and `project-memory.md`.
