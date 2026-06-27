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

## 小红书 — `xiaohongshu.com` ✅ verified 2026-06-27
- Note URLs **require `xsec_token`**; missing it → fake "页面不存在".
- ✅ **带 token 的直链可直接 CDP 打开**(实测:无需登录墙、无需"站内搜索→点击",一次成)。
- 正文一律限定 `#noteContainer`(`.innerText` 一次拿全:标题+正文+标签+评论+互动数);标题 `#detail-title`、作者 `.author-container .name`、图集 `[class*=note-slider-img] img`。
- ⚠️ Highest ban risk — **use a secondary account**, close tabs promptly。别用无作用域 `[class*=desc]`(会命中导航噪音)。

## 微博 — `weibo.com`
- Prefer the **mobile variant `m.weibo.cn`** (lighter HTML, JSON endpoints, weaker anti-bot).
- Login required; long posts need "展开".

## 知乎 — `zhihu.com`
- Login wall; long answers visually collapsed ("阅读全文") but often **fully present in DOM** — read DOM directly rather than clicking expand.
- `zhihu.com/api/v4/answers/<id>` returns structured JSON (needs cookies);专栏 (`zhuanlan.zhihu.com/p/`) uses different selectors.

## Learning loop(加速后续抽取)
每次抽取都走闭环(详见 web-access SKILL「站点经验」):
- **抽前** 读 live `~/.claude/skills/web-access/references/extraction-log.md`(最近真实结果 + 已验证选择器)。
- **失败** 查 `~/.claude/skills/web-access/references/retry-playbook.md`(症状→恢复);**同一方式不连试第三次**。
- **抽后** 往 extraction-log 顶部追加一条(平台/URL/路径/有效选择器/重试次数/解法/教训);把可复用事实沉淀进 `site-patterns/<domain>.md`。
- 这两个活文件随 web-access skill 走(user-scope,不在本仓库);本页是精简知识副本。

## When to use which (per web-access)
- Discovery → WebSearch / CDP-driven search.
- Clean article → Jina (`r.jina_ai/<url>`) or `defuddle`.
- Any of the 4 platforms above, or any login/JS-gated page → **CDP**.

## Write-side gate (unchanged)
Whatever the fetch method, the autoresearch §Web egress hygiene gate still runs **before** content is written to the vault: strip `<script>`, escape `[[`, reject injected `---`, truncate ~50KB. CDP does not bypass it.
