#!/usr/bin/env bash
# Smoke-test Athena UX pass notification delivery.
# Usage: bash scripts/test_pass_notify.sh <slug>
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SLUG="${1:-}"
if [[ -z "$SLUG" ]]; then
  echo "Usage: test_pass_notify.sh <slug>" >&2
  exit 2
fi
exec python3 "$ROOT/scripts/ux_pass_notify.py" --slug "$SLUG" --project "$ROOT/projects/$SLUG" --smoke
