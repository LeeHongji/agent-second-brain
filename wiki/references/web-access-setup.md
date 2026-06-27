---
address: c-000061
type: reference
title: "web-access Setup (联网底座)"
created: 2026-06-27
updated: 2026-06-27
tags: [reference, web-access, setup, substrate]
status: developing
related:
  - "[[site-patterns]]"
---

# web-access Setup

`web-access` (by 一泽Eze, MIT — https://github.com/eze-is/web-access) is the **联网底座** powering `autoresearch` and `wiki-ingest` URL fetching. It gives Claude full web access: auto tool selection (WebSearch / curl / Jina / **CDP browser**) + site-pattern accumulation. The CDP path drives a real Chrome → renders JS + carries login state → reaches 公众号 / 小红书 / 微博 / 知乎 that bare `WebFetch` cannot.

## ⚠️ The `chrome://inspect` toggle does NOT work here

Chrome 136+ **silently ignores remote debugging on the default profile** (security restriction). The "Allow remote debugging for this browser instance" toggle in `chrome://inspect` is flaky/unreliable on Chrome 149 and the bare `--remote-debugging-port=9222` flag on the default profile is ignored. Don't use either — use the dedicated-profile setup below.

## ✅ Working setup: dedicated debug-Chrome profile (the "小号" browser)

A separate Chrome instance with its own profile, listening on 9222. Runs **alongside** your normal Chrome, never touches your default profile. Log into 公众号/小红书/微博/知乎 **here** (one-time; persists in this profile) — this is your automation account, isolated from your main account.

**Launch it** (repeatable; idempotent — safe to re-run):
```bash
bash bin/launch-debug-chrome.sh
```
Then in the debug-Chrome window that opens, log into the platforms you want the agent to access.

**web-access config** (`~/.claude/skills/web-access/config.env`): leave `WEB_ACCESS_BROWSER=` empty — discovery uses the fallback-port path (probes 9222).

## Local patch to web-access (applied 2026-06-27)

The proxy's fallback-port path had a bug: it connected to `ws://127.0.0.1:9222/devtools/browser` **without the `/<uuid>`**, so Chrome 404'd. Patched `~/.claude/skills/web-access/scripts/cdp-proxy.mjs` `getWebSocketUrl()` to fetch the real browser WS URL from `/json/version` (which carries the uuid) when `wsPath` is null. ⚠️ This patch is **lost if web-access is updated** (`git pull`) — re-apply, or upstream the fix.

## Verify it works
```bash
bash bin/launch-debug-chrome.sh                 # debug Chrome on 9222
node ~/.claude/skills/web-access/scripts/check-deps.mjs   # proxy connects
curl -s localhost:3456/health                   # → "connected": true
```
End-to-end smoke (open → eval → close):
```bash
TID=$(curl -s -X POST localhost:3456/new -d 'https://example.com' | python3 -c "import json,sys;print(json.load(sys.stdin)['targetId'])")
curl -s -X POST "localhost:3456/eval?target=$TID" -d 'document.title'   # {"value":"Example Domain"}
curl -s "localhost:3456/close?target=$TID"
```

## ⚠️ Account risk
小红书 / 微微博 browser automation can trigger rate-limiting or **bans**. The debug-Chrome profile is your 小号 by design — never automate your main account. Close tabs promptly (`/close`) between tasks.

## How this vault uses it
- `autoresearch` loads `web-access` for every fetch (see its "Web access substrate" section); the 4 platforms route to CDP. The §Web egress hygiene write-side gate still applies.
- `wiki-ingest` URL ingestion routes anti-bot/thin-WebFetch URLs to CDP.
- Per-platform selectors/traps: [[site-patterns]] (live copies in `~/.claude/skills/web-access/references/site-patterns/`).

## Attribution
`web-access` is upstream MIT software by 一泽Eze, installed user-scope (not bundled in this repo) — same pattern as the kepano/obsidian-skills substrate references.
