---
address: c-000049
type: source
created: 2026-06-24
updated: 2026-06-25
title: "Building Effective Agents"
source_type: blog
author: "Erik Schluntz, Barry Zhang (Anthropic)"
date_published: 2024-12
url: "https://www.anthropic.com/research/building-effective-agents"
confidence: high
key_claims:
  - "The most successful agent implementations use simple, composable patterns — not complex frameworks"
  - "Workflows = LLMs orchestrated through predefined code paths; Agents = LLMs dynamically directing their own process"
  - "Find the simplest solution possible; add complexity only when it demonstrably improves outcomes"
  - "The augmented LLM (retrieval + tools + memory) is the foundational building block"
  - "Five workflow patterns: prompt chaining, routing, parallelization, orchestrator-workers, evaluator-optimizer"
  - "Three principles: simplicity, transparency (show planning steps), and careful ACI (tool documentation/testing)"
tags:
  - source
  - agents
  - architecture
status: canonical
related:
  - "[[Augmented LLM]]"
  - "[[Agentic Workflow Patterns]]"
  - "[[Agentic Loop]]"
  - "[[Context Engineering]]"
  - "[[Anthropic - Multi-Agent Research System]]"
---

# Building Effective Agents

The canonical industry reference on agent architecture (Dec 2024). Anthropic draws a load-bearing distinction:

- **Workflows** — LLMs + tools orchestrated through *predefined code paths*. Predictable, consistent, best for well-defined tasks.
- **Agents** — LLMs that *dynamically direct their own* processes and tool usage. Flexible, best when model-driven decisions are needed at scale. "Just LLMs using tools based on environmental feedback in a loop."

**The progression (increasing complexity):** augmented LLM → 5 workflow patterns → autonomous agent. See [[Augmented LLM]] and [[Agentic Workflow Patterns]].

**The meta-principle:** start with the simplest solution — often a single LLM call with retrieval and in-context examples is enough. Workflows trade latency/cost for performance; agents add autonomy AND compounding-error risk. Add complexity *only when it demonstrably improves outcomes.*

**Agent-Computer Interface (ACI):** tool definition deserves as much prompt-engineering attention as the prompt itself. While building their SWE-bench agent, Anthropic spent more time optimizing tools than the prompt. Concrete lesson: a tool using relative filepaths broke after the agent left the root dir; forcing absolute filepaths fixed it flawlessly. Invest in ACI like you invest in HCI. See [[Context Engineering]].

**Appendix findings:** customer support and coding are the two domains where agents add the most value (conversation + action + clear success criteria + feedback loops + human oversight). Coding agents benefit because code is verifiable by tests — a natural evaluator. (Source: [[Anthropic - Building Effective Agents]])
