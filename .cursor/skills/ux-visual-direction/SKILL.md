---
name: ux-visual-direction
description: Choose visual direction, typography, palette, and chart guidance after UX architect. Prefer UI UX Pro Max for structured options; never invent a second brand when DESIGN.md locks one.
---

# Visual direction

Upstream (optional install on host):
[nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill)
(`npx skills add https://github.com/nextlevelbuilder/ui-ux-pro-max-skill`).
MCP variant: `rofuniki-coder/ui-ux-pro-max-mcp` when available.

## When

- **After** `ux-architect` for Mode B redesigns
- When `DESIGN.md` says direction is **open** or **rejected / needs redesign**
- **Skip** when `DESIGN.md` locks tokens and the ticket is clarity-only (Mode A polish)

## Process

1. Read app **`DESIGN.md`** (required). Also read `docs/UX-CHARTER.md` if present — charter
   is a ticket lock; DESIGN.md is the product language. If they conflict, **DESIGN.md wins**
   unless this ticket’s Mode B explicitly supersedes it (and then update DESIGN.md in the
   implement phase).
2. If prior direction is marked **failed / interim / not accepted**, do **not** refine it —
   propose **2–3 distinct directions** scored against product goals from `ux-architect`.
3. Use Pro Max (or equivalent structured lookup) for:
   - product-type fit
   - palette + type pairing
   - dashboard / data-viz patterns
   - stack-appropriate patterns (Next.js, etc.)
4. Pick **one** direction; document why others lost.
5. Encode the winner into charter artifacts (`run.md` § Visual) and, on implement, into
   **`DESIGN.md`**.

## Anti-slop (mandatory)

Do **not** default to:

- purple-on-white / purple–indigo washes
- dark navy + gold “fantasy temple” + neon glow unless the product brief demands it
  **and** human accepted that direction
- glassmorphism, oversized hero display type, gradient soup
- Inter / Roboto / Arial / system stacks when DESIGN.md specifies otherwise
- a new design language when an accepted DESIGN.md already exists

## Output

- Direction name + 5–8 token decisions (bg, text, accent, border, type)
- What is reused from existing components vs new
- Explicit “not this ticket” visual scope
