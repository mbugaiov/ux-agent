# UX Agent — host setup

## Cursor

1. Open `ux-agent` as a workspace (or multi-root with the app).
2. Enable Agent Skills (Cursor Settings → Rules / Skills).
3. Optional: install Impeccable globally for experimentation; prefer **project-scope**
   install inside each app repo (`SETUP.md` §3).

## Tooling

```bash
node -v    # 20+
npm -v
npx impeccable --help
gh auth status
```

## Secrets

- Engine GitHub: `CURSOR_API_KEY` for PR Code Review workflow.
- Per project: `projects/<slug>/.secrets/` (Jira optional) — never commit.

## Sibling engines

| Engine | Typical path |
|--------|----------------|
| Hephaestus | `../dev-agent` |
| Argus | `../qa-agent` |
| Athena | this repo |

Do not run UX redesign loops against STG production data without a pilot branch.
