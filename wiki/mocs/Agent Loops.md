---
address: c-000069
type: moc
title: "Agent Loops"
domain: agents
created: 2026-06-28
updated: 2026-06-28
tags: [moc, agents]
status: developing
members:
  - "[[Augmented LLM]]"
  - "[[Agentic Loop]]"
  - "[[ReAct]]"
  - "[[Reflexion]]"
  - "[[Agentic Workflow Patterns]]"
  - "[[Context Engineering]]"
  - "[[Agent Error Propagation]]"
related:
  - "[[Agent Reliability]]"
  - "[[Agent-Native Architecture]]"
---

# Agent Loops

The canonical agent is a **while-loop with tools**: read context → call tool → observe → repeat. Everything else in this cluster is variations on, or engineering around, that loop. The loop itself is trivial; the leverage is in the base unit ([[Augmented LLM]]), the reasoning patterns layered on it ([[ReAct]], [[Reflexion]], [[Agentic Workflow Patterns]]), the context it runs in ([[Context Engineering]]), and how its errors are contained ([[Agent Error Propagation]]). This is the cluster the whole vault's agent-layer thinking radiates from.

## Members

| Page | Role |
|---|---|
| [[Augmented LLM]] | Anthropic's base unit: LLM + retrieval + tools + memory |
| [[Agentic Loop]] | the canonical while-loop-with-tools; the loop IS the agent |
| [[ReAct]] | Thought→Action→Observation; 2022 default reasoning pattern |
| [[Reflexion]] | evaluate→critique→retry-with-memory self-improvement layer |
| [[Agentic Workflow Patterns]] | chaining, routing, parallelization, orchestrator-workers, evaluator-optimizer |
| [[Context Engineering]] | tools are ~80% of agent context; engineer outputs/ACI over prompts |
| [[Agent Error Propagation]] | why the loop compounds errors; how production contains it |

## Foundational sources
- [[ReAct - Synergizing Reasoning and Acting]] (Yao et al. ICLR 2023)
- [[Braintrust - Canonical Agent Loop]] — the while-loop is canonical; Bitter Lesson for agents
- [[Anthropic - Multi-Agent Research System]] — orchestrator-worker; +90.2% research eval
- [[Anthropic - Building Effective Agents]] — workflows-vs-agents; augmented LLM; 5 patterns
- [[The AI Engineer - Single-Agent Patterns]] — ReAct/Plan-Execute/ReWOO/Reflexion
- [[Galileo - Agent Failure Modes]] — 7 failure patterns; error propagation is the killer

## Synthesis
[[Research - Agentic Loop Engineering]] — the loop is trivial; engineering lives at tool/context design + error containment.

## Open tensions within this cluster
- [[Context Engineering]] bridges into [[Agent Reliability]] (it is both a loop concern and a harness subsystem) — listed in both, primary here.

## Cross-cluster
Governed by [[Agent Reliability]] (the harness around the loop); its tool primitive shows up concretely in [[Agent-Native Architecture]] (`defineAction` = the loop's tool).
