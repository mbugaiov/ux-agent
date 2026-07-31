---
name: ux-loop
description: On-demand Athena pickup — either Hephaestus-kicked on a feature branch, or human charter. No standing daily redesign loop.
---

# UX loop (on-demand)

## Policy

- **No permanent / daily Athena loop.**
- Starts when: **Hephaestus wakes a UX Task subagent** (preferred for L5 feature work),
  human asks, or an `impl-ux` charter ticket exists.

## Mode A — Hephaestus kick (same feature branch)

Triggered by Hephaestus skill `dev-ux-subagent` after feature implement:

1. Stay on the **current app feature branch** (do not create `feat/ux-*` or checkout pilot).
2. Read ticket surfaces + `DESIGN.md` / `lib/ui.ts`.
3. Prefer `audit` / `polish` / `harden` / `critique`.
4. Commit UX fixes on this branch; return file list to Hephaestus.
5. Hephaestus continues gate → MR.

## Mode B — Charter / human (optional pilot)

1. Read `projects/<slug>/project.yaml` + `project-memory.md`.
2. Work on `app.pilot_branch` only when the user explicitly wants a UX pilot.
3. Labels / handoff via `ux-jira` under the **product** epic (`jira.epic_key`).

## Optional backlog probe

JQL non-empty `impl-ux` / `needs-ux-pass` in To Do → one-shot wake; else idle.
**Do not** schedule fixed-interval redesign.
