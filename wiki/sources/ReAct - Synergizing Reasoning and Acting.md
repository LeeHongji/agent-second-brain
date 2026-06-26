---
address: c-000056
type: source
created: 2026-06-24
updated: 2026-06-25
title: "ReAct: Synergizing Reasoning and Acting in Language Models"
source_type: paper
author: "Shunyu Yao, Jeffrey Zhao, Dian Yu, Nan Du, Izhak Shafran, Karthik Narasimhan, Yuan Cao"
date_published: 2022-10-06
venue: "ICLR 2023 (arXiv:2210.03629)"
url: "https://arxiv.org/abs/2210.03629"
confidence: high
key_claims:
  - "LLMs should generate reasoning traces and task-specific actions interleaved, not separately"
  - "Reasoning traces let the model plan/track/update and handle exceptions; actions ground it in external sources"
  - "On HotpotQA and Fever, ReAct cuts hallucination and error propagation vs chain-of-thought by grounding in a Wikipedia API"
  - "On ALFWorld and WebShop it beats imitation/RL baselines by +34% and +10% absolute success rate"
tags:
  - source
  - agents
  - reasoning
status: canonical
related:
  - "[[ReAct]]"
  - "[[Agentic Loop]]"
  - "[[Augmented LLM]]"
---

# ReAct: Synergizing Reasoning and Acting in Language Models

The foundational paper for the modern agent loop. Yao et al. (Princeton / Google) show that reasoning (chain-of-thought) and acting (tool/action use) had been studied separately, and that **interleaving them** produces synergy: reasoning steers action plans; actions pull external ground truth that keeps reasoning from hallucinating.

The loop is **Thought → Action → Observation → Thought → …** until the task resolves. The "Thought" steps are verbal reasoning traces that make the whole trajectory human-interpretable — a property later cited as ReAct's biggest operational advantage in regulated domains (auditability). See [[ReAct]].

**Contribution to this research:** defines the canonical primitive that every later pattern (Plan-and-Execute, ReWOO, Reflexion, the while-loop-with-tools) either extends, optimizes, or layers on. Without ReAct's interleaving insight, "agentic loop engineering" has no starting point.

**Limitations the paper itself surfaces:** pure reasoning chains hallucinate and propagate errors; pure acting lacks planning. ReAct's fix is grounding — but it is myopic (one step at a time) and pays one full LLM call per step, which the [[Agentic Workflow Patterns]] family later addresses. (Source: [[ReAct - Synergizing Reasoning and Acting]])
