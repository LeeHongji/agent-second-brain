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

`web-access` (by 一泽Eze, MIT — https://github.com/eze-is/web-access) is the **联网底座** that powers `autoresearch` and `wiki-ingest` URL fetching in this vault. It gives Claude full web access: auto tool selection (WebSearch / curl / Jina / **CDP browser**) + site-pattern accumulation.

The bare `WebSearch`/`WebFetch` tools are US-centric and can't render JS or carry login state — they fail on 公众号 / 小红书 / 微博 / 知乎. `web-access`'s **CDP Proxy** drives your real Chrome, so it carries your login state and renders JS.

## Install (user-scope — not committed to this repo)
```bash
git clone --depth 1 https://github.com/eze-is/web-access.git ~/.claude/skills/web-access
node ~/.claude/skills/web-access/scripts/check-deps.mjs
```
Set the browser preference in `~/.claude/skills/web-access/config.env` → `WEB_ACCESS_BROWSER=chrome`.

## One-time Chrome authorization (CDP)
1. Chrome 地址栏 → `chrome://inspect/#remote-debugging`.
2. 勾选 **Allow remote debugging for this browser instance**(可能需重启 Chrome)。
3. 若弹出授权框,点「允许」。
4. Verify: `curl localhost:3456/health` → `"connected": true`.

Until `connected: true`, the CDP path is unavailable; `web-access` degrades to WebSearch/curl/Jina (普通文章仍可用,反爬平台才需 CDP)。

## ⚠️ Account risk
Browser automation on 小红书 / 微博 can trigger rate-limiting or **bans**. Use a **secondary account (小号)** logged into Chrome for those platforms. Never automate your primary account.

## How this vault uses it
- `autoresearch` loads `web-access` for every fetch (see its "Web access substrate" section); for the 4 platforms it routes to CDP. The §Web egress hygiene write-side gate still applies.
- `wiki-ingest` URL ingestion routes anti-bot/thin-WebFetch URLs to CDP.
- Per-platform selectors/traps: [[site-patterns]] (live copies in `~/.claude/skills/web-access/references/site-patterns/`).

## Attribution
`web-access` is upstream software by 一泽Eze (MIT), installed user-scope. This vault depends on it but does not bundle it — same pattern as the kepano/obsidian-skills substrate references.
