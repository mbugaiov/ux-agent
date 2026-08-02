# Dependencies / integrations

| Source | How used |
|--------|----------|
| [owl-listener/designer-skills](https://github.com/owl-listener/designer-skills) | Process inspiration → skill `ux-architect` (thin) |
| [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | Visual direction lookup → `ux-visual-direction` (optional host `npx skills add`) |
| [gsd-build/gsd-2](https://github.com/gsd-build/gsd-2) (userinterface-wiki) | Prioritized UI review → `ux-ui-rules-review` |
| [Community-Access/accessibility-agents](https://github.com/Community-Access/accessibility-agents) | A11y critique → `ux-a11y-review` |
| [pbakaus/impeccable](https://github.com/pbakaus/impeccable) | **Last** polish + CLI `detect` → `ux-impeccable` |
| Playwright MCP (`user-playwright`) | Live screenshots → `ux-browser-review` |
| App `DESIGN.md` | Product design language (styleseed-style consistency) |
| Hephaestus (`dev-agent`) | Wakes Athena Task: Mode B before implement (`ux-charter-first`); Mode A after (`needs-ux-pass`) |
| Argus (`qa-agent`) | Functional/a11y STG validation after merge |
| App CR (Themis) | Product MR review in app repo |

Do **not** install every upstream skill pack into the prompt at once — they contradict.
Canonical order: **`docs/UX-PIPELINE.md`**.

## Where code goes

| Change type | Repo / branch | Ship |
|-------------|---------------|------|
| Shared Athena (skills, scripts, rules, `_template`, engine docs) | **`ux-agent` engine** | **GitHub PR** — mandatory |
| Live `projects/<slug>/` (yaml, memory, runs) | Local gitignored project | Note in engine PR if relevant; do not commit secrets |
| App UI / DESIGN / components | **App feature branch** (Hephaestus or charter) | App MR/PR to `main` |

If a session changes **both** engine and app, open **both** PRs/MRs and merge both before
calling the work done (`PORTABILITY.md` dual delivery).

```
# Default (polish-after-dev)
Grooming (needs-ux-pass if UI)
  → Hephaestus picks impl-dev
  → feature branch + implement
  → Task Athena Mode A (browser → rules → a11y → Impeccable)
  → gate → MR → STG → Validate

# Design-first (full redesign)
Grooming (ux-charter-first + impl-dev + needs-ux-pass)
  → Hephaestus picks → branch + OpenSpec shell
  → Task Athena Mode B (architect → visual → browser baseline → UX_CHARTER_READY)
  → Hephaestus implements from charter
  → Task Athena Mode A
  → gate → MR → STG → Validate
```

- **No standing UX loop.** No separate UX epic (product epic only).
- When kicked mid-ticket: **do not** switch to `pilot_branch`; stay on Hephaestus feature branch.
- Never STG-deploy from a UX-only pilot; never Done on product tickets from Athena.

Impeccable license: Apache-2.0. Follow upstream install (`npx impeccable install`).
