# Athena UX pipeline (upgraded)

Impeccable alone is anti-slop polish — not a senior product designer. Athena runs a
**staged pipeline**. Upstream repos are **references**; thin skills in this engine are
the source of truth so every app slug shares one brain.

## Stack (order matters)

| Step | Skill | Upstream inspiration | Role |
|------|-------|----------------------|------|
| 1 | `ux-architect` | owl-listener/designer-skills | Goals, flows, IA, states, responsive |
| 2 | Product lock | app `DESIGN.md` (+ styleseed idea) | Tokens / principles per product |
| 3 | `ux-visual-direction` | nextlevelbuilder/ui-ux-pro-max-skill | Direction, type, palette, charts |
| 4 | Implement | Hephaestus (+ Athena pilot only if asked) | Working UI |
| 5 | `ux-browser-review` | Playwright MCP | 1440 / 1024 / 768 / 390 screenshots |
| 6 | `ux-ui-rules-review` | gsd-build/gsd-2 userinterface-wiki | Critical / Major / Minor |
| 7 | `ux-a11y-review` | Community-Access/accessibility-agents | Keyboard, focus, contrast, names |
| 8 | `ux-impeccable` | pbakaus/impeccable | **Last** anti-slop polish + detect |

Optional later: bitjaru/styleseed scored gate; nexu-io/open-design for ref extraction into
`DESIGN.md`.

## Dual projects

Same engine skills; product language lives in each app repo root as **`DESIGN.md`**.

Hephaestus kicks Athena via `dev-ux-subagent` for each configured `projects/<slug>/`.

## Mode mapping

```
Mode B (ux-charter-first):
  architect → DESIGN.md check → visual direction → (browser baseline) → UX_CHARTER_READY
  → Hephaestus implement
  → Mode A

Mode A (needs-ux-pass):
  context → browser review → UI rules → a11y → Impeccable polish → return to Hephaestus
```

## Failed directions

If humans reject a shipped look, mark it in app `DESIGN.md` as **not accepted** and
require Mode B to propose **new** directions — do not polish the failed aesthetic.
