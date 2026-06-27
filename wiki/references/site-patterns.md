---
address: c-000060
type: reference
title: "Platform Extraction Patterns (公众号 / 小红书 / 微博 / 知乎)"
created: 2026-06-27
updated: 2026-06-27
tags: [reference, web-access, extraction, chinese-platforms]
status: developing
related:
  - "[[web-access-setup]]"
  - "[[Document Parsing]]"
---

# Platform Extraction Patterns

How this vault extracts content from Chinese anti-bot platforms. The **live** per-site patterns (selectors, URL quirks, traps) live with the `web-access` skill at `~/.claude/skills/web-access/references/site-patterns/<domain>.md`. This page is the condensed knowledge record + the "why."

All four platforms are **JS-rendered + login-gated + anti-bot** — `WebFetch`/`defuddle` fail. The fix is the `web-access` CDP path (drives your real Chrome → carries login state + renders JS). See [[web-access-setup]].

## 微信公众号 — `mp.weixin.qq.com`
- Article body server-rendered in `#js_content`; title `#activity-name`; publish time via `var ct=` Unix stamp.
- **Must use the full signed URL** (`__biz`/`mid`/`idx`/`sn`/…); short links sometimes 302 to expired.
- Images are `data-src` (lazy) — scroll before extracting.

## 小红书 — `xiaohongshu.com`
- Note URLs **require `xsec_token`**; missing it → fake "页面不存在".
- Prefer **in-site search → click** (the click carries the token) over hand-built URLs.
- ⚠️ Highest ban risk — **use a secondary account**, close tabs promptly.

## 微博 — `weibo.com`
- Prefer the **mobile variant `m.weibo.cn`** (lighter HTML, JSON endpoints, weaker anti-bot).
- Login required; long posts need "展开".

## 知乎 — `zhihu.com`
- Login wall; long answers visually collapsed ("阅读全文") but often **fully present in DOM** — read DOM directly rather than clicking expand.
- `zhihu.com/api/v4/answers/<id>` returns structured JSON (needs cookies);专栏 (`zhuanlan.zhihu.com/p/`) uses different selectors.

## When to use which (per web-access)
- Discovery → WebSearch / CDP-driven search.
- Clean article → Jina (`r.jina_ai/<url>`) or `defuddle`.
- Any of the 4 platforms above, or any login/JS-gated page → **CDP**.

## Write-side gate (unchanged)
Whatever the fetch method, the autoresearch §Web egress hygiene gate still runs **before** content is written to the vault: strip `<script>`, escape `[[`, reject injected `---`, truncate ~50KB. CDP does not bypass it.
