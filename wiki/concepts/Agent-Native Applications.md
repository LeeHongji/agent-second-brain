---
address: c-000064
type: concept
title: "Agent-Native Applications"
complexity: intermediate
domain: agents
aliases: ["Agent-Native", "Agent-native app", "Agentic application"]
created: 2026-06-28
updated: 2026-06-28
tags: [concept, agents, architecture, application-pattern]
status: developing
related:
  - "[[Agent-Native Applications]]"
  - "[[Unified Action Primitive]]"
  - "[[Agent-to-Agent Communication]]"
  - "[[Self-Modifying Applications]]"
  - "[[Agent Runtime Tools]]"
  - "[[Augmented LLM]]"
  - "[[Agentic Loop]]"
  - "[[Harness Engineering]]"
---

# Agent-Native Applications

An **agent-native application** is one where the AI agent and the UI are **equal citizens of the same system** — not a chatbot bolted onto a SaaS, but an app architected so that every action is reachable both by clicking (UI) and by asking (agent), with both sides sharing one database and one state. Coined/productized by [[Builder.io]]'s [[Agent-Native Applications|Agent-Native]] framework.

> [!key-insight] The thesis
> Don't choose between structured user flows (SaaS) and autonomous agents (raw AI). Every app is both: the UI for precision and speed, the agent for power and automation — and they never desync.

## The contract (what makes an app "agent-native")

1. **One shared state.** Agent and UI read/write the same SQL database + the same application state. A change from either shows up on the other instantly (no separate "agent memory" vs "app DB").
2. **Bidirectional actions.** Every operation is defined once ([[Unified Action Primitive]]); the frontend calls it as an HTTP endpoint, the agent calls it as a tool. "Click it or ask it" is literally the same code path.
3. **Context-awareness.** The agent knows what the user is looking at (open record, selected text, current view) because navigation/selection lives in shared state — so "do this to *that*" works without the user re-describing context.
4. **Self-modification.** The agent can edit the app's own code (see [[Self-Modifying Applications]]) — the app improves itself.

## Where it sits in the agent stack

Agent-native is the **application layer** built on primitives this vault studies lower down:
- The [[Agentic Loop]]'s tools = the app's `defineAction`s.
- [[Augmented LLM]] (LLM + retrieval + tools + memory) = the agent chat that ALL AI routes through.
- [[Context Engineering]] = `application_state` exposing the user's view to the agent.
- [[Harness Engineering]] = `AGENTS.md` + skills + CI guards that make the agent reliable.
- [[Agent Observability]] = the traces/evals/feedback subsystem.

## vs alternatives

| Approach | UI | AI | Customization | Ownership |
|---|---|---|---|---|
| SaaS | polished, rigid | bolted-on | can't | rented |
| Raw agent | none | powerful | instructions/skills | somewhat yours |
| Internal tool | mixed | shallowly connected | full, high-maintenance | yours |
| **Agent-native** | full UI, fork & go | agent-first, integrated | **agent modifies the app** | you own the code |

## Why it's hard

- The action layer must be the single source of truth (else UI and agent diverge).
- Real-time-ish sync without websockets (serverless) — Agent-Native uses 2s polling + React Query invalidation.
- Security: ownable resources need access-filtering on EVERY path (agent + HTTP) — easy to leak (Agent-Native hit this 2026-04-28).
- Schema discipline: a self-modifying agent that also shares a prod DB can destroy data if migrations aren't strictly additive.

## Reference

[[sources/Agent-Native]] (Builder.io, 2026) is the canonical implementation. The framework ships cloneable SaaS templates (Mail, Calendar, Content, Slides, …) that instantiate this pattern.
