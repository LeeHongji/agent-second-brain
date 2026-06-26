---
type: source
created: 2026-06-25
updated: 2026-06-25
title: "SkillOpt: Executive Strategy for Self-Evolving Agent Skills"
source_type: paper
author: "Yifan Yang, Ziyang Gong, Weiquan Huang, Qihao Yang, et al. (Microsoft Research)"
date_published: 2026
venue: "arXiv 2605.23904 (Microsoft Research); pip install skillopt v0.1.0"
url: "https://github.com/microsoft/SkillOpt"
paper: "https://arxiv.org/abs/2605.23904"
confidence: high
key_claims:
  - "Treat the skill document (Markdown) as the trainable parameters of a frozen LLM"
  - "Trains skills with DL discipline (epochs, batch, LR, validation gates) in TEXT space, not weight space"
  - "Candidate edit accepted only when it strictly improves held-out validation score"
  - "Adds zero inference-time model calls at deployment (artifact = best_skill.md, 300-2000 tokens)"
  - "Best or tied-best on all 52 (model, benchmark, harness) cells across 6 benchmarks / 7 models / 3 harnesses"
  - "GPT-5.5 lift: +23.5 (chat), +24.8 (Codex loop), +19.1 (Claude Code)"
  - "Optimized skills transfer across model scales, harnesses, and nearby benchmarks"
tags:
  - source
  - agents
  - skills
  - optimization
status: canonical
related:
  - "[[Text-Space Optimization]]"
  - "[[Textual Gradient]]"
  - "[[Validation-Gated Skill Update]]"
  - "[[Context Engineering]]"
  - "[[Augmented LLM]]"
  - "[[Reflexion]]"
---

# SkillOpt: Executive Strategy for Self-Evolving Agent Skills

Microsoft Research, 2026 (arXiv 2605.23904). Open source (`pip install skillopt`, v0.1.0 2026-06-02, MIT).

A **text-space optimizer** that trains reusable natural-language **skills** for **frozen LLM agents**. The thesis: modern agent skills are hand-crafted, one-shot generated, or loosely self-revised — none behaves like a deep-learning optimizer for the skill. SkillOpt makes the **skill document the trainable state**, trained with the discipline that makes weight-space optimization reproducible.

## How it works

A separate **optimizer** model turns scored **rollouts** into bounded add/delete/replace edits on a single skill document; a candidate edit is accepted **only when it strictly improves a held-out validation score**. A textual learning-rate budget, a rejected-edit buffer, and epoch-wise slow/meta updates keep it stable. Deployed artifact: a compact `best_skill.md` that runs against the unchanged target model — **zero extra inference calls**.

The 6-stage loop: **Rollout → Reflect → Aggregate → Select → Update → Gate**, with **Slow Update** + **Meta Skill** at epoch boundaries. See [[Text-Space Optimization]], [[Textual Gradient]], [[Validation-Gated Skill Update]].

## Evidence

6 benchmarks (alfworld, docvqa, livemath, officeqa, searchqa, spreadsheetbench) × 7 target models × 3 harnesses (direct chat, Codex CLI, Claude Code CLI). Best or tied-best on all 52 cells. GPT-5.5 average no-skill lift: **+23.5 / +24.8 / +19.1** across the three harnesses. Skills transfer across model scales, between Codex/Claude Code, and to nearby benchmarks without re-optimization.

## Architecture (repo)

- `skillopt/` — `optimizer/` (skill, rewrite, select, scheduler, meta_skill, slow_update, clip, lr_autonomous), `gradient/` (aggregate, reflect), `engine/trainer.py`, `evaluation/gate.py`, `model/` (backends: azure_openai, claude, codex, minimax, qwen), `prompts/` (analyst/merge/ranking/rewrite = textual-gradient templates).
- `skillopt_sleep/` — **SkillOpt-Sleep** (2026-06-15 preview): nightly offline self-evolution for local coding agents (Claude Code/Codex/Copilot) — review past sessions, replay recurring tasks, consolidate validated skills behind a held-out gate.
- `plugins/` — integrations for claude-code, codex, copilot, openclaw. `ckpt/` — per-benchmark checkpoint skills.

## Why it matters here

SkillOpt is **automated [[Context Engineering]]**: it turns the skill/prompt — the part [[Braintrust - Canonical Agent Loop]] identified as the agent's core ("just a system prompt and tools") — into a *trained* artifact instead of a hand-written one. Its Reflect stage is a [[Reflexion]] loop pointed at the **skill document** (persistent) rather than the trajectory buffer (ephemeral). Its Gate is the evaluator-optimizer pattern from [[Agentic Workflow Patterns]] applied to the skill. agent-second-brain itself is a set of skill documents — in principle a SkillOpt-style optimizer could train THIS vault's skills.

> [!key-insight] Signature contribution
> The disciplined claim is not "LLMs can rewrite prompts" — it is that **weight-space training mechanics (gradient, clipping, LR schedule, validation gate, momentum, meta-learning) have precise text-space analogues that make skill optimization reproducible**, not alchemical. (Source: [[SkillOpt]])
