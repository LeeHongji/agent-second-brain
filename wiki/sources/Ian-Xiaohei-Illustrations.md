---
address: c-000053
type: source
created: 2026-06-25
updated: 2026-06-25
title: "Ian Xiaohei Illustrations (小黑配图 Skill)"
source_type: codex-skill
author: "Ian (helloianneo)"
date_published: 2026
venue: "GitHub helloianneo/ian-xiaohei-illustrations; Codex Skill; MIT"
url: "https://github.com/helloianneo/ian-xiaohei-illustrations"
purpose: "中文文章正文配图 — blog illustration tool"
confidence: high
key_claims:
  - "Codex Skill that turns a Chinese article's judgment/flow/state/metaphor into one 16:9 hand-drawn body illustration"
  - "小黑 IP: black solid figure, white-dot eyes, thin legs — an absurd worker participating in the system, NOT a mascot"
  - "Style: pure white bg, black hand-drawn line, ~40-60% subject, minimal red/orange/blue Chinese annotations, one cognitive anchor per image"
  - "Discipline: reinvent the metaphor per article (don't copy examples); 小黑 must carry the core action or rework"
  - "Outputs 4-8 PNGs per article to assets/<slug>-illustrations/; not PPT/SVG/editable vectors"
tags:
  - source
  - tool
  - illustration
  - blog
  - skill
status: reference
related:
  - "[[Learn-Harness-Engineering]]"
---

# Ian Xiaohei Illustrations (小黑配图 Skill)

A **Codex Skill** by Ian (helloianneo) for generating **body illustrations for Chinese articles** — it reads the article, finds the cognitive anchors, and draws one 16:9 hand-drawn image per anchor in a distinctive "小黑" (Xiaohei) style.

> 让 AI 不只是"配一张图"，而是把文章里的一个关键认知动作画出来。

**🎯 Recorded use case for this vault:** blog 配图. When writing blog posts (e.g. the `/release-blog` workflow), reach for this skill to produce distinctive 小黑-style body illustrations instead of generic stock imagery or PPT infographics.

## The IP: 小黑

A black solid figure — white-dot eyes, thin legs, blank expression. 小黑 is an **absurd worker genuinely participating in the system**, not a mascot/sticker/corner decoration. The test: if the image still fully works with 小黑 removed, he is too decorative → rework so he carries the core action.

## Style quick-reference

- Pure white background (no paper texture, cream, shadows, gradients)
- Black hand-drawn line work, thin, slight tremor
- Lots of whitespace; subject ~40–60% of frame
- Minimal red / orange / blue **Chinese handwritten** annotations
- One core action / structure / state / metaphor per image
- Grotesque, creative, clean — not childish, not cute

## Usage recipes

```
# Shot-list only (plan, no generation)
Use $ian-xiaohei-illustrations 先不要生图。分析这篇文章哪里值得配图，输出 5 张左右的 shot list。
每张写清：放在哪段后、主题、核心意思、结构类型、小黑在做什么、建议中文标注词。

# Generate body illustrations
Use $ian-xiaohei-illustrations 把下面这篇文章生成 4 张小黑怪诞正文配图。
要求：16:9、纯白背景、黑色手绘线稿、少量红橙蓝中文手写批注。

# One concept → one image
Use $ian-xiaohei-illustrations 为"<concept>"生成一张正文配图。画面怪诞但清爽，小黑必须承担核心动作。

# Edit (e.g. remove stray title/wrong text)
Use $ian-xiaohei-illustrations 帮我编辑这张图，去掉左上角的标题，其他不变。
```

Structure types to pick from: Workflow · system-part · before-after · role-state · concept-metaphor · method-layering · map-route · comic-panel.

## Install (Codex-native; portable pattern)

```bash
git clone https://github.com/helloianneo/ian-xiaohei-illustrations.git
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
cp -R ./ian-xiaohei-illustrations/ian-xiaohei-illustrations "${CODEX_HOME:-$HOME/.codex}/skills/"
```
Installable unit = inner `ian-xiaohei-illustrations/` subdir (SKILL.md + `agents/openai.yaml` + references: style-dna, xiaohei-ip, composition-patterns, prompt-template, qa-checklist). The skill ships `agents/openai.yaml` (Codex/OpenAI); the style-DNA + prompt-template references are model-agnostic and reusable from any agent.

> [!gap] Portability note
> This is a **Codex Skill** (uses `Use $skill` syntax + `agents/openai.yaml`). This vault runs on **Claude Code**. To use from Claude Code, adapt the `references/*.md` (style-dna, prompt-template, qa-checklist) into a Claude Code SKILL.md, or run it from a Codex session. The style DNA and discipline are the valuable, portable parts; the trigger syntax is not.

## Discipline (the part that makes it good)

- **Reinvent the metaphor per article.** Example images calibrate line density / whitespace / color restraint / 小黑 participation — they are NOT composition templates to copy.
- **One structure per image.** Don't turn the article into a manual spread across one frame.
- **小黑 must carry the core action** (the removal test above).
- **Chinese in-image: shorter = more stable.** If characters come out garbled, reduce annotations and regenerate rather than fighting the model.
- **Always post-check.** Image models produce wrong characters, hallucinated labels, style drift, stray titles.

## Relationship to neighbors

- Pairs with the vault's `/canvas` skill (which places images/PDFs/notes on Obsidian canvases) — generate with 小黑, then `/canvas add image` to file them.
- The canvas skill's optional `/banana` integration is the same category (AI image gen for the vault); 小黑 is a *styled, article-aware* alternative to generic image gen.
- Sibling skill from the same author: `ian-handdrawn-ppt` (中文手绘技术 PPT 页面图). (Source: [[Ian-Xiaohei-Illustrations]])
