#!/usr/bin/env bash
# Run Impeccable detect against the app repo for <slug>.
# Usage: bash scripts/ux_detect.sh <slug> [relative-path ...]
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SLUG="${1:-}"
shift || true
if [[ -z "$SLUG" ]]; then
  echo "Usage: ux_detect.sh <slug> [paths…]" >&2
  exit 1
fi
PROJ="$ROOT/projects/$SLUG"
YAML="$PROJ/project.yaml"
if [[ ! -f "$YAML" ]]; then
  echo "Missing $YAML" >&2
  exit 1
fi
APP=$(python3 - "$YAML" <<'PY'
import sys, re
text = open(sys.argv[1]).read()
m = re.search(r"repo_path:\s*(.+)", text)
if not m:
    sys.exit("repo_path missing in project.yaml")
print(m.group(1).strip().strip('"').strip("'"))
PY
)
if [[ ! -d "$APP" ]]; then
  echo "app.repo_path not a directory: $APP" >&2
  exit 1
fi
# Default paths from yaml if none passed (bash 3.2–compatible)
if [[ "$#" -eq 0 ]]; then
  PATHS=()
  while IFS= read -r p; do
    [[ -n "$p" ]] && PATHS+=("$p")
  done < <(python3 - "$YAML" <<'PY'
import sys, re
text = open(sys.argv[1]).read()
block = re.search(r"default_scan_paths:\n((?:\s+-\s+.+\n)+)", text)
if not block:
    print("components/")
    raise SystemExit
for line in block.group(1).splitlines():
    m = re.search(r"-\s+(\S+)", line)
    if m:
        print(m.group(1))
PY
)
  [[ ${#PATHS[@]} -eq 0 ]] && PATHS=("components/")
else
  PATHS=("$@")
fi
OUT_DIR=$(ls -dt "$PROJ/runs/"*detect* 2>/dev/null | head -1 || true)
if [[ -z "${OUT_DIR:-}" ]]; then
  bash "$ROOT/scripts/new_run.sh" "$SLUG" detect "cli-scan" >/dev/null
  OUT_DIR=$(ls -dt "$PROJ/runs/"*detect* | head -1)
fi
OUT_JSON="$OUT_DIR/detect.json"
cd "$APP"
echo "ux_detect: app=$APP paths=${PATHS[*]}"
if ! npx --yes impeccable detect --json "${PATHS[@]}" > "$OUT_JSON" 2>"$OUT_DIR/detect.stderr"; then
  echo "ux_detect: impeccable exited non-zero (see $OUT_DIR/detect.stderr)" >&2
  # Still keep JSON if produced
fi
echo "Wrote $OUT_JSON"
