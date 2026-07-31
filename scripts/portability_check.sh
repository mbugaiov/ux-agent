#!/usr/bin/env bash
# Portability gate: tracked engine files must not hardcode a live project slug or product.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
FORBIDDEN='(\blrm\b|sol-ark|solark|qa_lab_resource_management|/Users/max/Downloads)'
PATHS=(.cursor scripts templates tests AGENTS.md PORTABILITY.md SETUP.md HOST_SETUP.md README.md ENGINE-REVIEW.md INTEGRATIONS.md)
FAIL=0
while IFS= read -r f; do
  [[ -z "$f" ]] && continue
  [[ "$f" == "scripts/portability_check.sh" ]] && continue
  while IFS= read -r line; do
    echo "$line" | grep -q 'e\.g\. `<slug>`' && continue
    echo "$line" | grep -q 'e\.g\. <slug>' && continue
    echo "portability leak: $line"
    FAIL=1
  done < <(git grep -nE "$FORBIDDEN" -- "$f" 2>/dev/null || true)
done < <(git ls-files "${PATHS[@]}" 2>/dev/null || true)
if [[ "$FAIL" -eq 0 ]]; then
  echo "portability: OK (no project-specific leaks in tracked engine files)"
fi
exit "$FAIL"
