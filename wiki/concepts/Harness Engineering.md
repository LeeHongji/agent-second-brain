---
address: c-000014
type: concept
title: "Harness Engineering"
complexity: advanced
domain: agents
aliases:
  - "Agent Harness"
  - "Harness Design"
created: 2026-06-25
updated: 2026-06-25
tags:
  - concept
  - agents
  - harness-engineering
  - architecture
status: developing
related:
  - "[[Learn-Harness-Engineering]]"
  - "[[Repository as System of Record]]"
  - "[[Agent Session Lifecycle]]"
  - "[[Agent Scope Control]]"
  - "[[Verification-Gated Completion]]"
  - "[[Agent Observability]]"
  - "[[Agentic Loop]]"
  - "[[Context Engineering]]"
  - "[[Agent Error Propagation]]"
  - "[[Augmented LLM]]"
sources:
  - "[[Learn-Harness-Engineering]]"
---

# Harness Engineering

**Harness engineering** is the discipline of building the complete working environment around an LLM so it produces reliable results in real repositories over multiple sessions. The load-bearing claim: **the model is smart; the harness makes it reliable.** The strongest model fails on real engineering tasks without a proper environment — this is a harness problem, not a model problem. (Source: [[Learn-Harness-Engineering]])

## The evidence

Same model (Opus 4.5), same prompt, with vs without a harness (course-cited Anthropic experiment): **$9 / 20 min / broken** vs **$200 / 6 hours / playable**. The model did not change; the harness did. OpenAI reports the same qualitative "unreliable → reliable" shift for Codex in a well-harnessed repo. Harness engineering is the discipline that produces that shift deliberately.

## What the harness is

> The MODEL decides what code to write. The HARNESS governs when, where, and how it writes it. The harness doesn't make the model smarter — it makes the model's output reliable.

A harness has **five subsystems**, each with one job:

| Subsystem | Job | Artifacts |
|---|---|---|
| **Instructions** | what to do, in what order, what to read first (progressive disclosure) | `AGENTS.md`, `CLAUDE.md`, `feature_list`, `docs/` |
| **State** | what's done / in-progress / next, persisted to disk | `progress.md`, `feature_list.json`, git log, session handoff |
| **Verification** | only a passing test suite is evidence of done | tests, lint, type-check, smoke, e2e |
| **Scope** | one feature at a time; explicit definition of done | feature_list.json, scope tracker |
| **Session Lifecycle** | init at start, clean state at end, safe-to-resume commit | `init.sh`, clean-state checklist, handoff note |

See [[Repository as System of Record]], [[Agent Session Lifecycle]], [[Agent Scope Control]], [[Verification-Gated Completion]], [[Agent Observability]] for depth on each.

## How it relates to this vault

Harness engineering is the **umbrella** the vault's agent concepts sit under (awesome-harness-engineering defines it as "the intersection of context engineering, evaluation, observability, orchestration, safe autonomy, and software architecture"):

- It **governs the [[Agentic Loop]]** — the harness governs every transition; the loop is what's being harnessed.
- It **subsumes [[Context Engineering]]** — Instructions is the context-engineering subsystem, structured as files rather than ad-hoc prompts.
- Its Verification + [[Agent Observability]] subsystems are the **structural mitigation for [[Agent Error Propagation]]** — they replace "agent says it looks fine" with "tests pass, lint clean, types check."
- It **contextualizes [[SkillOpt]]** — skill optimization trains one piece of Instructions; harness engineering is the whole system. A SkillOpt-style optimizer could tune a harness's `AGENTS.md`.
- It productionizes the [[Braintrust - Canonical Agent Loop|Braintrust]] thesis ("agent = system prompt + tools") and the [[Anthropic - Building Effective Agents|evaluator-optimizer]] pattern.

> [!key-insight] The reframe
> Most agent work asks "can the model do X?" Harness engineering asks: **"can the model reliably complete X inside a real repo, over multiple sessions, without constant supervision?"** — and answers "not without a harness." Reliability is an environment property, not a model property.
