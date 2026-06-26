---
address: c-000008
type: concept
title: "Agentic Loop"
complexity: intermediate
domain: agents
aliases:
  - "Agent Loop"
  - "While-Loop-With-Tools"
  - "Canonical Agent Architecture"
created: 2026-06-24
updated: 2026-06-24
tags:
  - concept
  - agents
  - architecture
status: developing
related:
  - "[[ReAct]]"
  - "[[Augmented LLM]]"
  - "[[Context Engineering]]"
  - "[[Agent Error Propagation]]"
  - "[[Agentic Workflow Patterns]]"
sources:
  - "[[Braintrust - Canonical Agent Loop]]"
  - "[[Anthropic - Building Effective Agents]]"
  - "[[Anthropic - Multi-Agent Research System]]"
---

# Agentic Loop

The **agentic loop** is the iterative execution cycle at the core of every autonomous LLM agent: assemble context → call the model → execute the returned action (usually a tool call) → feed the result back → repeat until done or a stopping condition fires. It is "loop engineering" in its purest form — the loop *is* the agent.

## The canonical form

```text
while (!done) {
  response = callLLM(context);
  if (response is a tool call) { result = run tool; context.push(result); }
  else { done = true; }
}
```

Braintrust (Aug 2025) observes that the most successful production agents — **Claude Code, the OpenAI Agents SDK** — all converge on this exact shape. The loop is trivial; the engineering lives at the edges: tool design, context engineering, evaluation. The **Bitter Lesson applies to agents**: the simplest, most general pattern beats hand-crafted rigid frameworks as models improve. (Source: [[Braintrust - Canonical Agent Loop]])

## The loop is older than its 2025 framing

[[ReAct]] (Yao et al. 2022) instantiated the loop as **Thought → Action → Observation**, grounding reasoning in external tools to curb hallucination. The 2025 "while-loop-with-tools" framing is the same loop with the reasoning trace made implicit (models now reason internally) and tool-calling made native to the API. (Source: [[ReAct - Synergizing Reasoning and Acting]])

## What turns a loop into an *agent*

Anthropic's distinction: a **workflow** routes the LLM through *predefined* code paths; an **agent** lets the LLM *dynamically direct its own* process and tool use, operating for many turns with ground-truth feedback at each step and stopping conditions (max iterations) for control. The loop is shared; autonomy is the variable. (Source: [[Anthropic - Building Effective Agents]])

## Why the loop is also where things break

Because every iteration feeds the previous result forward, the loop **compounds errors** — one hallucinated fact or corrupted tool output cascades through Memory → Reflection → Planning → Action. Engineering the loop therefore means engineering *termination, checkpointing, and error containment*, not just the happy path. See [[Agent Error Propagation]]. (Sources: [[Anthropic - Multi-Agent Research System]], [[Galileo - Agent Failure Modes]])

## Extension points

- **Sub-agent** — a tool call that invokes an *independent* loop with its own context window (compression via separation of concerns).
- **Multi-agent** — independent loops passing messages via tool calls; an orchestrator loop spawns worker loops. Multi-agent helps breadth-first/parallel research, hurts when agents share context or have dependencies.
- **Reflection layer** — wrap the loop in an evaluate-critique-retry cycle ([[Reflexion]]).

---

## Connection: Harness Engineering

[[Harness Engineering]] is the discipline of engineering the environment *around* this loop — it governs every transition (init → scope → verify → handoff). The loop is what gets harnessed; the harness's five subsystems ([[Repository as System of Record|Instructions]], State, [[Verification-Gated Completion|Verification]], [[Agent Scope Control|Scope]], [[Agent Session Lifecycle|Lifecycle]]) are what turn loop output from aspirational into reliable. See [[Learn-Harness-Engineering]].
