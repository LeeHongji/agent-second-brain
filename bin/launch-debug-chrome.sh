#!/usr/bin/env bash
# Launch the dedicated debug-Chrome profile for web-access CDP automation.
#
# This is the "小号" browser for the agent: log into 公众号 / 小红书 / 微博 / 知乎
# in THIS window (one-time; persists in this profile). It runs ALONGSIDE your
# normal Chrome and never touches your default profile. web-access's CDP proxy
# connects to it on $PORT.
#
# Usage: bash bin/launch-debug-chrome.sh
set -euo pipefail

PROFILE="${WEB_ACCESS_CHROME_PROFILE:-$HOME/.web-access-chrome-profile}"
PORT="${WEB_ACCESS_DEBUG_PORT:-9222}"

if [ ! -x "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ]; then
  echo "ERR: Google Chrome not found in /Applications" >&2; exit 1
fi

# Already running on this port?
if pgrep -f "remote-debugging-port=$PORT" >/dev/null 2>&1; then
  echo "debug Chrome already running on $PORT (profile: $PROFILE)"; exit 0
fi

nohup "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --remote-debugging-port="$PORT" \
  --user-data-dir="$PROFILE" \
  --no-first-run --no-default-browser-check \
  >/dev/null 2>&1 &
disown

for i in $(seq 1 25); do
  curl -s --max-time 2 "http://127.0.0.1:$PORT/json/version" >/dev/null 2>&1 && break
  sleep 1
done

if curl -s --max-time 3 "http://127.0.0.1:$PORT/json/version" >/dev/null 2>&1; then
  echo "✓ debug Chrome up on $PORT (profile: $PROFILE)"
  echo "  → Log into 公众号/小红书/微博/知乎 in that window (one-time; persists)."
else
  echo "✗ debug Chrome did not open $PORT (port conflict? another Chrome holding it?)" >&2
  exit 1
fi
