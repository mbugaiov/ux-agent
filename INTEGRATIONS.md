# Dependencies / integrations

| Source | How used |
|--------|----------|
| [pbakaus/impeccable](https://github.com/pbakaus/impeccable) | Design skill, CLI `detect`, optional Cursor hooks |
| Hephaestus (`dev-agent`) | **Wakes Athena as a Cursor Task subagent** on the **same feature branch** when Jira has `needs-ux-pass` / `impl-ux` or UI surfaces/diff (skill `dev-ux-subagent`, `should_kick_ux.ts`). Hephaestus still owns MR → STG → handoff. |
| Argus (`qa-agent`) | Functional/a11y STG validation after merge |
| App CR (Themis) | Product MR review in app repo |

## Where code goes

| Change type | Repo / branch | Ship |
|-------------|---------------|------|
| Shared Athena (skills, scripts, rules, `_template`, engine docs) | **`ux-agent` engine** | **GitHub PR** — mandatory |
| Live `projects/<slug>/` (yaml, memory, runs) | Local gitignored project | Note in engine PR if relevant; do not commit secrets |
| App UI / DESIGN / components | **App feature branch** (Hephaestus or charter) | Bitbucket MR to app `main` |

If a session changes **both** engine and app, open **both** PRs/MRs and merge both before
calling the work done (`PORTABILITY.md` dual delivery).


```
Grooming (needs-ux-pass if UI)
  → Hephaestus picks impl-dev
  → feature branch + implement
  → Task(generalPurpose) Athena UX pass on THAT branch
  → gate → MR → STG → Validate
```

- **No standing UX loop.** No separate UX epic (product epic only).
- Prefer `audit` / `polish` / `harden` / `critique`.
- When kicked mid-ticket: **do not** switch to `pilot_branch`; stay on Hephaestus feature branch.
- Charter-only Athena work (human asks polish outside a feature ticket) may still use `pilot_branch` from `project.yaml`.
- Never STG-deploy from a UX-only pilot; never Done on product tickets from Athena.

Impeccable license: Apache-2.0. Follow upstream install (`npx impeccable install`).
