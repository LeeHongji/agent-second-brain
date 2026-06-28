---
address: c-000070
type: moc
title: "Agent Reliability"
domain: agents
created: 2026-06-28
updated: 2026-06-28
tags: [moc, agents, reliability]
status: developing
members:
  - "[[Harness Engineering]]"
  - "[[Repository as System of Record]]"
  - "[[Agent Session Lifecycle]]"
  - "[[Agent Scope Control]]"
  - "[[Verification-Gated Completion]]"
  - "[[Agent Observability]]"
related:
  - "[[Agent Loops]]"
  - "[[Text-Space Training]]"
---

# Agent Reliability

**Reliability is an environment property, not a model property.** "The model is smart; the harness makes it reliable." This cluster is the discipline of building the environment (the *harness*) around a frozen LLM so it produces trustworthy output: five subsystems (Instructions / State / Verification / Scope / Session Lifecycle), with the repo as the system of record. Same Opus 4.5 — no harness $9/failed; full harness $200/playable. The model is unchanged; the harness did it. This is the keystone reframe of the vault.

## Members

| Page | Role |
|---|---|
| [[Harness Engineering]] | ★ keystone — the discipline; 5 subsystems; "model smart, harness reliable" |
| [[Repository as System of Record]] | the repo IS the harness's memory; progressive disclosure over one giant AGENTS.md |
| [[Agent Session Lifecycle]] | START→SELECT→EXECUTE→WRAP UP; init phase, clean handoff |
| [[Agent Scope Control]] | one feature at a time; `feature_list.json` as scope boundary |
| [[Verification-Gated Completion]] | confidence ≠ correctness; only a full-pipeline run = done |
| [[Agent Observability]] | runtime logging; if you can't see what it did, you can't fix what it broke |

## Foundational source
- [[Learn-Harness-Engineering]] — WalkingLabs course (12 lectures + 6 projects); the $9→$200 experiment.

## Open tensions within this cluster
- [[Harness Engineering]] is the umbrella that also re-frames pages in [[Agent Loops]] (it subsumes [[Context Engineering]] as its Instructions subsystem and governs the [[Agentic Loop]]).

## Cross-cluster
Governed-by inverse of [[Agent Loops]]. Its Instructions subsystem is what [[Text-Space Training]] (SkillOpt) optimizes automatically — the two clusters meet at "how to author the harness's instructions."
