# UX Agent — SETUP

Execute top to bottom for a new app (or the app). Agent-friendly runbook.

## 0. Prerequisites

- Node.js 20+
- Cursor with Agent Skills enabled
- GitHub access to push `ux-agent` PRs
- App repo checked out locally (e.g. `app-repo`)

## 1. Engine

```bash
cd /path/to/ux-agent
bash tests/run_tests.sh
```

## 2. Create project

```bash
bash scripts/new_project.sh <slug> <absolute-app-repo-path> "<App display name>"
```

Edit `projects/<slug>/project.yaml`:

- `app.repo_path` — absolute or relative path to the app git root
- `app.pilot_branch` — e.g. `feat/ux-impeccable-pilot` (**not** `main`)
- `app.default_branch` — usually `main` (STG source of truth)
- `base_url` — STG or local URL for optional live audits
- `impeccable.enabled: true`

## 3. Install Impeccable in the **app** repo (pilot branch)

```bash
cd <app-repo>
git fetch origin
git switch -c feat/ux-impeccable-pilot origin/main   # or reuse existing pilot branch
npx impeccable install --providers=cursor --scope=project --no-hooks
# Hooks optional — enable later after reviewing .cursor/hooks.json merge
```

Then in Cursor Agent on the app:

```
/impeccable init
```

Choose **product** (dashboard/tool). Encode brand brand (`#1ca0d9`, existing type, no Inter-default SaaS).

Commit **only** shared artifacts on the pilot branch:

- `PRODUCT.md`, `DESIGN.md` (or `.impeccable/design.json` if generated)
- `.gitignore` impeccable ephemeral block
- `docs/UX-AGENT.md` pointer (optional)

**Do not merge to `main` until humans sign off.**

## 4. First detect run (engine)

```bash
cd /path/to/ux-agent
bash scripts/new_run.sh <slug> detect "baseline components"
bash scripts/ux_detect.sh <slug> components/
```

Findings → `projects/<slug>/runs/<date>-detect-…/detect.json` + summary in `run.md`.

## 5. Careful redesign process

| Step | Action |
|------|--------|
| A | Scope 1–2 surfaces (e.g. landing, assign picker) — not whole app |
| B | `/impeccable audit` / `polish` on that surface only |
| C | Commit on **pilot_branch**; run app `npm run gate:mr` if changing code |
| D | Preview locally; collect stakeholder screenshots |
| E | Open Bitbucket MR **pilot → main** when ready (normal the app pipeline) |
| F | STG updates only after merge to `main` |

## 6. Factory labels (Jira)

Suggested labels (project-specific; set in `project.yaml` / secrets):

- `impl-ux` — UX factory pickup (Athena)
- `impl-dev` — when Athena hands a code fix to Hephaestus

## 7. Pre-merge (engine PRs)

```bash
bash scripts/pre_merge_check.sh
```

Never push engine `main` directly — PR + CI + Code Review.
