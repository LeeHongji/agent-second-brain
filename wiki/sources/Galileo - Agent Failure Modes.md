---
type: source
created: 2026-06-24
updated: 2026-06-25
title: "7 AI Agent Failure Modes and How to Prevent Them"
source_type: blog
author: "Galileo AI"
date_published: 2025-11-01
url: "https://galileo.ai/blog/agent-failure-modes-guide"
confidence: medium
key_claims:
  - "Error propagation — not the variety of failure modes — is what kills agent reliability"
  - "Failures cascade across Memory, Reflection, Planning, Action (the MAST taxonomy, 14 modes)"
  - "Seven operational failure patterns: spec gaps, hallucination cascades, memory corruption, multi-agent comms breakdowns, tool misuse, prompt injection, verification/termination failures"
  - "OWASP ranks prompt injection LLM01 (highest-priority LLM vulnerability)"
  - "Gartner: by 2030, half of agent deployment failures will stem from insufficient runtime governance"
  - "Independent multi-agent architectures amplify errors more than centralized coordination"
tags:
  - source
  - agents
  - reliability
  - security
status: current
related:
  - "[[Agent Error Propagation]]"
  - "[[Agentic Loop]]"
  - "[[Anthropic - Multi-Agent Research System]]"
---

# 7 AI Agent Failure Modes and How to Prevent Them

Galileo's operational taxonomy. The headline insight: agent failures are rarely one dramatic mistake — they start as a small specification gap or corrupted memory entry and **compound** through downstream decisions. See [[Agent Error Propagation]].

**Seven failure patterns (grouped by root cause):**

*Specification & reasoning*
- **Specification / system-design failures** — ambiguous requirements ("remove outdated entries" without defining "outdated"). Prevent: constraint checks, adversarial scenario suites, centralized hot-reloadable policies.
- **Reasoning loops & hallucination cascades** — one invented fact (a phantom SKU) triggers calls to N downstream APIs. Prevent: consensus checks, uncertainty estimation, intermediate judge audits, counterfactual CI tests.

*Memory & communication*
- **Context / memory corruption** — poisoned memory persists across sessions (Unit 42 showed injected instructions surviving restarts). Prevent: provenance tracking, cryptographic signatures, versioned memory, drift detectors.
- **Multi-agent communication breakdowns** — format drift at handoffs causes silent corruption green health checks miss. Prevent: JSON schemas, role contracts, handshake acks, cross-agent execution traces.

*Security & execution*
- **Tool misuse / function compromise** — over-permissioned tools ("cleanup" deletes the prod folder). Prevent: sandbox-first, least privilege, whitelisting, manual approval for sensitive actions.
- **Prompt injection** — OWASP LLM01; direct (override instructions) and indirect (poisoned retrieved docs). Prevent: layered defense (sanitation + signature detection + isolation + short-lived credentials + re-auth on high-impact steps).
- **Verification & termination failures** — extracting half a contract, or infinite refinement loops burning compute. Prevent: multi-stage validators, explicit completion criteria turning infinite loops into alarms.

**Cross-cutting detection:** trace each decision to its source module, isolate root-cause vs symptom, intervene at the earliest critical error. Agentic metrics: Action Completion, Tool Selection Quality, Reasoning Coherence. (Source: [[Galileo - Agent Failure Modes]])
