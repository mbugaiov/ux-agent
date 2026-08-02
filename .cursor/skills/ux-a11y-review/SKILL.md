---
name: ux-a11y-review
description: Separate accessibility review after visual work — WCAG basics, keyboard, focus, names, touch targets. Do not mix with visual generation. Complements Argus STG QA.
---

# Accessibility review

Upstream reference:
[Community-Access/accessibility-agents](https://github.com/Community-Access/accessibility-agents)
(specialized a11y agents/skills — optional host install). Automated review is a **first line**;
it does not replace VoiceOver / NVDA / JAWS.

## When

- Mode A — **after** UI rules review, **before** Impeccable final polish
- Mode B — note a11y constraints in charter (focus order, names) without claiming WCAG pass

## Check list

- Touch targets ≥ 44×44 CSS px for primary controls
- Contrast for text / status (status never colour-only)
- Keyboard: tab order, Escape on dialogs, no keyboard traps
- Focus visible + managed when opening/closing drawers/dialogs
- Accessible names on icon-only controls
- Tables: horizontal scroll or responsive pattern that keeps row actions
- Live regions / status announcements where async UI updates matter
- Charts: text alternative or data table when charts convey status

## Output

Append `run.md` § Accessibility with pass/fail + fixes applied.
Hand residual a11y risk to Argus (do not mark Done).

## Forbidden

- Mixing a11y critique into the first visual brainstorm
- Claiming full WCAG AA without assistive-tech evidence
