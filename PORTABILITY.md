# UX Agent — portability (engine vs projects)

## Engine ships

```
ux-agent/
  AGENTS.md  README.md  SETUP.md  PORTABILITY.md  HOST_SETUP.md
  .cursor/rules/   .cursor/skills/
  templates/  scripts/  tests/
  projects/_template/
  .github/workflows/
```

**Rule:** engine files must not hardcode a live project slug, product name, Jira epic,
or absolute developer path. Use `projects/<slug>/` and placeholders.

## Per project (not in engine git)

```
projects/<slug>/
  project.yaml
  project-memory.md
  design/                 # copies or links to DESIGN notes
  runs/<YYYY-MM-DD>-<type>-<task>/
  reports/
  .secrets/               # gitignored
```

Live `projects/<slug>/` is gitignored except `_template/`. Attach via clone, submodule,
or local path — same patterns as `qa-agent` / `dev-agent` (**PORTABILITY** siblings).

## App repo responsibilities

| Artifact | Repo | How it ships |
|----------|------|--------------|
| `PRODUCT.md` / `DESIGN.md` / Impeccable install | **App** | Feature / pilot branch → Bitbucket MR → `main` |
| UI polish on a feature ticket | **App** | Same Hephaestus feature branch → Bitbucket MR |
| Detect/critique orchestration, run ledger | **ux-agent** `projects/<slug>/` (gitignored live) | Local only — not engine git |
| Shared Athena skills / scripts / rules / `_template` | **ux-agent engine** | **GitHub PR** to engine `main` |
| STG deploy | App `main` CI only | After app MR merge |

## Dual delivery (engine vs product)

When a change is **common to Athena** (skills, rules, scripts, tests, `projects/_template/`,
engine docs), open a **GitHub PR on `ux-agent`** and merge it — do not leave engine edits
only on a laptop.

When a change is **product UI** for one app, commit on that app’s **feature branch** (Hephaestus
or charter pilot) and ship via the **app Bitbucket MR**. Do not put product components into
the engine repo.

If one session touches **both**, finish **both** PRs/MRs in the same session (same pattern as
Hephaestus dual-repo delivery).

