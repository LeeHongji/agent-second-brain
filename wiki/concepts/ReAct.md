---
type: concept
title: "ReAct"
complexity: intermediate
domain: agents
aliases:
  - "Reasoning and Acting"
  - "Thought-Action-Observation Loop"
created: 2026-06-24
updated: 2026-06-24
tags:
  - concept
  - agents
  - reasoning
status: developing
related:
  - "[[Agentic Loop]]"
  - "[[Augmented LLM]]"
  - "[[Reflexion]]"
  - "[[Agentic Workflow Patterns]]"
sources:
  - "[[ReAct - Synergizing Reasoning and Acting]]"
  - "[[The AI Engineer - Single-Agent Patterns]]"
---

# ReAct

**ReAct** (Reason + Act) is the 2022 pattern that made tool-using LLM agents practical. The model generates **verbal reasoning traces** ("Thought") and **task-specific actions** ("Action") interleaved, observes the action's result ("Observation"), and loops until the task resolves.

```text
Thought → Action → Observation → Thought → Action → Observation → … → Answer
```

## Why interleaving works

Before ReAct, reasoning (chain-of-thought) and acting (plan generation) were studied separately. Reasoning-only chains hallucinate and propagate errors because nothing checks them against reality. Acting-only lacks planning. Interleaving creates **synergy**: the thought steers the action plan and handles exceptions; the action grounds the thought in external ground truth (a Wikipedia API, a search tool). On HotpotQA/Fever this cut hallucination; on ALFWorld/WebShop it beat imitation/RL baselines by +34%/+10% absolute. (Source: [[ReAct - Synergizing Reasoning and Acting]])

## Strengths

- **Adaptive** — a failed or surprising tool result is re-reasoned on the next step.
- **Grounded** — observations between reasoning steps tether inference to reality.
- **Debuggable** — every Thought is logged, giving a full audit trail (valuable in regulated domains).
- **Universal** — the default in every major framework; "agent" usually means a ReAct loop.

## Weaknesses

- **Cost scales linearly** — one full LLM call per step, each with growing context. Painful past ~5–7 steps.
- **Reasoning loops** — confusion can cause repetitive same-tool-same-input cycles burning tokens.
- **Myopic** — only sees one step ahead; cannot optimize the global path.

## Descendants

ReAct is the trunk from which the other single-agent patterns branch, each addressing a ReAct weakness: [[Reflexion]] adds evaluate-critique-retry; Plan-and-Execute moves planning *upfront* to kill myopia; ReWOO plans once with placeholders for 5x token efficiency. Most production agents are still plain ReAct — the others are adopted only when a specific failure mode (cost, myopia, correctness) appears at scale. (Source: [[The AI Engineer - Single-Agent Patterns]])
