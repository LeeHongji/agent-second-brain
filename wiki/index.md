---
type: meta
title: "Wiki Index"
updated: 2026-06-24
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
  - "[[concepts/_index]]"
  - "[[entities/_index]]"
  - "[[sources/_index]]"
  - "[[LLM Wiki Pattern]]"
  - "[[Hot Cache]]"
  - "[[Compounding Knowledge]]"
  - "[[Andrej Karpathy]]"
---

# Wiki Index

Last updated: 2026-06-28 | Total pages: 64 | Sources ingested: 10

Navigation: [[overview]] | [[log]] | [[hot]] | [[dashboard]] | [[Wiki Map]] | [[getting-started]]

---

## Concepts

- [[LLM Wiki Pattern]] — the pattern for building persistent, compounding knowledge bases using LLMs (status: mature)
- [[Hot Cache]] — ~500-word session context file, updated after every ingest and session (status: mature)
- [[Compounding Knowledge]] — why wiki knowledge grows more valuable over time, unlike RAG (status: mature)
- [[cherry-picks]] — prioritized feature backlog from ecosystem research; 13 features to add to agent-second-brain (status: current)
- [[SVG Diagram Style Guide]] — canonical visual style for all diagrams: Space Grotesk, #0A0A0A dark theme, #E07850 accent, full design tokens (status: evergreen)
- [[Pro Hub Challenge]] — community challenge pattern for building claude-seo/claude-blog extensions; first challenge produced 6 submissions, 5 integrated in v1.9.0 (status: evergreen)
- [[Semantic Topic Clustering]] — SERP-based keyword grouping replacing paid tools; hub-spoke architecture with interactive visualization (status: evergreen)
- [[Search Experience Optimization]] — "read SERPs backwards" methodology for page-type mismatch detection and persona scoring (status: evergreen)
- [[SEO Drift Monitoring]] — "git for SEO" baseline/diff/track with 17 comparison rules and SQLite persistence (status: evergreen)
- [[DragonScale Memory]] — memory-layer spec inspired by the Heighway dragon curve; fold operator, deterministic page addresses, semantic tiling, boundary-first autoresearch (status: shipped v0.4, all four mechanisms opt-in)
- [[Persistent Wiki Artifact]]: durable Markdown page as the LLM's memory object, distinct from ephemeral chat turns (status: developing)
- [[Source-First Synthesis]]: provenance discipline; raw sources stay immutable while the wiki layer is synthesized and cited (status: developing)
- [[Query-Time Retrieval]]: wiki query path synthesizes with citations; complementary to Obsidian's in-vault search (status: developing)
- [[Agentic Loop]] — the canonical while-loop-with-tools; the loop IS the agent. Bitter Lesson applies to agents (status: developing, 2026-06-24)
- [[Augmented LLM]] — Anthropic's base unit: LLM + retrieval + tools + memory (status: developing, 2026-06-24)
- [[ReAct]] — Thought→Action→Observation, the 2022 default reasoning pattern for tool-using agents (status: developing, 2026-06-24)
- [[Agentic Workflow Patterns]] — prompt chaining, routing, parallelization, orchestrator-workers, evaluator-optimizer (status: developing, 2026-06-24)
- [[Reflexion]] — evaluate→critique→retry-with-memory self-improvement layer (status: developing, 2026-06-24)
- [[Context Engineering]] — tools are ~80% of agent context; engineer outputs/ACI over prompts (status: developing, 2026-06-24)
- [[Agent Error Propagation]] — why the loop compounds errors and how production contains it (status: developing, 2026-06-24)
- [[Text-Space Optimization]] — train a frozen LLM by editing skill/prompt text with DL-grade discipline; weights stay frozen (status: developing, 2026-06-25)
- [[Textual Gradient]] — the text-space analogue of a weight gradient: an edit patch produced by reflecting on failed rollouts (status: developing, 2026-06-25)
- [[Validation-Gated Skill Update]] — accept a skill edit only if it beats held-out validation; patience + slow update + meta skill (status: developing, 2026-06-25)
- [[Harness Engineering]] — ★ keystone: the discipline of building the environment that makes a frozen LLM reliable; 5 subsystems; "model smart, harness reliable" (status: developing, 2026-06-25)
- [[Repository as System of Record]] — the repo IS the harness's memory; progressive disclosure over one giant AGENTS.md (status: developing, 2026-06-25)
- [[Agent Session Lifecycle]] — START→SELECT→EXECUTE→WRAP UP; init phase, continuity, clean handoff (status: developing, 2026-06-25)
- [[Agent Scope Control]] — one feature at a time; feature_list.json as machine-readable scope boundary; definition of done (status: developing, 2026-06-25)
- [[Verification-Gated Completion]] — confidence ≠ correctness; only a full-pipeline run counts as done (status: developing, 2026-06-25)
- [[Agent Observability]] — runtime logging inside the harness; if you can't see what it did, you can't fix what it broke (status: developing, 2026-06-25)
- [[Document Parsing]] — documents (PDF/Office/images) → structured Markdown/JSON; the ingestion front-end for LLM/RAG pipelines (status: developing, 2026-06-26)
- [[VLM-based Document Parsing]] — single VLM reads a page end-to-end vs traditional pipeline; pipeline/VLM/hybrid tradeoffs (status: developing, 2026-06-26)
- [[Math Formula Recognition]] — detect formulas + transcribe image→LaTeX; the sub-task that makes scientific PDFs machine-readable (status: developing, 2026-06-26)
- [[Agent-Native Applications]] — apps where agent + UI are equal citizens sharing one DB/state; "click it or ask it" (Builder.io) (status: developing, 2026-06-28)
- [[Unified Action Primitive]] — one definition = agent tool + HTTP endpoint + validation + UI-refresh signal (defineAction) (status: developing, 2026-06-28)
- [[Agent-to-Agent Communication]] — A2A: agents discover/call agents across apps; same-origin → zero-config (status: developing, 2026-06-28)
- [[Self-Modifying Applications]] — apps whose agent edits their own source (components/routes/styles); improve themselves (status: developing, 2026-06-28)
- [[Agent Runtime Tools]] — sandboxed Alpine.js mini-apps the agent creates at runtime, no source changes/migrations (status: developing, 2026-06-28)

---

## Entities

- [[Andrej Karpathy]] — AI researcher, creator of the LLM Wiki pattern, former Tesla AI director (status: developing)
- [[Ar9av-obsidian-wiki]] — multi-agent compatible LLM Wiki plugin; delta tracking manifest (status: current)
- [[Nexus-claudesidian-mcp]] — native Obsidian plugin + MCP bridge; workspace memory, task management (status: current)
- [[ballred-obsidian-claude-pkm]] — goal cascade PKM; auto-commit hooks, /adopt command (status: current)
- [[rvk7895-llm-knowledge-bases]] — 3-depth query system, Marp slides, parallel deep research (status: current)
- [[kepano-obsidian-skills]] — official skills from Obsidian creator; defuddle, obsidian-bases (status: current)
- [[Claudian-YishenTu]] — native Obsidian plugin embedding Claude Code; plan mode, @mention (status: current)
- [[Claude SEO]] — Tier 4 Claude Code skill for SEO analysis; 23 skills, 17 agents, 30 scripts at v1.9.0 (status: evergreen)
- [[OpenDataLab]] — Shanghai AI Lab's open data platform; org behind MinerU + OmniDocBench + PDF-Extract-Kit (status: developing, 2026-06-26)
- [[OmniDocBench]] — OpenDataLab's end-to-end document-parsing benchmark; the yardstick MinerU et al. report against (status: developing, 2026-06-26)
- [[Builder.io]] — software co. behind Agent-Native, Qwik, Mitosis; frontend-pedigree agent framework (status: developing, 2026-06-28)

---

## Sources

- [[agent-second-brain-ecosystem-research]] — 2026-04-08 | web research across 16+ repos | 8 wiki pages created
- [[ReAct - Synergizing Reasoning and Acting]] — 2026-06-24 | Yao et al. ICLR 2023, arXiv 2210.03629 | foundational agent-loop paper
- [[Braintrust - Canonical Agent Loop]] — 2026-06-24 | while-loop-with-tools is canonical; Bitter Lesson for agents (Aug 2025)
- [[Anthropic - Multi-Agent Research System]] — 2026-06-24 | orchestrator-worker; +90.2% research eval; token use = 80% of variance
- [[Anthropic - Building Effective Agents]] — 2026-06-24 | workflows-vs-agents; augmented LLM; 5 workflow patterns (Dec 2024)
- [[The AI Engineer - Single-Agent Patterns]] — 2026-06-24 | ReAct/Plan-Execute/ReWOO/Reflexion comparison (Apr 2026)
- [[Galileo - Agent Failure Modes]] — 2026-06-24 | 7 failure patterns; error propagation is the reliability killer (Nov 2025)
- [[SkillOpt]] — 2026-06-25 | Microsoft Research text-space optimizer; trains skill.md like NN weights, +23.5pp on GPT-5.5; 3 concept pages spun off
- [[Learn-Harness-Engineering]] — 2026-06-25 | WalkingLabs course (12 lectures + 6 projects); harness = env that makes agents reliable; Anthropic $9→$200 experiment; 6 concept pages spun off
- [[Ian-Xiaohei-Illustrations]] — 2026-06-25 | 🎨 blog 配图 tool: Ian 的「小黑」中文文章配图 Codex Skill; 16:9 手绘白底怪诞风; 写 blog 时用作正文配图
- [[MinerU]] — 2026-06-26 | OpenDataLab document parsing engine; PDF/Office→Markdown/JSON; 3 backends (pipeline 86 / vlm 95 / hybrid 95 on OmniDocBench); MCP + RAG integration; 3 concept + 2 entity pages spun off
- [[Agent-Native]] — 2026-06-28 | Builder.io framework for agent-native apps (agent+UI equal citizens, shared SQL state); defineAction unified primitive; A2A; self-modifying; runtime tools; 5 concept + 1 entity pages spun off

---

## Questions

- [[How does the LLM Wiki pattern work]] — how the pattern works and why it outperforms RAG at human scale (status: developing)
- [[Research - Agentic Loop Engineering]] — autoresearch synthesis: the loop is trivial, engineering lives at tool/context design + error containment (status: developing, 2026-06-24)

---

## Comparisons

- [[Wiki vs RAG]] — when to use a wiki knowledge base versus RAG; verdict: wiki wins at <1000 pages
- [[agent-second-brain-ecosystem]] — feature matrix of 16+ Claude+Obsidian projects; where agent-second-brain wins and gaps

---

## Decisions

- [[2026-04-14-community-cta-rollout]] - community CTA footer added to 6 skill repos with per-tool frequency rules (status: active)
- [[2026-04-15-slides-and-release-session]] - Claude SEO v1.9.0 slides (15-slide HTML deck) + GitHub release v1.9.0 with PDF asset (status: complete)
- [[2026-04-15-release-report-session]] - Claude SEO v1.9.0 Release Report PDF: dark theme, 13 pages, WeasyPrint layout fixes, Challenge v2 added (status: complete)
- [[2026-04-14-claude-seo-v190-session]] - Claude SEO v1.9.0 Pro Hub Challenge integration: 5 submissions, 4 new skills, 4 review rounds, cybersecurity audit (status: complete)

---

## Domains

<!-- Add domain entries here after scaffold -->
