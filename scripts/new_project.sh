#!/usr/bin/env bash
# Create projects/<slug>/ from _template.
# Usage: bash scripts/new_project.sh <slug> <app-repo-path> "<Display name>"
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SLUG="${1:-}"
APP_PATH="${2:-}"
NAME="${3:-$SLUG}"
if [[ -z "$SLUG" || -z "$APP_PATH" ]]; then
  echo "Usage: new_project.sh <slug> <app-repo-path> \"<Display name>\"" >&2
  exit 1
fi
DEST="$ROOT/projects/$SLUG"
if [[ -e "$DEST" ]]; then
  echo "Already exists: $DEST" >&2
  exit 1
fi
mkdir -p "$DEST"
cp -R "$ROOT/projects/_template/." "$DEST/"
# Resolve app path to absolute when possible
ABS_APP="$APP_PATH"
if [[ -d "$APP_PATH" ]]; then
  ABS_APP="$(cd "$APP_PATH" && pwd)"
fi
# Patch project.yaml placeholders (portable sed)
python3 - "$DEST/project.yaml" "$SLUG" "$NAME" "$ABS_APP" <<'PY'
import sys
from pathlib import Path
path, slug, name, app = sys.argv[1:5]
text = Path(path).read_text()
text = text.replace("<Project Name>", name).replace("<slug>", slug).replace("<App>", name)
text = text.replace("../../path/to/app", app)
Path(path).write_text(text)
PY
mkdir -p "$DEST/.secrets" "$DEST/runs" "$DEST/reports"
echo "Created $DEST"
echo "Edit project.yaml (pilot_branch, base_url) then run: bash scripts/new_run.sh $SLUG detect baseline"
