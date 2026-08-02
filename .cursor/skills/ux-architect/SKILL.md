---
name: ux-architect
description: Product UX thinking before visuals — goals, flows, IA, interaction states, responsive behaviour, edge cases. Use for Athena Mode B charter and any redesign; do not skip before choosing a look.
---

# UX Architect (Mode B spine)

Inspired by process repos such as [owl-listener/designer-skills](https://github.com/owl-listener/designer-skills)
(research → product → IA → interaction → critique). **Do not vendor the whole repo.**
Use this skill as the mandatory thinking pass; optionally pull a single upstream skill
if the host has installed it via `npx skills add`.

## When

- Mode B (`ux-charter-first`) — **required before** visual direction
- Mode A polish — only when hierarchy / flow is broken (not for colour tweaks)

## Required output (write into `run.md` + optional `ia.md`)

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

## Hard rules

- **No visual direction yet** — no palette, font pairing, or “temple/neon/glass” choices here.
- Prefer preserving product patterns unless usability failure is documented.
- Never remove functionality to “make it cleaner.”
- Never hide critical status or primary actions behind hover.
