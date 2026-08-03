---
name: ux-architect
description: Product UX thinking before visuals — loads vendored designer-skills. Use for Athena Mode B charter and any redesign; do not skip before choosing a look.
---

# UX Architect (Mode B spine)

**Upstream is installed** in this engine: `.agents/skills/` from
[Owl-Listener/designer-skills](https://github.com/Owl-Listener/designer-skills) (full pack).
See `docs/UPSTREAM-SKILLS.md`. Do **not** treat this orchestrator as a substitute for those skills.

## When

- Mode B (`ux-charter-first`) — **required before** visual direction
- Mode A polish — only when hierarchy / flow is broken (not for colour tweaks)

## Mandatory process

1. Read app **`DESIGN.md`** (and ticket `docs/UX-CHARTER.md` if present).
2. **Load upstream skills as needed** (Read their `SKILL.md` under `.agents/skills/<name>/`):
   - Framing: `design-brief`, `jobs-to-be-done`, `user-persona` / `empathy-map` when research exists
   - Flow / IA: `journey-map`, `content-strategy`, and any IA / navigation skills present
   - Interaction: interaction-design skills for states, forms, navigation, feedback
   - UI structure (not visual brand yet): layout / responsive / data-viz skills as needed
   - Before freeze: at least one `critique-*` skill (hierarchy, affordance, or density)
3. Write required outputs below into `run.md` + optional `ia.md`.
4. **No palette / font / “look” decisions here** — that is `ux-visual-direction` + `ui-ux-pro-max`.

## Required output

### 1. Product framing

- Primary user, job-to-be-done, task frequency
- Success metric for this ticket (what “better” means vs current STG)
- Explicit **reject list** if a prior direction failed (cite issue / run)

### 2. Flows

- Primary path (happy)
- Secondary actions
- Failure / empty / loading / permission-denied states

### 3. Information architecture

- Page jobs (one job per section)
- Hierarchy: what must be visible without hover/scroll on first viewport
- Navigation model

### 4. Interaction model

- Component inventory with states (default / hover / focus / active / disabled / error)
- Tables / lists: row actions, bulk ops, mobile transformation rules
- Drawers / dialogs: focus trap, dismiss, full-screen sheet on small viewports

### 5. Responsive intent (not “stack desktop”)

Document behaviour at **1440 / 1024 / 768 / 390** for critical actions and status.

### 6. Freeze

Routes, `data-testid`s, APIs, brand assets that must not change unless ticket owns them.

### 7. Upstream audit trail

List which `.agents/skills/<name>` files you actually used (for run.md).

## Hard rules

- Prefer preserving product patterns unless usability failure is documented.
- Never remove functionality to “make it cleaner.”
- Never hide critical status or primary actions behind hover.
- Research-only skills (diary studies, survey design) — use when ticket has research inputs;
  do not invent fake interview data.
