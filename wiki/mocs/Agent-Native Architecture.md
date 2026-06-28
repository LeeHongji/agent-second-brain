---
address: c-000072
type: moc
title: "Agent-Native Architecture"
domain: agents
created: 2026-06-28
updated: 2026-06-28
tags: [moc, agents, architecture]
status: developing
members:
  - "[[Agent-Native Applications]]"
  - "[[Unified Action Primitive]]"
  - "[[Agent-to-Agent Communication]]"
  - "[[Self-Modifying Applications]]"
  - "[[Agent Runtime Tools]]"
related:
  - "[[Agent Loops]]"
  - "[[Agent Reliability]]"
---

# Agent-Native Architecture

Apps where the **agent and the UI are equal citizens** sharing one SQL DB / state — "click it or ask it" both work. The defining move is one unified primitive (`defineAction` = agent tool + HTTP endpoint + validation + UI-refresh signal), which lets agents call each other across apps (A2A), edit the app's own source (self-modifying), or extend capability at runtime without migrations (runtime tools). This is the **application-layer** realization of this vault's agent-layer patterns.

## Members

| Page | Role |
|---|---|
| [[Agent-Native Applications]] | the umbrella: agent+UI equal citizens sharing one DB/state |
| [[Unified Action Primitive]] | `defineAction` — one def = agent tool + HTTP endpoint + validation + UI-refresh |
| [[Agent-to-Agent Communication]] | A2A — agents discover/call agents across apps; same-origin = zero-config |
| [[Self-Modifying Applications]] | the agent edits the app's own source (components/routes/styles) |
| [[Agent Runtime Tools]] | runtime Alpine.js mini-apps; capability as data, no source changes/migrations |

## Foundational source / entity
- [[Agent-Native]] — Builder.io framework; Six Rules; the application-layer reference.
- [[Builder.io]] — the software co. behind Agent-Native, Qwik, Mitosis.

## Open tensions within this cluster
- [[Self-Modifying Applications]] spans source edits (heavy blast radius) → [[Agent Runtime Tools]] (per-user, no migration); the cluster encodes the spectrum, not one pattern.

## Cross-cluster
Its unified primitive (`defineAction`) is the concrete shape of the [[Agent Loops]] tool. Its self-modification safety relies on [[Agent Reliability]]'s guards — Agent-Native's own production scars (data wiped 2026-04-21) are exactly what harness engineering prevents.
