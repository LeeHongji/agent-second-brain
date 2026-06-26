---
address: c-000004
type: concept
title: "Agent Error Propagation"
complexity: advanced
domain: agents
aliases:
  - "Error Cascades"
  - "Compounding Errors"
  - "Failure Cascades"
created: 2026-06-24
updated: 2026-06-24
tags:
  - concept
  - agents
  - reliability
status: developing
related:
  - "[[Agentic Loop]]"
  - "[[Reflexion]]"
  - "[[Anthropic - Multi-Agent Research System]]"
sources:
  - "[[Galileo - Agent Failure Modes]]"
  - "[[Anthropic - Multi-Agent Research System]]"
---

# Agent Error Propagation

In traditional software, a bug breaks a feature. In an **agentic loop**, a minor error at step *k* becomes context for step *k+1*, rerouting the entire trajectory. Errors **compound** rather than staying local. Galileo's headline finding: it is *error propagation* — not the sheer variety of failure modes — that kills agent reliability in production. (Source: [[Galileo - Agent Failure Modes]])

## Why the loop is an error amplifier

Every iteration feeds the previous result forward across **Memory → Reflection → Planning → Action** (the MAST taxonomy's four surfaces). A single hallucinated fact (a phantom SKU) triggers N downstream tool calls — pricing, stock, shipping, customer notifications — before monitoring catches it. The loop that makes agents capable (grounded, multi-step) is the same loop that makes them fragile.

## Where errors originate (MAST, 14 modes → 7 operational patterns)

1. **Specification gaps** — ambiguous requirements ("remove outdated entries") cascade into every action.
2. **Hallucination cascades** — one invented fact multiplies across systems.
3. **Memory/context corruption** — poisoned state persists across sessions (Unit 42: injected instructions survived restarts).
4. **Multi-agent communication breakdowns** — format drift at handoffs → silent corruption green health checks miss.
5. **Tool misuse** — over-permissioned tools cause blast-radius damage ("cleanup" deletes prod).
6. **Prompt injection** — OWASP LLM01; direct and indirect (poisoned retrieved docs).
7. **Verification/termination failures** — half-extracted contracts, or infinite refinement loops burning compute.

## The production-grade mitigations

Anthropic's multi-agent system treats this as the core engineering problem:
- **Resume-from-checkpoint, not restart** — long-running stateful agents can't afford to restart on failure.
- **Combine AI adaptivity with deterministic safeguards** — retry logic, regular checkpoints, max-iteration caps (turn infinite loops into alarms).
- **Full production tracing** of *decision patterns* (not conversation contents) to diagnose why, not just that, agents fail.
- **Rainbow deployments** — roll updates gradually so running agents aren't broken mid-process.
- **Outcome-based + LLM-as-judge + human evaluation** — humans catch biases automated evals miss (e.g., preferring SEO farms over authoritative PDFs).

(Source: [[Anthropic - Multi-Agent Research System]])

## Detection principle

Trace each decision back to its **source module**, separate **root cause** from **downstream symptom**, and intervene at the earliest critical error before it corrupts subsequent decisions. The mistake is treating the visible symptom (a wrong final answer) instead of the originating error (a corrupted memory write three steps earlier). This is also why [[Reflexion]]'s self-critique can backfire: if the evaluator itself is wrong, the error propagates *into memory* and repeats every retry.

## Governance outlook

Gartner forecasts that by 2030, half of agent deployment failures will trace to insufficient **runtime governance** — i.e., the inability to enforce policies, contain blast radius, and roll back at runtime. Reliability is becoming a platform problem, not a model problem. (Source: [[Galileo - Agent Failure Modes]])

---

## Connection: Harness Engineering (the structural fix)

Harness engineering is the structural answer to error propagation. [[Verification-Gated Completion]] replaces "agent says it looks fine" with a passing full pipeline; [[Agent Observability]] makes the cascading failure diagnosable; the [[Agent Session Lifecycle]]'s clean-handoff step stops session N's error from becoming session N+1's starting state. The harness is what contains the compounding. Source: [[Learn-Harness-Engineering]].
