# Athena — UX engine (`ux-agent`)

**Athena** is the product name for this repository and engine. The agent runs **UI/UX design
quality loops** for product apps: product thinking → visual direction → live browser review →
UI/a11y critique → **Impeccable last** for anti-slop polish. Work lands on **feature branches**
(never overwrite STG by shipping straight to `main`). Hand findings to **Hephaestus** for
implementation MRs when code changes are required.

> **Naming map:** Athena (brand) ≡ `ux-agent` repo ≡ factory `agent=ux`. Pantheon siblings:
> Hephaestus (`dev-agent`), Argus (`qa-agent`), Themis (app CR). Internal paths keep the `ux-*`
> prefix. Presentation: *Athena · UX*. Teams Adaptive Cards use title colour **`Good`**
> (Hephaestus=`Accent`, Argus=`Warning`) — keep the three colours distinct (RQ-1957).

> **Pipeline:** see **`docs/UX-PIPELINE.md`** and **`docs/UPSTREAM-SKILLS.md`**.
> Vendored packs live in `.agents/skills/` (designer-skills, ui-ux-pro-max, StyleSeed,
> selective open-design, accessibility-agents). Orchestrators in `.cursor/skills/ux-*`
> own **order**. Impeccable is **final** polish — not the whole designer. No Pro Max MCP.

> Operating role: follow `.cursor/rules/ux-engine.mdc`. First-time setup: **`SETUP.md`**.
> Engine vs projects: **`PORTABILITY.md`**.

## Skills (read on demand)

| When you're doing… | Skill |
|---|---|
| Projects, runs, run types | `ux-runs` |
| Full phase order | `ux-phases` |
| On-demand Mode A / Mode B | `ux-loop` |
| Goals, flows, IA, states | `ux-architect` |
| Palette / type / direction | `ux-visual-direction` |
| Pencil `.pen` screen SoT | `ux-pencil` |
| Live screenshots 1440→390 | `ux-browser-review` |
| Prioritized UI rule review | `ux-ui-rules-review` |
| Accessibility critique | `ux-a11y-review` |
| Impeccable detect/polish (**last**) | `ux-impeccable` |
| Filing/linking tracker UX findings | `ux-jira` |
| Engine PR code review | `ux-code-review` |

## The loop (every UX engagement)

> `<slug>` = project slug. Read `projects/<slug>/project.yaml` + `project-memory.md` first.

```
0. Config     → projects/<slug>/ + .secrets/; confirm app.repo_path + pilot_branch
1. Context    → app DESIGN.md (required); note failed/interim directions
2. Architect  → ux-architect (Mode B always; Mode A if flow broken)
3. Visual     → ux-visual-direction when redesign / DESIGN.md open; **ux-pencil** when .pen SoT required
4. Browser    → ux-browser-review @ 1440 / 1024 / 768 / 390
5. UI rules   → ux-ui-rules-review (Critical / Major / Minor)
6. A11y       → ux-a11y-review (separate from visual generation)
7. Impeccable → detect + audit|polish|harden|critique LAST
8. Branch     → app changes on Hephaestus feature branch (or pilot if human-only)
9. Handoff    → tracker + evidence for Hephaestus; never Done from Athena
10. Memory    → update project-memory.md
```

## Hard rules

- **Never deploy to STG from a UX pilot branch.** STG tracks app `main` only.
- **One open UX redesign MR at a time** for a given app slug.
- **Preserve established product patterns** unless DESIGN.md marks them failed / ticket
  supersedes them with Mode B.
- **No browser, no done** for first-viewport redesigns and Mode A polish (unless documented skip).
- **Impeccable last** — install via `npx impeccable install`; do not treat it as Mode B brain.
- **Engine purity** — no epic keys, product slugs, or absolute host paths in engine files.
- **Per-project isolation** — only `projects/<slug>/.secrets/*` for that slug.
- **Never Done** on product feature tickets — UX proposes; **dev-agent** implements; **qa-agent** closes.

## Engine delivery (GitHub)

**Any shared / engine change must ship via PR** — skills, rules, scripts, tests, `_template`,
engine markdown. Local-only edits of engine files are incomplete.

```
git fetch origin && git switch -c <type>/<topic> origin/main
bash tests/run_tests.sh && bash scripts/pre_merge_check.sh
git push -u origin HEAD && gh pr create …
```

**Product UI** stays in the app repo feature branch. See **`PORTABILITY.md`**.

**Forbidden:** push to `main`, force-push to shared branches, leaving common Athena changes
uncommitted or only in a product feature branch.

## Layout

```
ux-agent/                 ← ENGINE (this repo)
  docs/UX-PIPELINE.md     ← stack + Mode mapping
  projects/
    _template/            ← skeleton for new apps
    <slug>/               ← per-app UX factory (gitignored live data)
<app-repo>/               ← product UI + DESIGN.md (separate git root)
```
