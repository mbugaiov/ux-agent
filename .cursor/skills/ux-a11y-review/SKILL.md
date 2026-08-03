---
name: ux-a11y-review
description: Separate accessibility review after visual work — uses vendored accessibility-agents skills plus checklist. Do not mix with visual generation.
---

# Accessibility review

**Upstream is installed** under `.agents/skills/`:

- `cognitive-accessibility`
- `framework-accessibility`
- `design-system` (token / contrast / focus / motion — Community-Access, not Pro Max)
- `accessibility-rules`

Orchestrator checklist below is mandatory; load upstream SKILL.md files for depth.
Automated review is a **first line** — not a substitute for VoiceOver / NVDA / JAWS.

## When

- Mode A — **after** UI rules (+ StyleSeed score if used), **before** Impeccable
- Mode B — note a11y constraints in charter without claiming WCAG pass

## Process

1. Read the four upstream skills as needed for the stack (React/Next → `framework-accessibility`).
2. Run the check list; fix blockers on the feature branch.
3. Append `run.md` § Accessibility with pass/fail + which upstream skills were used.

## Check list

- Touch targets ≥ 44×44 CSS px for primary controls
- Contrast for text / status (status never colour-only)
- Keyboard: tab order, Escape on dialogs, no keyboard traps
- Focus visible + managed when opening/closing drawers/dialogs
- Accessible names on icon-only controls
- Tables: horizontal scroll or responsive pattern that keeps row actions
- Live regions / status announcements where async UI updates matter
- Charts: text alternative or data table when charts convey status
- Cognitive: plain language, timeout warnings, auth patterns when relevant

## Forbidden

- Mixing a11y critique into the first visual brainstorm
- Claiming full WCAG AA without assistive-tech evidence
- Using Office/PDF accessibility skills (not installed — wrong surface)
