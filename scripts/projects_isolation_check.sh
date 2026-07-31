#!/usr/bin/env bash
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
FAIL=0
while IFS= read -r f; do
  [[ -z "$f" ]] && continue
  case "$f" in
    projects/_template/*) ;;
    *)
      echo "project leak (tracked in git): $f"
      FAIL=1
      ;;
  esac
done < <(git ls-files 'projects/' 2>/dev/null || true)
if ! grep -qE '^projects/\*' .gitignore; then
  echo "gitignore gap: missing 'projects/*' rule"
  FAIL=1
fi
if ! grep -q '!projects/_template/' .gitignore; then
  echo "gitignore gap: missing '!projects/_template/' exception"
  FAIL=1
fi
LIVE_PROBES=(
  projects/acme-corp/project.yaml
  projects/acme-corp/project-memory.md
  projects/acme-corp/runs/2026-07-01-detect-x/run.md
  projects/acme-corp/.secrets/jira.env
)
for probe in "${LIVE_PROBES[@]}"; do
  if git check-ignore -q "$probe" 2>/dev/null; then
    :
  else
    echo "gitignore gap: $probe is not ignored"
    FAIL=1
  fi
done
if [[ "$FAIL" -eq 0 ]]; then
  TRACKED=$(git ls-files 'projects/' 2>/dev/null | wc -l | tr -d ' ')
  echo "projects isolation: OK (only projects/_template/ tracked; ${TRACKED} template file(s))"
fi
exit "$FAIL"
