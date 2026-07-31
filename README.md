# Athena

**Athena** is the UX engine — this repository (`ux-agent`). An agent-driven **UI/UX factory**
built on [Impeccable](https://github.com/pbakaus/impeccable): detect AI-slop and a11y/layout
issues, critique product surfaces, and propose careful visual improvements on **feature
branches** so staging stays stable until a reviewed MR merges to `main`.

> **Naming:** Athena is the product name (*Athena · UX*). Folder `ux-agent/`, skills `ux-*`,
> factory `agent=ux`.

Mirrors **Hephaestus** (`dev-agent`) and **Argus** (`qa-agent`): shared **engine** + per-app
**`projects/<slug>/`**. Read **`SETUP.md`** first; **`AGENTS.md`** for the loop;
**`PORTABILITY.md`** for multi-repo layouts.

## Quickstart

```bash
# 1. Clone engine
git clone git@github.com:mbugaiov/ux-agent.git
cd ux-agent

# 2. Create a project (once per app)
bash scripts/new_project.sh myapp /absolute/path/to/app-repo "My App"

# 3. Fill projects/myapp/project.yaml (pilot_branch, base_url) + .secrets if needed

# 4. Tell the agent (Cursor Agent chat):
#    "Run a UX detect + audit on projects/myapp landing and dashboard — pilot branch only"
```

## What Athena owns vs siblings

| Concern | Owner |
|---------|--------|
| Design detect / critique / DESIGN.md | **ux-agent** (Athena) |
| Implement + Bitbucket MR + STG deploy | **dev-agent** (Hephaestus) |
| Functional / security STG validation | **qa-agent** (Argus) |
| App PR review policy | App repo (Themis) |

## Safety model (the app and similar)

1. UX work lands on **`pilot_branch`** (e.g. `feat/ux-impeccable-pilot`).
2. Bitbucket **STG deploy runs only from `main`** — pilot branch never auto-deploys.
3. Humans preview locally (`npm run dev`) or a **preview deploy** if configured.
4. After approval, squash-merge pilot → `main` via normal the app MR pipeline.

## Layout

| Path | Purpose |
|------|---------|
| `SETUP.md` | Project setup, Impeccable install, first run |
| `AGENTS.md` | Loop + hard rules + skill index |
| `PORTABILITY.md` | Engine vs projects split |
| `.cursor/skills/` | `ux-runs`, `ux-phases`, `ux-loop`, `ux-impeccable`, `ux-jira`, `ux-code-review` |
| `.cursor/rules/` | `ux-engine`, `code-review` |
| `scripts/` | `new_project`, `new_run`, `ux_detect`, gates, CR |
| `projects/_template/` | Skeleton only (live projects gitignored) |

## Engine CI

GitHub Actions: **CI** (`test`) + **Code Review** (`review`) + **Auto-merge when green** —
same pattern as `dev-agent` / `qa-agent`. Requires `CURSOR_API_KEY` secret for review.

## License

Engine code for brand internal use. Impeccable is Apache-2.0 (upstream).
