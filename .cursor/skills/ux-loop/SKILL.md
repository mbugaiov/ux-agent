---
name: ux-loop
description: On-demand Athena pickup — Hephaestus-kicked polish, Hephaestus-kicked charter (ux-charter-first), or human charter. No standing daily redesign loop.
---

# UX loop (on-demand)

## Policy

- **No permanent / daily Athena loop.**
- Starts when: **Hephaestus wakes a UX Task subagent** (preferred for L5 feature work),
  human asks, or an `impl-ux` / `ux-charter-first` charter ticket exists.

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

## Mode A — Hephaestus kick (polish, same feature branch)

Triggered by Hephaestus skill `dev-ux-subagent` **after** feature implement
(`needs-ux-pass` / `impl-ux` / UI surfaces/diff):

1. Stay on the **current app feature branch** (do not create `feat/ux-*` or checkout pilot).
2. Read ticket surfaces + `DESIGN.md` / `lib/ui.ts`.
3. Prefer `audit` / `polish` / `harden` / `critique`.
4. Commit UX fixes on this branch; return file list to Hephaestus.
5. Hephaestus continues gate → MR.

## Mode B — Charter (design-first)

Triggered by:

- Hephaestus when Jira has **`ux-charter-first`** and no **`UX_CHARTER_READY`** yet
  (`should_kick_ux.ts --when before-implement`), **or**
- Human asks for a charter / pilot.

Steps:

0. Run `ux_pass_notify.py` with `--mode charter` (Step 0) unless Hephaestus already notified.
1. Read `projects/<slug>/project.yaml` + `project-memory.md` + app `DESIGN.md`.
2. Prefer **no product UI commits** — produce IA / wire / freeze in
   `projects/<slug>/runs/<date>-<KEY>-…/run.md` (+ optional `ia.md`).
3. Stay on Hephaestus feature branch when kicked mid-ticket; use `app.pilot_branch` only
   when the user explicitly wants a UX pilot outside factory.
4. **Must** post a Jira comment containing the exact sentinel **`UX_CHARTER_READY`**
   (plus short IA summary). Keep `ux-charter-first`; do not strip `impl-dev`.
5. Return `run.md` path to Hephaestus so implement can proceed.

Labels / handoff details: skill `ux-jira`.

## Optional backlog probe

JQL non-empty `impl-ux` / `needs-ux-pass` / `ux-charter-first` in To Do → one-shot wake; else idle.
**Do not** schedule fixed-interval redesign.
