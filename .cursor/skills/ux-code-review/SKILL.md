---
name: ux-code-review
description: Review ux-agent engine PRs — pre_merge_check, cursor-agent review gate, portability. Use before opening an engine PR.
---

# UX Agent engine — code review

## Before PR

```bash
bash scripts/pre_merge_check.sh
```

## Branch

Never push `main`. Feature branch + `gh pr create`.

## CI

Workflows: `CI` (job `test`) + `Code Review` (job `review`) + auto-merge when both green
(requires `CURSOR_API_KEY`).

## Policy

Follow `.cursor/rules/code-review.mdc`.
