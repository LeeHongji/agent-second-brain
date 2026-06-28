---
address: c-000071
type: moc
title: "Text-Space Training"
domain: agents
created: 2026-06-28
updated: 2026-06-28
tags: [moc, agents, optimization]
status: developing
members:
  - "[[Text-Space Optimization]]"
  - "[[Textual Gradient]]"
  - "[[Validation-Gated Skill Update]]"
related:
  - "[[Agent Reliability]]"
  - "[[Agent Loops]]"
---

# Text-Space Training

You can **train a frozen LLM by editing the text of its skills/prompts** — treating the markdown like neural-network weights and applying deep-learning-grade discipline (loss on held-out tasks, gradients, validation gates) without ever touching the weights. SkillOpt did +23.5pp on GPT-5.5 this way. This is the automated, measured counterpart to the hand-authored instructions of [[Agent Reliability]].

## Members

| Page | Role |
|---|---|
| [[Text-Space Optimization]] | the thesis: train a frozen LLM by editing skill/prompt text with DL discipline |
| [[Textual Gradient]] | the text analogue of a weight gradient — an edit patch from failed rollouts |
| [[Validation-Gated Skill Update]] | accept an edit only if it beats held-out validation; patience + slow update + meta skill |

## Foundational source
- [[SkillOpt]] — Microsoft Research; +23.5pp on GPT-5.5; trains skill.md like NN weights.

## Cross-cluster
The automated optimizer for the Instructions subsystem of [[Agent Reliability]]. Its loops reuse patterns from [[Agent Loops]] (Reflexion-style critique → retry).
