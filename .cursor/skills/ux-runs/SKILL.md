---
name: ux-runs
description: Create and manage UX projects and runs under projects/<slug>/. Use when starting a UX engagement, new_project, or new_run for Athena.
---

# UX runs

## New project

```bash
bash scripts/new_project.sh <slug> <app-repo-path> "<Display name>"
```

Then edit `projects/<slug>/project.yaml` (`pilot_branch`, `base_url`, `app.repo_path`).

## New run

```bash
bash scripts/new_run.sh <slug> <type> "<task>"
```

Types:

| Type | Purpose |
|------|---------|
| `detect` | Deterministic Impeccable detect scan |
| `audit` | Impeccable audit + notes |
| `critique` | UX critique session |
| `polish` | Scoped polish proposal |
| `redesign` | Careful multi-step redesign on pilot branch |

Artifacts land in `projects/<slug>/runs/<YYYY-MM-DD>-<type>-<task>/`.

## Safety

Confirm `pilot_branch` ≠ `default_branch` before writing app code.
