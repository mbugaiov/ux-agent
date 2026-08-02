---
name: ux-ui-rules-review
description: Deterministic UI review against prioritized rules (UserInterface Wiki style). Use after implement or during Mode A; list Critical/Major/Minor violations — do not redesign from taste.
---

# UI rules review

Upstream reference:
[gsd-build/gsd-2 userinterface-wiki](https://github.com/gsd-build/gsd-2)
(152 rules / 12 categories — install or fetch only what you need; do not paste the whole wiki).

## When

- Mode A after UX fixes (or before declaring polish done)
- After Hephaestus implement, before gate if Athena is kicked
- Charter Mode B: optional dry-run against wire notes (no code)

## Prompt contract

```
Review the implementation using prioritized UI rules (UserInterface Wiki style).
Do not redesign based on personal taste.
List violations by severity: Critical / Major / Minor.
Pay special attention to: responsive layout, touch targets, information hierarchy,
table transformation, interaction states, and preservation of critical actions.
```

## Output (append to `run.md` § UI rules review)

| Sev | Rule / area | Where | Fix |
|-----|-------------|-------|-----|
| Critical | … | path or viewport | … |

- Fix **Critical** before handoff back to Hephaestus.
- **Major** — fix in same pass when cheap; else list as residual.
- **Minor** — note only.

## Forbidden

- Replacing the product design language mid-review
- “Looks better with gradients” without a rule violation
