---
name: ux-loop
description: On-demand Athena pickup — Hephaestus-kicked polish, Hephaestus-kicked charter (ux-charter-first), or human charter. No standing daily redesign loop. Uses upgraded UX pipeline (architect → visual → browser → rules → a11y → Impeccable last).
---

# UX loop (on-demand)

## Policy

- **No permanent / daily Athena loop.**
- Starts when: **Hephaestus wakes a UX Task subagent** (preferred for L5 feature work),
  human asks, or an `impl-ux` / `ux-charter-first` charter ticket exists.
- Full pipeline: **`docs/UX-PIPELINE.md`**.

## Step 0 — Teams notify (before work)

```bash
python3 scripts/ux_pass_notify.py --slug <slug> \
  --ticket <KEY> --branch <feature-branch> \
  --surfaces 'components/…,lib/ui.ts' \
  --mode hephaestus-kick   # or: charter
```

Optional when `UX_FACTORY_TEAMS_WEBHOOK_URL` is set. Unset = quiet.

## Mode A — Hephaestus kick (polish, same feature branch)

Triggered **after** feature implement (`needs-ux-pass` / `impl-ux` / UI surfaces/diff):

1. Stay on the **current app feature branch** (no `feat/ux-*` pilot).
2. Context: ticket surfaces + app **`DESIGN.md`** (+ `lib/ui.ts` when present).
3. **`ux-browser-review`** — screenshots at 1440 / 1024 / 768 / 390 (or documented skip).
4. **`ux-ui-rules-review`** — Critical / Major / Minor; fix Critical.
5. StyleSeed **`ss-score` / `ss-review` / `ss-verify`** when a DESIGN/StyleSeed lock exists.
6. **`ux-a11y-review`** — vendored accessibility-agents + checklist; fix blockers.
7. **`ux-impeccable` last** — `audit` / `polish` / `harden` / `critique` only
   (avoid `craft` / `overdrive` / `delight` on mature UIs).
8. Commit UX fixes on this branch; return file list + screenshot paths to Hephaestus.
9. Hephaestus continues gate → MR.

## Mode B — Charter (design-first)

Triggered by `ux-charter-first` without `UX_CHARTER_READY`, or human charter ask.

0. `ux_pass_notify.py --mode charter` unless Hephaestus already notified.
1. Read `projects/<slug>/project.yaml` + `project-memory.md` + app **`DESIGN.md`**.
   If DESIGN.md marks a prior direction **failed / not accepted**, do not refine it.
2. **`ux-architect`** — load vendored **designer-skills** as needed; goals, flows, IA,
   states, responsive intent → `run.md` / `ia.md`.
3. **`ux-visual-direction`** — only after architect; **must** run vendored `ui-ux-pro-max`
   search on redesign; StyleSeed lock recommended; never override an **accepted** DESIGN.md
   without explicit ticket scope to supersede it. No Pro Max MCP.
4. Prefer **no product UI commits** in Mode B — IA / wire / freeze in
   `projects/<slug>/runs/<date>-<KEY>-…/`.
5. **`ux-browser-review`** baseline of current UI (STG or local) for first-viewport redesigns;
   cite viewport risks in the charter comment.
6. Stay on Hephaestus feature branch when kicked mid-ticket; `app.pilot_branch` only for
   explicit human pilot outside factory.
7. **Must** post tracker comment with exact sentinel **`UX_CHARTER_READY`**
   (+ short IA + chosen direction + screenshot paths):
   - **Jira** or **GitHub Issues** per `tracker.provider` (see `ux-jira`)
   Keep `ux-charter-first`; do not strip `impl-dev`.
8. Return `run.md` path to Hephaestus.

## Optional backlog probe

JQL / GitHub label probe for `impl-ux` / `needs-ux-pass` / `ux-charter-first` → one-shot wake.
**Do not** schedule fixed-interval redesign.
