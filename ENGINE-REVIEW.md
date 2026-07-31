# Engine review checklist (Athena / ux-agent)

Before opening an engine PR:

1. `bash tests/run_tests.sh`
2. `bash scripts/portability_check.sh`
3. `bash scripts/projects_isolation_check.sh`
4. `bash scripts/check_review_gate_fixtures.sh`
5. Confirm no live `projects/<slug>/` data in the diff
6. Confirm Impeccable is referenced as upstream, not vendored wholesale unless intentional

See `.cursor/skills/ux-code-review/SKILL.md` and `.cursor/rules/code-review.mdc`.
