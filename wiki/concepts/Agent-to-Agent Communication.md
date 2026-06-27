---
address: c-000066
type: concept
title: "Agent-to-Agent Communication"
complexity: advanced
domain: agents
aliases: ["A2A", "Agent-to-Agent", "Inter-agent communication", "A2A protocol"]
created: 2026-06-28
updated: 2026-06-28
tags: [concept, agents, architecture, distributed-agents]
status: developing
related:
  - "[[Agent-Native Applications]]"
  - "[[Augmented LLM]]"
  - "[[Agentic Workflow Patterns]]"
---

# Agent-to-Agent Communication (A2A)

**Agent-to-Agent (A2A)** is communication between AI agents — one agent invokes, tags, or delegates to another, so work happens across agents (and across apps) rather than within a single agent's loop. Where a single agent is an [[Agentic Loop]] with tools, **A2A is a network of such loops** that discover and call each other.

## The shape

- **Tag to invoke.** From one app's agent chat, tag another (`@mail`, `@calendar`); the target agent receives the request and acts in its own domain.
- **Discovery.** Agents advertise their capabilities; a caller finds the right agent for a sub-task (the orchestrator-worker pattern from [[Agentic Workflow Patterns]] scaled across separate agent instances).
- **Action across the stack.** A2A lets the calendar agent ask the mail agent to "email the attendees" — crossing app/domain boundaries that a single agent couldn't reach.

## Builder.io Agent-Native's A2A (reference)

Agent-Native makes A2A **zero-config** via **same-origin deployment**: every app in a monorepo workspace deploys behind one origin with per-app paths (`/mail/*`, `/calendar/*`). Same origin means:
- **Shared login session** across apps (one auth, no per-app sign-in).
- **No JWT signing, no CORS** — agents call each other freely within the origin.
- Tag `@mail` from the calendar agent "just works." (See `a2a-protocol` skill in `AGENTS.md`.)

This is notably cheaper than the general A2A case (federated agents across origins/orgs), which needs signed inter-service auth.

## Why it matters

- **Specialization.** Each agent owns its domain (mail agent knows mail; calendar agent knows scheduling). A2A composes specialists instead of building one omniscient agent.
- **Matches the [[Augmented LLM]] model at scale.** Each agent is an augmented LLM (LLM + tools + memory); A2A is the interconnect that turns N of them into a system.
- **SaaS economics + agent power.** Per-user, per-domain agents that collaborate ≈ "Claude-Code-level flexibility" spread across a product surface.

## Open questions

- Discovery/routing at scale (beyond same-origin) — the general A2A protocol problem.
- Trust/scope between agents (can `@mail` send on my behalf? who audits?).
- Failure propagation across agents — an agent calling an agent that fails (relates to [[Agent Error Propagation]]).

## Reference

[[sources/Agent-Native]] §A2A + the `a2a-protocol` skill.
