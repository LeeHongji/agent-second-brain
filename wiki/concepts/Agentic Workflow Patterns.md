---
type: concept
title: "Agentic Workflow Patterns"
complexity: intermediate
domain: agents
aliases:
  - "Agent Workflow Patterns"
  - "Compositional Workflows"
created: 2026-06-24
updated: 2026-06-24
tags:
  - concept
  - agents
  - patterns
status: developing
related:
  - "[[Augmented LLM]]"
  - "[[Agentic Loop]]"
  - "[[ReAct]]"
  - "[[Reflexion]]"
sources:
  - "[[Anthropic - Building Effective Agents]]"
  - "[[The AI Engineer - Single-Agent Patterns]]"
---

# Agentic Workflow Patterns

Anthropic's five **workflow patterns** — systems where LLMs and tools are orchestrated through *predefined code paths*. They sit between a single LLM call and a fully autonomous agent on the complexity ladder. Use them when a task is predictable enough to hardcode structure; graduate to the [[Agentic Loop]] only when flexibility demands it.

## The progression (simple → complex)

1. **Prompt chaining** — decompose a task into a fixed sequence; each call processes the previous output. Add programmatic "gate" checks between steps. *Trade latency for accuracy.* (e.g., draft marketing copy → translate.)
2. **Routing** — classify the input and dispatch to a specialized handler. Separation of concerns; lets you tune each class independently (route easy queries to a cheap model, hard ones to a strong model).
3. **Parallelization** — run multiple LLM calls at once, aggregate programmatically. Two flavors: **sectioning** (independent subtasks) and **voting** (same task, diverse outputs for confidence). Good for guardrails (one call answers, another screens) and evals.
4. **Orchestrator-workers** — a central LLM dynamically breaks the task down, delegates to worker LLMs, synthesizes results. Differs from parallelization because subtasks are *not predefined* — the orchestrator decides them per input. (e.g., coding changes across an unknown set of files; multi-source search.) This is the pattern Anthropic's Research feature uses at multi-agent scale.
5. **Evaluator-optimizer** — one LLM generates, another evaluates and gives feedback, in a loop. Effective when there are clear evaluation criteria and iterative refinement measurably helps (literary translation; multi-round search). A constrained cousin of [[Reflexion]].

## When to stop at workflows

Workflows give **predictability and consistency** for well-defined tasks. Anthropic's rule: find the simplest solution; add multi-step structure only when it *demonstrably* improves outcomes. Many applications need nothing beyond a single LLM call with retrieval and in-context examples. (Source: [[Anthropic - Building Effective Agents]])

## Workflow vs agent vs pattern vs framework

- A **workflow** has predefined paths; an **agent** directs itself dynamically.
- A **pattern** (ReAct, orchestrator-workers) is an architecture; a **framework** (LangGraph, CrewAI) is plumbing that implements many patterns. You can build any pattern in any framework or in raw code. (Source: [[The AI Engineer - Single-Agent Patterns]])

## The planning-axis map

The single-agent reasoning patterns (ReAct per-step, Plan-and-Execute upfront, ReWOO once-with-placeholders) are orthogonal choices along **when to plan** and **how many LLM calls** — see [[ReAct]] and [[Reflexion]]. The five workflow patterns above are *compositional structures*; the reasoning patterns are *control strategies inside a loop*. Real systems mix both.

---

## Connection: SkillOpt

SkillOpt's gate is the **evaluator-optimizer** pattern (workflow #5) applied to the skill artifact itself — and run to convergence across epochs, with [[Validation-Gated Skill Update|patience]] + slow-update momentum. See [[SkillOpt]], [[Text-Space Optimization]].
