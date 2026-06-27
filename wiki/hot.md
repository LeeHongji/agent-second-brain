---
type: meta
title: "Hot Cache"
updated: 2026-06-28
tags:
  - meta
  - hot-cache
status: evergreen
related:
  - "[[index]]"
  - "[[log]]"
  - "[[overview]]"
  - "[[Harness Engineering]]"
---

# Recent Context

Navigation: [[index]] | [[log]] | [[overview]]

## Last Updated

2026-06-28. **Ingested [[Agent-Native Applications|Agent-Native]]** (Builder.io) — framework for agent-native apps: **agent + UI as equal citizens** sharing one SQL DB/state; `defineAction` as the unified action primitive (one def = agent tool + HTTP endpoint + validation + UI-refresh); A2A; self-modifying apps; runtime tools. It's the **application-layer** realization of this vault's agent-layer patterns ([[Agentic Loop]], [[Augmented LLM]], [[Context Engineering]], [[Harness Engineering]]). 5 concept + 1 entity pages.

2026-06-26. **Ingested [[MinerU]]** (opendatalab/MinerU v3.4) — the canonical document→Markdown/JSON parsing engine for LLM/RAG/Agent pipelines. Spawned [[Document Parsing]], [[VLM-based Document Parsing]], [[Math Formula Recognition]] + entities [[OpenDataLab]], [[OmniDocBench]]. This is the **ingestion-tooling** front-end: how PDFs/papers/books would enter this vault.

2026-06-25. **Ingested WalkingLabs' `learn-harness-engineering`** — a 12-lecture + 6-project course on engineering AI coding agents. This is the **keystone ingest**: it introduced [[Harness Engineering]] as the umbrella discipline that reorganizes everything else in this vault.

## Key Recent Facts

- **Harness = the environment that makes a frozen LLM reliable.** Thesis: "the model is smart; the harness makes it reliable." Reliability is an environment property, not a model property. (Source: [[Learn-Harness-Engineering]])
- **Evidence:** same Opus 4.5 — no harness $9/20min/failed; full harness $200/6h/playable. Model unchanged; harness did it.
- **5 subsystems:** Instructions / State / Verification / Scope / Session Lifecycle. The MODEL decides what code to write; the HARNESS governs when/where/how.
- **Session lifecycle:** START → SELECT (one feature) → EXECUTE (verify) → WRAP UP (clean handoff). Init is its own phase; next session's success depends on this session's cleanup.
- **Two load-bearing rules:** confidence ≠ correctness (only a full-pipeline run = done); if the agent can't see it in a file, it doesn't exist (repo = system of record).
- **It's the umbrella for this vault:** subsumes [[Context Engineering]] (Instructions), governs the [[Agentic Loop]], and its Verification + [[Agent Observability]] subsystems are the structural fix for [[Agent Error Propagation]]. It also contextualizes [[SkillOpt]] (optimizes one piece of Instructions).

## Recent Changes

- 2026-06-26: Created [[MinerU]] (source), [[OpenDataLab]], [[OmniDocBench]], [[Document Parsing]], [[VLM-based Document Parsing]], [[Math Formula Recognition]] — first pages in the document-parsing / data-ingestion topic.
- Created: [[Learn-Harness-Engineering]] (source), [[Harness Engineering]] (★ keystone), [[Repository as System of Record]], [[Agent Session Lifecycle]], [[Agent Scope Control]], [[Verification-Gated Completion]], [[Agent Observability]]
- Cross-referenced: [[Agentic Loop]], [[Context Engineering]], [[Agent Error Propagation]]
- Earlier today: SkillOpt ingest (4 pages), lint pass (10 fixes).
- 🎨 Tool note: [[Ian-Xiaohei-Illustrations]] — 小黑配图 Codex Skill, recorded as the **blog 配图** tool for `/release-blog` (16:9 手绘白底, one cognitive anchor/image).

## Active Threads

- **The big reframe:** reliability is an *environment* property. Everything in this vault (loops, context, skills, error containment) is now organized under harness engineering as the parent discipline.
- **Meta-connection:** the repo ships a `harness-creator` skill — the same skill available in THIS Claude Code session. agent-second-brain's own hooks/transport/lock/concurrency layer is itself a (wiki-flavored) harness.
- **Standing authorization (memory):** complete KB work autonomously when ready, no per-step approval.
- **Env gaps (memory):** `flock` missing on macOS → wiki-lock + address-allocation skipped; ollama absent → tiling skipped. Not bugs, known limits.
