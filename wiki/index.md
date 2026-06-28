---
type: meta
title: "Wiki Index"
updated: 2026-06-28
tags:
  - meta
  - index
status: evergreen
related:
  - "[[overview]]"
  - "[[log]]"
  - "[[hot]]"
  - "[[dashboard]]"
  - "[[Wiki Map]]"
  - "[[Agent Loops]]"
  - "[[Agent Reliability]]"
  - "[[Text-Space Training]]"
  - "[[Agent-Native Architecture]]"
  - "[[Document AI]]"
  - "[[LLM Wiki Design]]"
  - "[[SEO & Search Engineering]]"
  - "[[Claude + Obsidian Ecosystem]]"
  - "[[LLM Wiki Pattern]]"
  - "[[Compounding Knowledge]]"
---

# Wiki Index

Last updated: 2026-06-28 | Total pages: 64 | Sources ingested: 12 | Clusters (MOCs): 8

Navigation: [[overview]] | [[log]] | [[hot]] | [[dashboard]] | [[Wiki Map]] | [[getting-started]] | [[knowledge-gardening|🌿 How to garden]]

Organized by topic cluster (MOC). Each MOC groups its concepts, sources, and entities together — browse by topic, not by type. Regrouped by `/wiki-garden organize` 2026-06-28.

---

## Map of Contents

- [[Agent Loops]] — the canonical loop + reasoning patterns around it (14)
- [[Agent Reliability]] — the environment that makes a frozen LLM reliable (7)
- [[Text-Space Training]] — train a frozen LLM by editing skill/prompt text (4)
- [[Agent-Native Architecture]] — apps where agent + UI are equal citizens (7)
- [[Document AI]] — documents → structured Markdown/JSON for LLM pipelines (6)
- [[LLM Wiki Design]] — the vault's own knowledge architecture (10)
- [[SEO & Search Engineering]] — engineering SEO, not guessing it (5)
- [[Claude + Obsidian Ecosystem]] — neighbor/competitor research + tooling (11)

---

## Agent Loops
↳ MOC: [[Agent Loops]]

- [[Augmented LLM]] — Anthropic's base unit: LLM + retrieval + tools + memory
- [[Agentic Loop]] — the canonical while-loop-with-tools; the loop IS the agent
- [[ReAct]] — Thought→Action→Observation, 2022 default reasoning pattern
- [[Reflexion]] — evaluate→critique→retry-with-memory self-improvement layer
- [[Agentic Workflow Patterns]] — chaining, routing, parallelization, orchestrator-workers, evaluator-optimizer
- [[Context Engineering]] — tools are ~80% of agent context; engineer outputs/ACI over prompts
- [[Agent Error Propagation]] — why the loop compounds errors; how production contains it
- Sources: [[ReAct - Synergizing Reasoning and Acting]] · [[Braintrust - Canonical Agent Loop]] · [[Anthropic - Multi-Agent Research System]] · [[Anthropic - Building Effective Agents]] · [[The AI Engineer - Single-Agent Patterns]] · [[Galileo - Agent Failure Modes]]
- Synthesis: [[Research - Agentic Loop Engineering]]

---

## Agent Reliability
↳ MOC: [[Agent Reliability]]

- [[Harness Engineering]] — ★ keystone: the env that makes a frozen LLM reliable; 5 subsystems
- [[Repository as System of Record]] — repo IS the harness's memory; progressive disclosure
- [[Agent Session Lifecycle]] — START→SELECT→EXECUTE→WRAP UP; clean handoff
- [[Agent Scope Control]] — one feature at a time; `feature_list.json` as scope boundary
- [[Verification-Gated Completion]] — confidence ≠ correctness; full-pipeline run = done
- [[Agent Observability]] — runtime logging; see what it did to fix what it broke
- Source: [[Learn-Harness-Engineering]]

---

## Text-Space Training
↳ MOC: [[Text-Space Training]]

- [[Text-Space Optimization]] — train a frozen LLM by editing skill/prompt text
- [[Textual Gradient]] — text analogue of a weight gradient; edit patch from failed rollouts
- [[Validation-Gated Skill Update]] — accept edit only if beats held-out validation
- Source: [[SkillOpt]]

---

## Agent-Native Architecture
↳ MOC: [[Agent-Native Architecture]]

- [[Agent-Native Applications]] — agent+UI equal citizens sharing one DB/state; "click it or ask it"
- [[Unified Action Primitive]] — `defineAction` = tool + endpoint + validation + UI-refresh
- [[Agent-to-Agent Communication]] — A2A; agents discover/call agents across apps
- [[Self-Modifying Applications]] — agent edits app's own source
- [[Agent Runtime Tools]] — runtime mini-apps, no source changes/migrations
- Source: [[Agent-Native]] · Entity: [[Builder.io]]

---

## Document AI
↳ MOC: [[Document AI]]

- [[Document Parsing]] — documents → structured Markdown/JSON; ingestion front-end
- [[VLM-based Document Parsing]] — single VLM vs traditional pipeline
- [[Math Formula Recognition]] — image→LaTeX; makes scientific PDFs machine-readable
- Source: [[MinerU]] · Entities: [[OpenDataLab]] · [[OmniDocBench]]

---

## LLM Wiki Design
↳ MOC: [[LLM Wiki Design]]

- [[LLM Wiki Pattern]] — the core pattern for persistent, compounding knowledge bases
- [[Compounding Knowledge]] — why wiki knowledge grows more valuable over time, unlike RAG
- [[Hot Cache]] — ~500-word session context file
- [[DragonScale Memory]] — fold operator, deterministic addresses, semantic tiling, boundary-first autoresearch
- [[Persistent Wiki Artifact]] — durable Markdown page as the LLM's memory object
- [[Source-First Synthesis]] — provenance discipline; raw sources immutable
- [[Query-Time Retrieval]] — query synthesis with citations; complements Obsidian search
- Comparison: [[Wiki vs RAG]] · Question: [[How does the LLM Wiki pattern work]] · Entity: [[Andrej Karpathy]]

---

## SEO & Search Engineering
↳ MOC: [[SEO & Search Engineering]]

- [[SEO Drift Monitoring]] — "git for SEO"; baseline/diff/track; 17 rules; SQLite
- [[Search Experience Optimization]] — "read SERPs backwards"; page-type mismatch + persona scoring
- [[Semantic Topic Clustering]] — SERP-based keyword grouping; hub-spoke architecture
- [[Pro Hub Challenge]] — community-challenge pattern for building extensions
- Entity: [[Claude SEO]]

---

## Claude + Obsidian Ecosystem
↳ MOC: [[Claude + Obsidian Ecosystem]]

- [[kepano-obsidian-skills]] · [[Ar9av-obsidian-wiki]] · [[Nexus-claudesidian-mcp]] · [[ballred-obsidian-claude-pkm]] · [[rvk7895-llm-knowledge-bases]] · [[Claudian-YishenTu]]
- [[Claude SEO]] · [[cherry-picks]] · [[SVG Diagram Style Guide]] · [[Ian-Xiaohei-Illustrations]]
- Source: [[agent-second-brain-ecosystem-research]] · Comparison: [[agent-second-brain-ecosystem]]

---

## Decisions

- [[2026-04-14-community-cta-rollout]] - community CTA footer added to 6 skill repos with per-tool frequency rules (status: active)
- [[2026-04-15-slides-and-release-session]] - Claude SEO v1.9.0 slides (15-slide HTML deck) + GitHub release v1.9.0 with PDF asset (status: complete)
- [[2026-04-15-release-report-session]] - Claude SEO v1.9.0 Release Report PDF: dark theme, 13 pages, WeasyPrint layout fixes, Challenge v2 added (status: complete)
- [[2026-04-14-claude-seo-v190-session]] - Claude SEO v1.9.0 Pro Hub Challenge integration: 5 submissions, 4 new skills, 4 review rounds, cybersecurity audit (status: complete)

---

## Domains

<!-- Add domain entries here after scaffold -->
