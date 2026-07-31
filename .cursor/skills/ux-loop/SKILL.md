---
name: ux-loop
description: On-demand Athena pickup — either Hephaestus-kicked on a feature branch, or human charter. No standing daily redesign loop.
---

# UX loop (on-demand)

## Policy

- **No permanent / daily Athena loop.**
- Starts when: **Hephaestus wakes a UX Task subagent** (preferred for L5 feature work),
  human asks, or an `impl-ux` charter ticket exists.

## Step 0 — Teams notify (before work)

Post a Teams Adaptive Card with ticket / branch / surfaces / next run (on-demand):

```bash
python3 scripts/ux_pass_notify.py --slug <slug> \
  --ticket <KEY> --branch <feature-branch> \
  --surfaces 'components/…,lib/ui.ts' \
  --mode hephaestus-kick   # or: charter
```

Optional when `UX_FACTORY_TEAMS_WEBHOOK_URL` is set (same URL as Hephaestus → same channel).
Unset = quiet. Real failures print `UX_PASS_NOTIFY_FAILED`. Hephaestus should run this
**before** spawning the UX Task (`dev-ux-subagent` / `notify_ux_kick`).

## Mode A — Hephaestus kick (same feature branch)

Triggered by Hephaestus skill `dev-ux-subagent` after feature implement:

1. Stay on the **current app feature branch** (do not create `feat/ux-*` or checkout pilot).
2. Read ticket surfaces + `DESIGN.md` / `lib/ui.ts`.
3. Prefer `audit` / `polish` / `harden` / `critique`.
4. Commit UX fixes on this branch; return file list to Hephaestus.
5. Hephaestus continues gate → MR.

## Mode B — Charter / human (optional pilot)

0. Run `ux_pass_notify.py` with `--mode charter` (Step 0).
1. Read `projects/<slug>/project.yaml` + `project-memory.md`.
2. Work on `app.pilot_branch` only when the user explicitly wants a UX pilot.
3. Labels / handoff via `ux-jira` under the **product** epic (`jira.epic_key`).

## Optional backlog probe

JQL non-empty `impl-ux` / `needs-ux-pass` in To Do → one-shot wake; else idle.
**Do not** schedule fixed-interval redesign.
