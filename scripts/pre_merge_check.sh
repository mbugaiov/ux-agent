#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
bash tests/run_tests.sh
bash scripts/portability_check.sh
bash scripts/projects_isolation_check.sh
bash scripts/check_review_gate_fixtures.sh
echo "pre_merge_check: OK"
