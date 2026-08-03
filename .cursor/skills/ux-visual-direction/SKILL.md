---
name: ux-visual-direction
description: Choose visual direction after UX architect. MUST run vendored ui-ux-pro-max search; optional StyleSeed lock. No MCP.
---

# Visual direction

**Upstream is installed** at `.agents/skills/ui-ux-pro-max/` (full local DB — styles, palettes,
fonts, product types, charts). **Do not skip** the search script on Mode B redesigns.
MCP is **not** used.

Also available: StyleSeed under `.agents/skills/ss-*` and `styleseed-design-review`
(consistency after a direction is chosen). open-design: `design-md`, `gpt-taste`,
`brand-extract`, `reference-design-contract` when formalizing or extracting `DESIGN.md`.

## When

- **After** `ux-architect` for Mode B redesigns
- When `DESIGN.md` says direction is **open** or **rejected / needs redesign**
- **Skip Pro Max generation** when `DESIGN.md` locks tokens and the ticket is clarity-only
  (Mode A polish) — still may run StyleSeed `ss-score` / `ss-review`

## Process

1. Read app **`DESIGN.md`**. Ticket `docs/UX-CHARTER.md` is a ticket lock; **DESIGN.md wins**
   unless this Mode B explicitly supersedes it (then update DESIGN.md on implement).
2. If extracting from URL/screenshot refs: use `brand-extract` / `gpt-taste` /
   `reference-design-contract` / `design-md` as appropriate — output must land in product
   `DESIGN.md`, not a parallel brand bible that contradicts it.
3. If prior direction is **failed / interim / not accepted**, do **not** refine it —
   propose **2–3 distinct directions**.
4. **Mandatory — run ui-ux-pro-max search** (from **ux-agent** engine root).
   Upstream docs mention `CLAUDE_PLUGIN_ROOT` — in this engine use the vendored path:

   ```bash
   python3 .agents/skills/ui-ux-pro-max/scripts/search.py \
     "<product type / industry / keywords>" --design-system -p "<App>"
   python3 .agents/skills/ui-ux-pro-max/scripts/search.py "<keyword>" --domain style -n 5
   python3 .agents/skills/ui-ux-pro-max/scripts/search.py "<keyword>" --stack nextjs
   ```

   Full flag reference: `.agents/skills/ui-ux-pro-max/SKILL.md`.
   Use results for product-type fit, palette + type pairing, dashboard / chart patterns,
   and stack-appropriate guidance. Cite search hits in `run.md`.
5. Pick **one** direction; document why others lost.
6. **StyleSeed lock (recommended on redesign):** `ss-setup` / `ss-tokens` / `ss-resolve`
   (or `styleseed-design-review`). Merge approved decisions into app **`DESIGN.md`**.
   Do not leave StyleSeed as a competing source of truth that drifts from DESIGN.md.
7. Encode the winner into charter artifacts (`run.md` § Visual).

## Anti-slop (mandatory)

Do **not** default to:

- purple-on-white / purple–indigo washes
- dark navy + gold “fantasy temple” + neon glow unless the product brief demands it
  **and** human accepted that direction
- glassmorphism, oversized hero display type, gradient soup
- Inter / Roboto / Arial / system stacks when DESIGN.md specifies otherwise
- a new design language when an accepted DESIGN.md already exists
- Pro Max marketing skills we did **not** install (`banner-design`, `slides`, CIP `design`)

## Output

- Direction name + 5–8 token decisions (bg, text, accent, border, type)
- Pro Max search commands + key hits
- StyleSeed score / lock paths if run
- What is reused from existing components vs new
- Explicit “not this ticket” visual scope
