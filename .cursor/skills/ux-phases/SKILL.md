---
name: ux-phases
description: Per-phase Athena engagement — architect, visual direction, browser review, UI rules, a11y, Impeccable last, handoff. Use when executing Mode A or Mode B.
---

# UX phases

Canonical order (see `docs/UX-PIPELINE.md`):

1. **Config** — `project.yaml`, `project-memory.md`, run folder via `ux-runs`.
2. **Context** — App **`DESIGN.md`** (required). Optional `PRODUCT.md`, `docs/UX-CHARTER.md`
   (ticket lock). Note failed/interim directions.
3. **Architect** — `ux-architect` + vendored **designer-skills** (Mode B required).
4. **Visual direction** — `ux-visual-direction` + **`ui-ux-pro-max`** when direction is
   **open**; StyleSeed lock; open-design extract when superseding `DESIGN.md`.
4b. **Pencil** — skill `ux-pencil` when DESIGN.md / ticket requires screen compositions:
   complete locked board (automatic) or explore → **human pick** if direction open.
   **Commit + push** `.pen` on the feature branch. Do **not** post `UX_CHARTER_READY`
   until required frames exist **in git**.
5. **Scope** — surfaces + Pencil screen inventory; record in `run.md`.
6. **Implement** — Hephaestus owns feature UI from charter + **committed** Pencil frames;
   Athena commits polish only on the shared feature branch (or `pilot_branch` if human-only pilot).
7. **Browser review** — skill `ux-browser-review` (four viewports → `runs/…/screenshots/`).
8. **UI rules review** — skill `ux-ui-rules-review`.
9. **StyleSeed score** — `ss-score` / `ss-verify` when lock exists.
10. **A11y review** — `ux-a11y-review` + vendored accessibility-agents.
11. **Impeccable (last)** — skill `ux-impeccable`: detect + `audit|polish|harden|critique`.
12. **Handoff** — tracker comment / return to Hephaestus; update `project-memory.md`.
13. **Do not** merge to `main` or trigger STG without the normal factory path.
    See `docs/UPSTREAM-SKILLS.md` for install inventory and skip list.

## Detect helper

```bash
bash scripts/ux_detect.sh <slug> [paths…]
```

Save JSON under the run folder when Impeccable CLI is available.
