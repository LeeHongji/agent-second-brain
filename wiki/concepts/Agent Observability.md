---
type: concept
title: "Agent Observability"
complexity: intermediate
domain: agents
aliases:
  - "Runtime Observability"
  - "Harness Observability"
created: 2026-06-25
updated: 2026-06-25
tags:
  - concept
  - agents
  - harness-engineering
  - observability
status: developing
related:
  - "[[Harness Engineering]]"
  - "[[Learn-Harness-Engineering]]"
  - "[[Agent Error Propagation]]"
  - "[[Verification-Gated Completion]]"
  - "[[Anthropic - Multi-Agent Research System]]"
sources:
  - "[[Learn-Harness-Engineering]]"
---

# Agent Observability

Observability belongs **inside the harness**, not bolted on afterward. If you cannot see what the agent did at runtime, you cannot fix what it broke. (Course lecture L11. Source: [[Learn-Harness-Engineering]])

## What it means

A harnessed agent emits a runtime log of its decisions, tool calls, verification results, and deviations — structured so a human (or the next agent session) can reconstruct what happened and why. The course's P06 (capstone) builds this alongside the other subsystems, and treats an ablation study (harness-with vs harness-without observability) as the proof that observability changes outcomes: with it, failures are diagnosable; without it, the same failures are mysterious.

This mirrors the [[Anthropic - Multi-Agent Research System|Anthropic multi-agent]] finding: production agent reliability requires full tracing of *decision patterns* (not conversation contents) to diagnose why agents fail, plus monitoring of agent interaction structures.

## Why it must be in the harness

Post-hoc debugging of an agent run is near-impossible without runtime signal — the model's reasoning is opaque, the failure is semantic (a hallucinated path, a skipped step), and "users report it didn't work" gives you nothing to grep. Embedding logging in the harness turns each run into a queryable artifact: which feature, which tool calls, did verification run, what passed/failed, what was left broken.

## Relationship to neighbors

- Observability is the **detection layer** for [[Agent Error Propagation]] — you can only intervene at the earliest critical error if you can see decisions traced back to their source module.
- It pairs with [[Verification-Gated Completion]]: verification tells you pass/fail *now*; observability tells you *what happened* so you can fix the root cause.
- The vault's own lint reports (`wiki/meta/lint-report-*.md`) and operation log are the wiki-side analogue: a persisted, queryable record of what the agent did, for the next session to read. (Source: [[Learn-Harness-Engineering]])
