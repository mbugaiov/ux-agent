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

| Artifact | Repo |
|----------|------|
| `PRODUCT.md` / `DESIGN.md` / Impeccable install | **App** (pilot branch) |
| Detect/critique orchestration, run ledger | **ux-agent** `projects/<slug>/` |
| Feature implementation MR | **App** via **dev-agent** |
| STG deploy | App `main` CI only |
