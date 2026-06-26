---
address: c-000046
type: synthesis
title: "Research: Agentic Loop Engineering"
created: 2026-06-24
updated: 2026-06-24
tags:
  - research
  - agents
  - agentic-loops
status: developing
related:
  - "[[Agentic Loop]]"
  - "[[ReAct]]"
  - "[[Augmented LLM]]"
  - "[[Agentic Workflow Patterns]]"
  - "[[Reflexion]]"
  - "[[Context Engineering]]"
  - "[[Agent Error Propagation]]"
sources:
  - "[[ReAct - Synergizing Reasoning and Acting]]"
  - "[[Braintrust - Canonical Agent Loop]]"
  - "[[Anthropic - Multi-Agent Research System]]"
  - "[[Anthropic - Building Effective Agents]]"
  - "[[The AI Engineer - Single-Agent Patterns]]"
  - "[[Galileo - Agent Failure Modes]]"
---

# Research: Agentic Loop Engineering

## Overview

**Agentic loop engineering** is the discipline of designing the iterative cycle at the heart of every autonomous LLM agent: assemble context → call the model → execute the returned action → feed the result back → repeat. Research converges on a striking conclusion: the loop itself is trivial, and the production-proven agents (Claude Code, the OpenAI Agents SDK) all use the same ~10-line **while-loop-with-tools**. The real engineering lives at three edges — **tool/context design, the reasoning-control strategy inside the loop, and error containment** — not in elaborate frameworks. The Bitter Lesson applies to agents: simple, general patterns win as models improve.

## Key Findings

1. **The loop is the agent.** A `while (!done) { callLLM(); if toolCall { run; push } else done }` structure is the canonical architecture shared by the most successful agents. Frameworks are optional plumbing; the pattern is the architecture. (Source: [[Braintrust - Canonical Agent Loop]])
2. **ReAct (2022) is the trunk.** Thought → Action → Observation interleaving grounded reasoning in external tools and made agents interpretable; every later pattern extends or optimizes it. (Source: [[ReAct - Synergizing Reasoning and Acting]])
3. **Complexity is a ladder, not a goal.** Anthropic's progression — augmented LLM → 5 workflow patterns → autonomous agent — starts simple and adds structure only when it *demonstrably* improves outcomes. Many tasks need only a single LLM call + retrieval. (Source: [[Anthropic - Building Effective Agents]])
4. **Context, not prompts, is the lever.** Tools are ~80% of what an agent reads (67.6% tool responses + 10.7% definitions + 3.4% system prompt). Context/tool-output engineering beats prompt tuning. (Source: [[Braintrust - Canonical Agent Loop]])
5. **The loop compounds errors.** Every iteration feeds forward across Memory→Reflection→Planning→Action; one hallucinated fact cascades. Error propagation — not failure-mode variety — is what kills reliability. (Source: [[Galileo - Agent Failure Modes]])
6. **Multi-agent pays for breadth, not coordination.** Token usage explains 80% of BrowseComp variance; separate context windows compress in parallel. But agents use ~15x chat tokens, and independent architectures amplify errors more than centralized ones. (Source: [[Anthropic - Multi-Agent Research System]])
7. **Evaluation is the foundation, not an afterthought.** An agent is an evaluatable system: agent + dataset + scorers. Outcome-based + LLM-as-judge + human testing, with evals built *before* architecture is chosen. (Sources: [[Braintrust - Canonical Agent Loop]], [[Anthropic - Multi-Agent Research System]])

## Key Concepts

- [[Agentic Loop]] — the canonical while-loop-with-tools; the loop *is* the agent.
- [[Augmented LLM]] — the base unit (retrieval + tools + memory).
- [[ReAct]] — Thought→Action→Observation; the default reasoning pattern.
- [[Agentic Workflow Patterns]] — prompt chaining, routing, parallelization, orchestrator-workers, evaluator-optimizer.
- [[Reflexion]] — evaluate → critique → retry-with-memory self-improvement layer.
- [[Context Engineering]] — tool/output/transcript design; the ACI discipline.
- [[Agent Error Propagation]] — why the loop is fragile and how production contains it.

## Key Entities

- **Shunyu Yao et al. (Princeton/Google)** — ReAct (2022), the foundational agent-loop paper.
- **Anthropic (Erik Schluntz, Barry Zhang; Research team)** — "Building Effective Agents" (the workflow/agent distinction) and the multi-agent Research system post-mortem.
- **Braintrust (Ankur Goyal)** — the "while-loop-with-tools is canonical / Bitter Lesson for agents" thesis (Aug 2025).
- **LangChain / LangGraph** — the dominant framework implementing these patterns as stateful graphs.

## Contradictions

- **Reflexion both helps and self-reinforces.** It lifts GPT-4 HumanEval 80%→91%, yet a 2025 replication finds single-agent Reflexion *repeats* earlier misconceptions because the same model writes both output and critique. Resolution: Reflexion needs an *independent* evaluator (different model or external ground truth like test results), not self-critique, to avoid propagating errors into its own memory. (Source: [[The AI Engineer - Single-Agent Patterns]])
- **Multi-agent: force multiplier vs coordination tax.** Anthropic reports +90.2% on research eval; Galileo warns multi-agent "often adds coordination risk with limited performance gains." Not a hard contradiction — both agree it is *context-dependent*: multi-agent excels at breadth-first parallel research where subagents have independent contexts, and hurts when agents share context or have many dependencies (most coding tasks). (Sources: [[Anthropic - Multi-Agent Research System]], [[Galileo - Agent Failure Modes]])

## Open Questions

- **Benchmarks as ground truth.** BrowseComp, SWE-bench, ALFWorld, HumanEval each measure one facet; how well do loop-engineering choices *transfer* across benchmarks? Not resolved by these sources.
- **Async vs sync multi-agent.** Anthropic notes their lead agent runs subagents *synchronously* (a bottleneck); async execution is expected to help but adds state-consistency and error-propagation challenges. Outcome unknown.
- **Long-horizon state management.** Production agents run hundreds of turns; context-compression and memory-handoff patterns (spawn fresh subagents, store plan externally) are described but not benchmarked at scale.
- **Governance as a platform.** Gartner's 2030 forecast (half of failures from insufficient runtime governance) is a prediction, not measured. The gap between "eval the agent" and "enforce policy at runtime fleet-wide" is still being closed.
- **Plan-and-Execute vs ReWOO deep-dive.** Filed as contrast only; no standalone pages yet. Worth a follow-up research cycle on planning-ahead patterns and their replanning failure modes.

## Sources

- [[ReAct - Synergizing Reasoning and Acting]] — Yao et al., ICLR 2023 (arXiv 2210.03629).
- [[Braintrust - Canonical Agent Loop]] — Goyal, Aug 2025.
- [[Anthropic - Multi-Agent Research System]] — Hadfield, Zhang et al., 2025.
- [[Anthropic - Building Effective Agents]] — Schluntz & Zhang, Dec 2024.
- [[The AI Engineer - Single-Agent Patterns]] — Perrone, Apr 2026.
- [[Galileo - Agent Failure Modes]] — Galileo AI, Nov 2025.
