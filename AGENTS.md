# Athena — UX engine (`ux-agent`)

**Athena** is the product name for this repository and engine. The agent runs **UI/UX design
quality loops** for product apps: encode brand/design context, run Impeccable detectors and
critique/audit skills, propose careful visual fixes on **feature branches** (never overwrite
STG by shipping straight to `main`), and hand findings to the **dev agent** for implementation
MRs when code changes are required.

> **Naming map:** Athena (brand) ≡ `ux-agent` repo ≡ factory `agent=ux`. Pantheon siblings:
> Hephaestus (`dev-agent`), Argus (`qa-agent`), Themis (app CR). Internal paths keep the `ux-*`
> prefix. Presentation: *Athena · UX*.

> **Design spine:** [Impeccable](https://github.com/pbakaus/impeccable) — skills, 23 commands,
> 59 deterministic detectors. This engine **orchestrates** Impeccable; it does not fork the
> detector rule set unless a project needs brand-specific waivers.

> Operating role: follow `.cursor/rules/ux-engine.mdc`. First-time setup: **`SETUP.md`**.
> Engine vs projects: **`PORTABILITY.md`**.

## Skills (read on demand)

| When you're doing… | Skill |
|---|---|
| Projects, runs, run types | `ux-runs` |
| Per-phase how-to (ingest → detect → critique → propose → handoff) | `ux-phases` |
| Recurring UX loop tick | `ux-loop` |
| Impeccable install, detect, audit, DESIGN.md | `ux-impeccable` |
| Filing/linking Jira UX findings | `ux-jira` |
| Engine PR code review | `ux-code-review` |

## The loop (every UX engagement)

> `<slug>` = project slug. Read `projects/<slug>/project.yaml` + `project-memory.md` first.

```
0. Config     → projects/<slug>/ + .secrets/; confirm app.repo_path + pilot_branch
1. Context    → PRODUCT.md / DESIGN.md in app (Impeccable init if missing)
2. Detect     → npx impeccable detect (or scripts/ux_detect.sh) → JSON findings
3. Critique   → /impeccable audit|critique on scoped surfaces (skill ux-impeccable)
4. Propose    → write run artifacts under projects/<slug>/runs/…; NEVER push to main
5. Branch     → app changes only on pilot_branch (e.g. feat/ux-impeccable-pilot)
6. Handoff    → Jira impl-dev / impl-ux ticket + evidence for Hephaestus to ship MR
7. Memory     → update project-memory.md (ledger, next surface, waivers)
```

## Hard rules

- **Never deploy to STG from a UX pilot branch.** STG tracks app `main` only. Pilot UI lives on
  `pilot_branch` until humans approve and a normal MR merges to `main`.
- **One open UX redesign MR at a time** for a given app slug.
- **Preserve established product patterns** — brand brand tokens, existing dashboard language.
  Prefer `audit` / `polish` / `harden` over `craft` / `overdrive` / `delight` on mature UIs.
- **Impeccable as spine** — install via `npx impeccable install`; do not vendor a full fork.
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

**Product UI** stays in the app repo feature branch (Bitbucket MR). See **`PORTABILITY.md`**
dual delivery.

**Forbidden:** push to `main`, force-push to shared branches, leaving common Athena changes
uncommitted or only in a product feature branch.

## Layout

```
ux-agent/                 ← ENGINE (this repo)
  projects/
    _template/            ← skeleton for new apps
    <slug>/               ← per-app UX factory (gitignored live data)
<app-repo>/               ← product UI + DESIGN.md (separate git root)
```
