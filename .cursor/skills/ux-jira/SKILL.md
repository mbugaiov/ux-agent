---
name: ux-jira
description: File or update Jira UX findings from Athena runs. Use when creating impl-ux tickets or handing off to impl-dev.
---

# UX Jira

Read `projects/<slug>/project.yaml` → `jira` first. If `jira.enabled` is false, skip filing
unless the user asks to enable tracking.

## Epic

Use **`jira.epic_key`** from the live project config — the **same product epic** as
Hephaestus. **Do not create a separate UX epic.**

Create **child Tasks** under that epic for Athena polish / findings / Hephaestus kicks.

## Labels

| Labels | Who owns | Hephaestus factory? |
|--------|----------|---------------------|
| `impl-ux` (+ product labels) | Athena | **No** — charter / polish track only |
| `ux-charter-first` + `impl-dev` | Design-first redesign | **Yes** — charter kick **before** implement until `UX_CHARTER_READY` |
| `impl-ux` + `impl-dev` | Athena found bug → Hephaestus ships | **Yes** — factory `pickup_label` |
| `impl-dev` only | Normal product work | Yes (not Athena-owned) |
| `needs-ux-pass` (+ `impl-dev`) | Polish after implement | Yes — Mode A kick after code |

Also apply `jira.default_labels` from project.yaml (product slug labels live only there —
never hardcode them in engine skills).

## When to file

1. **Feature ticket (preferred for L5):** grooming adds **`needs-ux-pass`** (+ `impl-dev`) on the **same** product ticket under `jira.epic_key`. Hephaestus wakes Athena Mode A after implement (`dev-ux-subagent`).
2. **Full redesign (design-first):** same ticket with **`ux-charter-first`** + `impl-dev` + usually `needs-ux-pass`. Hephaestus wakes Athena Mode B **before** implement; Athena posts **`UX_CHARTER_READY`**; then implement → Mode A polish.
3. **Charter-only UX** (no `impl-dev` yet): child under epic with **`impl-ux`**, optional pilot branch; add `impl-dev` after charter when ready to ship.
4. **Athena found a code defect Hephaestus should ship later:** add **`impl-dev`**, leave **To Do**.
5. **Athena already implemented on pilot and user says merge** → **`impl-ux`**, MR → Validate/Testing.

## Filing checklist

Prefer app grooming (`groomed_jira_ticket.py` / jira-ticket-grooming skill). Include:

1. Surface + `pilot_branch` name
2. Detect JSON excerpt or screenshots when available
3. Acceptance: preview on pilot → MR to `main` → STG from `main` only
4. Parent = `jira.epic_key` (product epic — never a new epic)
5. Labels per table above

## Do not

- Create a second / UX-only epic
- Transition product tickets to **Done**
- Deploy or instruct deploy to STG from pilot branch
- Put epic keys or product slugs into **tracked engine** files (live `projects/<slug>/project.yaml` is OK)
