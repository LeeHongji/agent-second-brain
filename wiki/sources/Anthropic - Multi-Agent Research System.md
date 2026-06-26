---
type: source
created: 2026-06-24
updated: 2026-06-25
title: "How We Built Our Multi-Agent Research System"
source_type: blog
author: "Jeremy Hadfield, Barry Zhang, Kenneth Lien, Florian Scholz, Jeremy Fox, Daniel Ford (Anthropic)"
date_published: 2025-10
url: "https://www.anthropic.com/engineering/multi-agent-research-system"
confidence: high
key_claims:
  - "Multi-agent = multiple LLMs autonomously using tools in a loop, coordinated by an orchestrator-worker pattern"
  - "Opus-4 lead + Sonnet-4 subagents beat single Opus-4 by 90.2% on internal research eval"
  - "Token usage alone explains 80% of BrowseComp variance; tool-call count and model choice explain the rest (95% total)"
  - "Agents use ~4x chat tokens; multi-agent ~15x chat tokens"
  - "Agents are stateful and errors compound; restart-from-scratch is unacceptable — build resume-from-checkpoint"
  - "Use rainbow deployments so running agents aren't disrupted by code updates"
tags:
  - source
  - agents
  - multi-agent
  - reliability
status: canonical
related:
  - "[[Agentic Loop]]"
  - "[[Agent Error Propagation]]"
  - "[[Context Engineering]]"
  - "[[Anthropic - Building Effective Agents]]"
---

# How We Built Our Multi-Agent Research System

Anthropic's post-mortem on Claude's Research feature: a lead agent plans and spawns parallel subagents that search, each in its own context window, condensing the best tokens back to the lead. A final CitationAgent attributes claims.

**Why multi-agent pays off:** research is open-ended and path-dependent — you cannot hardcode the exploration path. The essence of search is *compression*; subagents compress in parallel. Token usage explains 80% of performance variance on BrowseComp, validating the "distribute work across separate context windows" architecture.

**Eight prompting/tooling principles** (the operational core of the article):
1. Think like your agents — simulate prompts in Console and watch step-by-step.
2. Teach the orchestrator to delegate with objective + output format + tools + boundaries (vague subtasks cause duplicate work).
3. Scale effort to query complexity (1 agent/3–10 calls for facts; 10+ subagents for complex research).
4. Tool selection is critical — bad tool descriptions send agents down wrong paths; a tool-testing agent cut task time 40%.
5. Let agents improve themselves (Claude 4 models are good prompt engineers).
6. Start wide, then narrow — short broad queries first.
7. Guide the thinking process — extended/interleaved thinking as a scratchpad.
8. Parallel tool calling cut research time up to 90%.

**Reliability (the hard part):** agents are stateful and errors compound — a single failed step can reroute the whole trajectory. They built resume-from-checkpoint (not restart), full production tracing (decision patterns, not conversation contents), and **rainbow deployments** to roll updates without breaking running agents. Evaluation is outcome-based + LLM-as-judge + human testing (humans caught agents preferring SEO content farms over authoritative PDFs). (Source: [[Anthropic - Multi-Agent Research System]])
