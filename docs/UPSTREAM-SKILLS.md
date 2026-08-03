# Upstream skills (vendored in `.agents/skills/`)

Installed via `npx skills add … --copy` into this engine. Locked by `skills-lock.json`.
**No MCP** for Pro Max (local skill + searchable DB only).

Orchestrators in `.cursor/skills/ux-*` decide **when** to load these; Cursor discovers
skills under `.agents/skills/` automatically.

## Inventory

| Source | What we installed | Count | Pipeline role |
|--------|-------------------|------:|---------------|
| [Owl-Listener/designer-skills](https://github.com/Owl-Listener/designer-skills) | **All** product-design skills | 96 | Mode B process depth (research → IA → interaction → critique → handoff) |
| [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | **`ui-ux-pro-max` only** | 1 | Mode B visual direction (styles / palettes / fonts / charts / stacks) |
| [bitjaru/styleseed](https://github.com/bitjaru/styleseed) | **All** (`ss-*`, `styleseed-design-review`) | 22 | Cross-screen consistency + scored gate (after direction lock) |
| [nexu-io/open-design](https://github.com/nexu-io/open-design) | `design-md`, `gpt-taste`, `brand-extract`, `reference-design-contract` | 4 | Extract / formalize product `DESIGN.md` from refs |
| [Community-Access/accessibility-agents](https://github.com/Community-Access/accessibility-agents) | `cognitive-accessibility`, `framework-accessibility`, `design-system` (token contrast), `accessibility-rules` | 4 | Mode A a11y pass (with `ux-a11y-review`) |

Refresh:

```bash
npx skills experimental_install   # from skills-lock.json
# or re-add packages listed above with -a cursor -y --copy
```

## Authority / conflict rules (why this is safe)

1. **App `DESIGN.md` wins** over StyleSeed defaults, Pro Max suggestions, and open-design taste
   when the product direction is **accepted**. Mode B may supersede only when the ticket is
   `ux-charter-first` and updates `DESIGN.md` on implement.
2. **Athena orchestrators win on order** — never run Pro Max / StyleSeed / Impeccable before
   `ux-architect` on a redesign.
3. **Impeccable stays last** (`ux-impeccable`) — even if open-design has polish-like skills.
4. **Argus owns STG acceptance** — upstream a11y skills are first-line only.

## Explicitly skipped (real conflict or wrong job)

| Source / skill | Why skipped |
|----------------|-------------|
| Pro Max `banner-design`, `slides`, `brand`, `design`, `design-system`, `ui-styling` | Marketing CIP / shadcn generators — fight product tokens and Hephaestus ownership |
| open-design (~160 other skills) | Video templates, Anthropic `brand-guidelines`, `frontend-design` generators, music, pets — noise |
| `gsd-build/gsd-2` | Only ships `gsd-orchestrator` (autonomous app builder) — **not** UserInterface Wiki. Keep thin `ux-ui-rules-review` |
| accessibility Office/PDF/legal/github-analytics skills | Wrong surface; several upstream SKILL.md YAML parse failures |
| Pro Max / ui-ux MCP | User opted out — local skill is enough |

## Mode mapping (mandatory upstream loads)

```text
Mode B:
  ux-architect
    → Read designer-skills as needed (design-brief, jobs-to-be-done, journey-map,
      information-architecture / content-strategy, interaction + ui-design skills,
      critique-* before freeze)
  design-md / gpt-taste / brand-extract / reference-design-contract
    → when creating or superseding DESIGN.md from refs
  ux-visual-direction
    → MUST run ui-ux-pro-max search script (see skill) before locking direction
  styleseed ss-setup / ss-tokens / ss-resolve (or styleseed-design-review)
    → lock decisions; merge into app DESIGN.md (do not leave a second competing bible)
  UX_CHARTER_READY

Mode A:
  ux-browser-review
  ux-ui-rules-review
  styleseed ss-score / ss-review / ss-verify (when STYLESEED / DESIGN lock exists)
  ux-a11y-review + cognitive-accessibility / framework-accessibility / design-system
  ux-impeccable last
```
