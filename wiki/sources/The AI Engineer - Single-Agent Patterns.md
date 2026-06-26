---
type: source
created: 2026-06-24
updated: 2026-06-25
title: "ReAct vs Plan-and-Execute vs ReWOO vs Reflexion"
source_type: blog
author: "Paolo Perrone (The AI Engineer)"
date_published: 2026-04-16
url: "https://theaiengineer.substack.com/p/the-4-single-agent-patterns"
confidence: medium
key_claims:
  - "Four single-agent patterns differ on three axes: when to plan, how many LLM calls, how to handle failure"
  - "ReAct: 1 LLM call/step, adaptive, myopic, gets expensive on long chains"
  - "Plan-and-Execute: plan upfront with a strong model, execute with a cheaper one, replan on failure"
  - "ReWOO: plan once with placeholders, run all tools in parallel, 2 LLM calls total, 5x token efficiency over ReAct"
  - "Reflexion: critique + retry with critique in memory; GPT-4 HumanEval 80%->91%; 130/134 AlfWorld tasks"
  - "A 2025 replication study found single-agent Reflexion can reinforce its own blind spots (same model writes output and critique)"
  - "Most production agents are plain ReAct loops; the other patterns address specific failure modes at scale"
tags:
  - source
  - agents
  - patterns
status: current
related:
  - "[[ReAct]]"
  - "[[Reflexion]]"
  - "[[Agentic Workflow Patterns]]"
  - "[[Agent Error Propagation]]"
---

# ReAct vs Plan-and-Execute vs ReWOO vs Reflexion

A practitioner's comparison of the four established single-agent reasoning patterns. The differentiating design choices:

| Pattern | When plan? | LLM calls | Failure handling |
|---|---|---|---|
| ReAct | per-step | 1/step | adapt on the fly |
| Plan-and-Execute | upfront | ~1–2 + replan | replan |
| ReWOO | once (placeholders) | 2 total | ignore/isolate |
| Reflexion | per attempt | N × retries | retry with self-critique in memory |

**ReAct** is the default ("if someone says 'agent' they usually mean a ReAct loop"). Its debuggability — every thought logged — is its operational advantage (audit trails in finance/health). Ceiling: >5–7 steps gets costly.

**Plan-and-Execute** fixes ReAct's myopia: a strong model emits an inspectable plan (a DAG of subtasks), a cheap model executes, a replanner handles surprises. Best for checklists/predictable workflows.

**ReWOO** (Reasoning Without Observation) plans once with variable placeholders (`#E1 = Search[…]; #E2 = Search[hometown of #E1]`), runs independent tools in parallel, synthesizes in a second call. 5x token efficiency on HotpotQA. Breaks if a tool returns the unexpected (no mid-execution adaptation).

**Reflexion** layers an evaluator + self-reflection memory on top of any base pattern. Improves GPT-4 HumanEval 80%→91%. But: every retry is a full run (expensive), and a 2025 replication found single-agent Reflexion repeats earlier misconceptions because the same model generates both output and critique.

**Practical hybrids:** ReAct + Reflexion (most common), Plan-and-Execute with ReAct fallback, ReWOO fast-path with Plan-and-Execute fallback. The pattern matters less than tools and evaluation — "most agent failures are tool failures, not reasoning failures." (Source: [[The AI Engineer - Single-Agent Patterns]])
