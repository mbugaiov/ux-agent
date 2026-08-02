---
name: ux-phases
description: Per-phase Athena engagement — architect, visual direction, browser review, UI rules, a11y, Impeccable last, handoff. Use when executing Mode A or Mode B.
---

# UX phases

Canonical order (see `docs/UX-PIPELINE.md`):

1. **Config** — `project.yaml`, `project-memory.md`, run folder via `ux-runs`.
2. **Context** — App **`DESIGN.md`** (required). Optional `PRODUCT.md`, `docs/UX-CHARTER.md`
   (ticket lock). Note failed/interim directions.
3. **Architect** — skill `ux-architect` (Mode B required; Mode A if flow broken).
4. **Visual direction** — skill `ux-visual-direction` (Mode B redesign / open DESIGN.md only).
5. **Scope** — 1–2 surfaces; record in `run.md`.
6. **Implement** — Hephaestus owns feature UI; Athena commits polish only on the shared
   feature branch (or `pilot_branch` if human-only pilot).
7. **Browser review** — skill `ux-browser-review` (four viewports → `runs/…/screenshots/`).
8. **UI rules review** — skill `ux-ui-rules-review`.
9. **A11y review** — skill `ux-a11y-review`.
10. **Impeccable (last)** — skill `ux-impeccable`: detect + `audit|polish|harden|critique`.
11. **Handoff** — tracker comment / return to Hephaestus; update `project-memory.md`.
12. **Do not** merge to `main` or trigger STG without the normal factory path.

## Detect helper

```bash
bash scripts/ux_detect.sh <slug> [paths…]
```

Save JSON under the run folder when Impeccable CLI is available.
