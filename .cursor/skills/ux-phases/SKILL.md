---
name: ux-phases
description: Per-phase UX loop — context, detect, critique, propose on pilot branch, handoff to dev-agent. Use when executing an Athena UX engagement.
---

# UX phases

1. **Context** — Read `project.yaml`, `project-memory.md`, app `DESIGN.md` / `PRODUCT.md`.
2. **Scope** — Pick 1–2 surfaces; record in `run.md`.
3. **Detect** — `bash scripts/ux_detect.sh <slug> [paths…]` → save JSON under the run folder.
4. **Critique / audit** — Follow skill `ux-impeccable` (`/impeccable audit|critique|polish`).
5. **Propose** — List concrete UI changes; prefer minimal diffs that preserve brand.
6. **Implement (optional)** — Only on `pilot_branch`. Run app gate if code changes.
7. **Handoff** — Jira (`impl-ux` / `impl-dev`) + screenshots; update `project-memory.md`.
8. **Do not** merge to `main` or trigger STG from this phase without human approval.
