#!/usr/bin/env bash
# Create a UX run folder under projects/<slug>/runs/
# Usage: bash scripts/new_run.sh <slug> <type> "<task>"
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SLUG="${1:-}"
TYPE="${2:-}"
TASK="${3:-}"
if [[ -z "$SLUG" || -z "$TYPE" || -z "$TASK" ]]; then
  echo "Usage: new_run.sh <slug> <type> \"<task>\"" >&2
  echo "Types: detect | audit | critique | polish | redesign" >&2
  exit 1
fi
case "$TYPE" in
  detect|audit|critique|polish|redesign) ;;
  *) echo "Unknown type: $TYPE" >&2; exit 1 ;;
esac
PROJ="$ROOT/projects/$SLUG"
if [[ ! -f "$PROJ/project.yaml" ]]; then
  echo "Missing project: $PROJ/project.yaml" >&2
  exit 1
fi
SAFE_TASK=$(echo "$TASK" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g' | cut -c1-48)
DATE=$(date +%Y-%m-%d)
RUN="$PROJ/runs/${DATE}-${TYPE}-${SAFE_TASK}"
mkdir -p "$RUN"
cat > "$RUN/run.md" <<EOF
# UX run — ${TYPE}

- **Slug:** ${SLUG}
- **Date:** ${DATE}
- **Task:** ${TASK}
- **Pilot branch:** (see project.yaml \`app.pilot_branch\`)
- **STG:** do not deploy from pilot — preview locally only

## Scope

<!-- surfaces -->

## Findings

<!-- link detect.json / screenshots -->

## Decisions

<!-- keep / waive / handoff to impl-dev -->
EOF
if [[ "$TYPE" == "detect" ]]; then
  touch "$RUN/detect.json"
fi
echo "Created $RUN"
