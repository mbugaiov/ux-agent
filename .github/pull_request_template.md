## Summary

<!-- What changed and why (1–3 sentences) -->

## Type

- [ ] Engine feature
- [ ] Bug fix
- [ ] Skills / rules / templates
- [ ] Tests / CI / code review

## Pre-merge checklist

- [ ] `bash scripts/pre_merge_check.sh` passes locally
- [ ] No live project data — only `projects/_template/` if touching `projects/`
- [ ] No project-specific leaks (product slugs, private paths, real Jira keys)
- [ ] No secrets in the diff
- [ ] STG safety preserved (pilot branch model)

## Test plan

- [ ] `bash tests/run_tests.sh`
- [ ] `bash scripts/portability_check.sh`
- [ ] `bash scripts/projects_isolation_check.sh`
- [ ] CI green on this PR
