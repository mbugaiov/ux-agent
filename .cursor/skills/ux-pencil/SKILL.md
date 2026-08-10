---
name: ux-pencil
description: Pencil (.pen) screen composition SoT for Mode B visual redesigns and composition-complete tickets. Use when DESIGN.md points at a .pen, ticket requires Pencil boards, or ux-charter-first UI redesign needs screen frames before Hephaestus implement.
---

# Pencil screen SoT (Athena)

Pencil (pen.dev MCP / Cursor extension `highagency.pencildev`) holds **screen compositions**.
Markdown (`DESIGN.md` / `UX-CHARTER.md`) holds **tokens, jobs, and acceptance**. Hephaestus
implements Ionic/web from **both** — not tokens alone when this skill applies.

## When required (Mode B)

Run Pencil completion **before** posting `UX_CHARTER_READY` when **any** of:

1. App `DESIGN.md` names a Pencil file / locked board (e.g. Board F)
2. Ticket / charter says “Pencil screen set” / “composition from .pen”
3. Ticket is a **visual redesign** or **full-screen composition** pass (`ux-charter-first`)
   for a product that already adopted Pencil in `docs/design/`

**Skip** Pencil when the ticket is clarity-only / copy / a11y polish with **no** composition
change (Mode A may still screenshot the live app).

## Human vs automatic

| Human | Factory (automatic) |
|-------|---------------------|
| Locks a **new** visual direction (pick board A/B/C…) when direction is open | Athena Mode B on `ux-charter-first` completes screens in the **locked** board |
| Files/labels the issue (or Hephaestus does on chat→issue) | Hephaestus wakes Athena; waits `UX_CHARTER_READY`; implements from `.pen` |
| Optional review of Pencil frames before implement | Mode A diffs live UI vs Pencil when `needs-ux-pass` |

Operators do **not** manually drive Pencil mid-ticket once direction is locked.

## Process

1. Confirm Pencil MCP (`highagency.pencildev-extension-pencil`). Open the product `.pen`
   as the **active editor tab** (MCP requires it).
2. Call `get_app_state({ include_schema: true, include_canvas_design: true, include_scripts_and_shaders: false })`.
3. **Never** Read/Grep encrypted `.pen` files — only Pencil MCP (`execute`, `get_screenshot`, …).
4. If direction is **open**: explore 2–3 boards; **stop for human pick** before locking DESIGN.md.
5. If direction is **locked** (named board in DESIGN.md): complete the **PRD / charter screen list**
   in that board’s tokens (login, MFA, home, report, search, detail, admin surfaces as scoped).
6. Link frames in charter + `run.md` (board name, node ids, screenshot evidence).
7. Update `docs/design/README.md` (or product equivalent) with screen inventory + status.
8. Only then post tracker **`UX_CHARTER_READY`**.

## Hephaestus handoff

Charter must tell implement:

- Pencil path + board name
- Screen → route map + **frame ids**
- “Match Pencil **composition** (structure, hierarchy, chrome) — not tokens alone”

## Acceptance bar (composition tickets)

Done **only** when live screens match Pencil frames for scoped routes (Home tiles/queue,
Search field/rows, Auth panel, etc.). Changing CSS variables / fonts while keeping a prior
layout (e.g. welcome-mat launchpad under Night Ops colors) is a **process failure**.

## Forbidden

- `UX_CHARTER_READY` on a Pencil-required ticket with only token tables and no screen frames
- Re-running Pro Max / new aesthetic when DESIGN.md already locks a board — complete that board
- Implementing UI from tokens only when the ticket required Pencil compositions
- Closing composition tickets after a retint without frame-match evidence (screenshots)