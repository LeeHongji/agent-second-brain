#!/usr/bin/env bash
# scripts/excalidraw-render.sh — render an Excalidraw master to a hand-drawn SVG.
#
# Usage: bash scripts/excalidraw-render.sh <input.excalidraw> <output.svg>
#
# Uses @moona3k/excalidraw-export (pure roughjs, NO browser/DOM) via npx — no global
# install required. Used by the wiki-teach skill for architecture/framework diagrams.
#
# Exit codes:
#   0 — SVG rendered
#   1 — render failed (agent should fall back to:  mmdc -i <name>.mmd -o <output.svg>)
#   2 — usage / missing input
set -uo pipefail

if [ "$#" -ne 2 ]; then
  echo "usage: $0 <input.excalidraw> <output.svg>" >&2
  exit 2
fi

in="$1"
out="$2"
[ -f "$in" ] || { echo "ERR: input not found: $in" >&2; exit 2; }
mkdir -p "$(dirname "$out")"

if npx -y @moona3k/excalidraw-export "$in" --svg -o "$out"; then
  echo "rendered: $out"
  exit 0
fi

echo "ERR: excalidraw-export failed for $in" >&2
echo "     fallback: author mermaid and run:  mmdc -i <name>.mmd -o \"$out\"" >&2
exit 1
