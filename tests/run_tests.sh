#!/usr/bin/env bash
# Self-tests for the UX Agent engine (offline).
set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
export PYTHONPATH="$ROOT${PYTHONPATH:+:$PYTHONPATH}"
SLUG="ux-selftest"
PASS=0; FAIL=0
ok()  { PASS=$((PASS+1)); echo "  ✓ $1"; }
no()  { FAIL=$((FAIL+1)); echo "  ✗ $1"; }
have(){ [[ -e "$1" ]] && ok "exists: $1" || no "missing: $1"; }

cleanup(){ rm -rf "projects/$SLUG"; }
trap cleanup EXIT
cleanup

chmod +x scripts/*.sh

echo "== 1. Scaffold =="
have AGENTS.md
have SETUP.md
have PORTABILITY.md
have .cursor/rules/ux-engine.mdc
have .cursor/rules/code-review.mdc
for s in ux-runs ux-phases ux-loop ux-impeccable ux-jira ux-code-review; do
  have ".cursor/skills/$s/SKILL.md"
done

echo "== 2. new_project.sh =="
TMPAPP=$(mktemp -d)
./scripts/new_project.sh "$SLUG" "$TMPAPP" "Self Test" >/dev/null 2>&1 || no "new_project.sh"
have "projects/$SLUG/project.yaml"
have "projects/$SLUG/project-memory.md"
grep -q "Self Test" "projects/$SLUG/project.yaml" && ok "name patched" || no "name patched"
rm -rf "$TMPAPP"

echo "== 3. new_run.sh =="
./scripts/new_run.sh "$SLUG" detect "baseline scan" >/dev/null 2>&1 || no "new_run"
RUN=$(ls -d projects/$SLUG/runs/*detect* 2>/dev/null | head -1)
[[ -f "$RUN/run.md" ]] && ok "run.md" || no "run.md"
[[ -f "$RUN/detect.json" ]] && ok "detect.json seeded" || no "detect.json"

echo "== 4. Review gate fixtures =="
if bash scripts/check_review_gate_fixtures.sh >/dev/null; then ok "fixtures"; else no "fixtures"; fi

echo "== 5. Skills mention pilot safety =="
grep -q "pilot" .cursor/skills/ux-phases/SKILL.md && ok "phases pilot" || no "phases pilot"
grep -q "impeccable" .cursor/skills/ux-impeccable/SKILL.md && ok "impeccable skill" || no "impeccable skill"

echo
echo "Result: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]]
