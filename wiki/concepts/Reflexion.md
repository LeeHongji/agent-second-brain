---
type: concept
title: "Reflexion"
complexity: intermediate
domain: agents
aliases:
  - "Self-Reflection Loop"
  - "Verbal Reinforcement Learning"
created: 2026-06-24
updated: 2026-06-24
tags:
  - concept
  - agents
  - reasoning
  - memory
status: developing
related:
  - "[[ReAct]]"
  - "[[Agentic Loop]]"
  - "[[Augmented LLM]]"
  - "[[Agent Error Propagation]]"
sources:
  - "[[The AI Engineer - Single-Agent Patterns]]"
---

# Reflexion

**Reflexion** (Shinn et al.) is the self-improvement layer for agent loops: after a full attempt, an **evaluator** scores the result, a **self-reflection** module writes a verbal critique of what went wrong, that critique is stored in an **episodic memory buffer**, and the agent **retries the whole task** with its past mistakes as context. It is the only common single-agent pattern that gets better on the *same* task across attempts.

## The loop on top of a loop

```text
attempt → evaluate (run tests / validate schema / check answer)
       → if below threshold: reflect (verbal critique) → store in memory → retry
```

It composes with any base pattern — Reflexion-on-[[ReAct]] is the most common hybrid: step-by-step adaptation for the common case, self-correction for the hard ones.

## Evidence and limits

- **GPT-4 HumanEval: 80% → 91%** with Reflexion. ReAct + Reflexion completed 130/134 AlfWorld tasks. (Source: [[The AI Engineer - Single-Agent Patterns]])
- Works only with **clear, automated success criteria** (run the tests; validate against a schema). If "wrong" is subjective ("write a good email"), the evaluator has nothing to score.
- **Diminishing returns** — most gain lands on retries 1–2; by retry 4–5 the model re-treads the same approaches.

## The self-critique blind spot (filed contradiction)

A 2025 replication study found single-agent Reflexion can **reinforce its own blind spots**: the *same model* generates both the output and the critique, so misconceptions persist across retries rather than getting corrected. The fix is structural — use a *different* model or an independent evaluator for the critique, or ground the evaluator in external ground truth (test results, not the model's own judgment). This is a specific instance of [[Agent Error Propagation]]: an error in the evaluator propagates into the memory buffer, which propagates into every subsequent retry. (Source: [[The AI Engineer - Single-Agent Patterns]])

## Cost profile

Every retry is a **full task execution** plus evaluation + reflection overhead — 3 attempts ≈ 3x the cost of one run, with multiplied latency. Not viable for real-time, user-facing tasks; well-suited to batch/background coding and extraction where correctness outweighs speed.

---

## Connection: SkillOpt

[[SkillOpt]]'s Reflect stage is a [[Reflexion]] loop pointed at the **skill document** (persistent artifact) instead of the trajectory buffer (ephemeral memory): Reflexion fixes the current attempt; SkillOpt's [[Textual Gradient]] fixes the program for every future run. Both share Reflexion's self-critique blind spot — SkillOpt mitigates it with an independent [[Validation-Gated Skill Update|gate]] rather than the model judging its own output.
