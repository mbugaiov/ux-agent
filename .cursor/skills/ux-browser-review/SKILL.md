---
name: ux-browser-review
description: Mandatory live UI inspection via browser MCP — screenshots at 1440/1024/768/390. Use before UX_CHARTER_READY for redesigns that change first viewport, and before finishing Mode A polish.
---

# Browser review

Prompt-only design is **not** done. Athena must open the real UI.

## Targets

1. Local `npm run dev` when implementing / polishing on a feature branch (preferred).
2. Else `project.yaml` `base_url` (STG) — only valid for verifying **merged** main, not pilot-only work.

## Viewports (all four)

| Width | Intent |
|------:|--------|
| 1440 | Desktop composition |
| 1024 | Tablet / compressed desktop |
| 768 | Tablet |
| 390 | Mobile |

## Steps

1. Navigate primary flow from the ticket / charter.
2. Capture screenshots into:
   `projects/<slug>/runs/<run-id>/screenshots/{1440,1024,768,390}-<step>.png`
3. For each viewport note: hierarchy OK? primary CTA visible? row actions available?
   overflow / overlap / hover-only traps?
4. Re-fix Critical layout issues and **re-capture** (visual regression loop).

## Tools

Prefer Cursor MCP **`user-playwright`** (`browser_navigate`, `browser_resize`,
`browser_take_screenshot`, `browser_snapshot`). Fallback: any available browser MCP.

## Gates

| Mode | Gate |
|------|------|
| Mode B redesign (first viewport / IA change) | Screenshots of **current** STG or local baseline **before** locking direction; wire notes must cite viewport risks. Prefer posting 1–2 evidence paths in the `UX_CHARTER_READY` comment. |
| Mode A polish | Screenshots of **changed** surfaces at all four widths before returning to Hephaestus. |
| Clarity-only / non-visual | Skip with explicit `BROWSER_REVIEW_SKIP: <reason>` in `run.md`. |

## Forbidden

- Declaring charter or polish complete without screenshots (unless skip reason)
- Judging mobile by resizing a desktop mental model only
