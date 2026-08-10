# Athena UX pipeline (upgraded)

Impeccable alone is anti-slop polish — not a senior product designer. Athena runs a
**staged pipeline**. Upstream skill packs are **vendored** under `.agents/skills/`
(see `docs/UPSTREAM-SKILLS.md`). Thin `.cursor/skills/ux-*` orchestrators are the
control plane so every app slug shares one brain and one order.

## Stack (order matters)

| Step | Orchestrator | Upstream (vendored) | Role |
|------|--------------|---------------------|------|
| 1 | `ux-architect` | **designer-skills** (full) | Goals, flows, IA, states, responsive, critique |
| 2 | Product lock | app `DESIGN.md` + open-design `design-md` / `gpt-taste` / `brand-extract` / `reference-design-contract` | Tokens / principles; extract from refs when needed |
| 3 | `ux-visual-direction` | **`ui-ux-pro-max`** (mandatory search) | Direction, type, palette, charts, stack fit |
| 3b | (consistency) | **StyleSeed** `ss-*` | Cross-screen lock + score; merge into `DESIGN.md` |
| 4 | Implement | Hephaestus (+ Athena pilot only if asked) | Working UI |
| 5 | `ux-browser-review` | Playwright MCP / CLI | 1440 / 1024 / 768 / 390 screenshots |
| 6 | `ux-ui-rules-review` | Engine checklist (GSD wiki not installable as skill) | Critical / Major / Minor |
| 7 | `ux-a11y-review` | accessibility-agents (4 web skills) | Keyboard, focus, contrast, names, cognitive |
| 8 | `ux-impeccable` | pbakaus/impeccable | **Last** anti-slop polish + detect |

**Not used:** Pro Max MCP; open-design marketing/video packs; gsd-orchestrator.

## Dual projects

Same engine skills; product language lives in each app repo root as **`DESIGN.md`**.

Hephaestus kicks Athena via `dev-ux-subagent` for each configured `projects/<slug>/`.

## Mode mapping

```
Mode B (ux-charter-first):
  architect (designer-skills) → DESIGN.md (+ open-design extract if needed)
  → visual direction (ui-ux-pro-max when direction OPEN)
  → Pencil screen set (ux-pencil) when DESIGN.md / ticket requires .pen compositions
      — if direction open: explore boards → human picks one → lock DESIGN.md
      — if direction locked: complete PRD screens in that board (no human pick)
      — **commit + push** `.pen` (+ design README) on the feature branch
  → StyleSeed lock when used
  → (browser baseline) → UX_CHARTER_READY
  → Hephaestus implement (match Pencil frames from **git** + DESIGN tokens)
  → Mode A

Mode A (needs-ux-pass):
  context → browser review (diff vs Pencil when .pen SoT exists)
  → UI rules → StyleSeed score (if lock exists)
  → a11y (upstream + orchestrator) → Impeccable polish → return to Hephaestus
```

## Pencil

Skill: **`ux-pencil`**. Encrypted `.pen` files — Pencil MCP only (never Read/Grep).
Human picks a board **only** when visual direction is open; locked boards are completed
by Athena automatically on `ux-charter-first` tickets.

**Git gate:** required frames MUST be on the remote feature branch before
`UX_CHARTER_READY` and before any `impl-dev` kick that cites those frames. Editor-only
or uncommitted `.pen` = process failure (Hephaestus cannot implement from chat memory).
## Failed directions

If humans reject a shipped look, mark it in app `DESIGN.md` as **not accepted** and
require Mode B to propose **new** directions — do not polish the failed aesthetic.
