---
name: ux-loop
description: Recurring UX factory tick — detect ledger gaps, optional critique slice. Not every tick redesigns. Use when user arms a UX loop or AGENT_LOOP_WAKE_*ux*.
---

# UX loop

## Policy

- Tick = **detect + ledger update**, not full redesign.
- Redesign / polish only when user or `impl-ux` charter says so.
- Prefer long intervals (e.g. daily) — UI detection is not a 5-minute drain.

## Tick steps

1. Read `projects/<slug>/project-memory.md` Design ledger.
2. Run `bash scripts/ux_detect.sh <slug>` (default scan paths from `project.yaml`).
3. If new high-severity findings: file/update Jira via `ux-jira`; do **not** auto-merge.
4. Update ledger; stop.

## Arm (Cursor)

```
/loop 86400 AGENT_LOOP_WAKE_<slug>ux
```

Or one-shot: tell the agent to run one UX tick for `<slug>`.
