---
name: ux-jira
description: File or update Jira UX findings from Athena runs. Use when creating impl-ux tickets or handing off to impl-dev.
---

# UX Jira

## Labels

- `impl-ux` — Athena-owned charter / findings
- `impl-dev` — add when code change should be picked by Hephaestus
- Product labels — set per `projects/<slug>/project.yaml` / secrets (not in engine)

## Filing

Prefer existing grooming skills in the app / jira tooling. Include:

1. Surface + pilot branch name
2. Detect JSON excerpt or screenshots
3. Acceptance: merge only via MR to `main` after preview

## Do not

- Transition product tickets to Done
- Deploy or instruct deploy to STG from pilot branch
