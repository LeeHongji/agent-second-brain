#!/usr/bin/env bash
# bin/setup-excalidraw.sh — one-time opt-in: provision the Excalidraw → SVG renderer
# for the wiki-teach skill's hand-drawn architecture/framework diagrams.
#
# Installs NOTHING globally. It warms the npx cache for @moona3k/excalidraw-export
# (pure roughjs, no browser/DOM) and smoke-renders a 2-box diagram to confirm the
# pipeline works on this machine.
#
# Usage: bash bin/setup-excalidraw.sh
set -uo pipefail
cd "$(git rev-parse --show-toplevel 2>/dev/null || echo .)"

echo "[1/3] checking node/npx ..."
command -v npx >/dev/null 2>&1 || { echo "FAIL: npx not found (install Node ≥ 18 first)."; exit 1; }
node -e 'process.exit(/v(\d+)\./.exec(process.version)[1] >= 18 ? 0 : 1)' 2>/dev/null || echo "WARN: node < 18 — exporter may fail."

echo "[2/3] warming npx cache for @moona3k/excalidraw-export (no global install) ..."
npx -y @moona3k/excalidraw-export --version >/dev/null 2>&1 || true

echo "[3/3] smoke-render a 2-box .excalidraw → SVG ..."
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
cat > "$TMP/smoke.excalidraw" <<'JSON'
{
  "type": "excalidraw", "version": 2, "source": "setup-excalidraw-smoke",
  "elements": [
    { "type": "rectangle", "version": 1, "versionNonce": 1, "isDeleted": false, "id": "r1",
      "fillStyle": "hachure", "strokeWidth": 1, "strokeStyle": "solid", "roughness": 1,
      "opacity": 100, "angle": 0, "x": 60, "y": 60, "strokeColor": "#1e1e1e",
      "backgroundColor": "transparent", "width": 220, "height": 110, "seed": 1,
      "groupIds": [], "boundElements": [], "updated": 1, "link": null, "locked": false,
      "roundness": { "type": 3 } },
    { "type": "text", "version": 1, "versionNonce": 2, "isDeleted": false, "id": "t1",
      "fillStyle": "solid", "strokeWidth": 1, "strokeStyle": "solid", "roughness": 1,
      "opacity": 100, "angle": 0, "x": 110, "y": 100, "strokeColor": "#1e1e1e",
      "backgroundColor": "transparent", "width": 120, "height": 28, "seed": 2,
      "groupIds": [], "boundElements": [], "updated": 1, "link": null, "locked": false,
      "roundness": null, "fontSize": 20, "fontFamily": 1, "text": "smoke",
      "textAlign": "center", "verticalAlign": "middle", "baseline": 18,
      "containerId": null, "originalText": "smoke" }
  ],
  "appState": { "viewBackgroundColor": "#ffffff" }, "files": {}
}
JSON

if npx -y @moona3k/excalidraw-export "$TMP/smoke.excalidraw" --svg -o "$TMP/smoke.svg" >/dev/null 2>&1 \
   && [ -s "$TMP/smoke.svg" ]; then
  echo ""
  echo "OK: Excalidraw pipeline ready."
  echo "    render a diagram:  bash scripts/excalidraw-render.sh <in.excalidraw> <out.svg>"
  echo "    (each SVG embeds the Virgil hand-drawn font ≈ 70 KB)"
  exit 0
fi

echo ""
echo "FAIL: smoke render produced no SVG."
echo "      fallback path: use mermaid-cli (already installed) →  mmdc -i <name>.mmd -o <name>.svg"
exit 1
