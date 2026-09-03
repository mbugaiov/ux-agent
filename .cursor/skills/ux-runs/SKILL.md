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

## New run (required — Plutus Athena)

**Every** Athena engagement (Mode A polish, Mode B charter, detect/audit) **must**
create a dated run folder **before** charter/polish work. Plutus Tier D counts
Athena only via `ux-agent/projects/<slug>/runs/<YYYY-MM-DD>-*`. OpenSpec
`ux-charter.md` alone does **not** credit Athena.

```bash
bash scripts/new_run.sh <slug> <type> "<task>"
```

Types:

| Type | Purpose |
|------|---------|
| `detect` | Deterministic Impeccable detect scan |
| `audit` | Impeccable audit + notes |
| `critique` | UX critique session |
| `polish` | Mode A polish (Hephaestus kick) |
| `redesign` | Careful multi-step redesign on pilot branch |
| `charter` | Mode B `ux-charter-first` (design-first) |

Artifacts land in `projects/<slug>/runs/<YYYY-MM-DD>-<type>-<task>/`.
Link the path in tracker comments and return it to Hephaestus.

## Safety

Confirm `pilot_branch` ≠ `default_branch` before writing app code.
