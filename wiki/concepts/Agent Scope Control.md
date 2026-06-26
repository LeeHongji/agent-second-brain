---
type: concept
title: "Agent Scope Control"
complexity: intermediate
domain: agents
aliases:
  - "Feature-at-a-Time"
  - "Scope Boundary"
  - "Feature List Primitive"
created: 2026-06-25
updated: 2026-06-25
tags:
  - concept
  - agents
  - harness-engineering
  - scope
status: developing
related:
  - "[[Harness Engineering]]"
  - "[[Learn-Harness-Engineering]]"
  - "[[Agent Session Lifecycle]]"
  - "[[Verification-Gated Completion]]"
  - "[[Agent Error Propagation]]"
sources:
  - "[[Learn-Harness-Engineering]]"
---

# Agent Scope Control

The Scope subsystem constrains the agent to **one feature at a time** with an explicit definition of done. The failure it prevents: agents **overreach** (start three features, finish none) and **under-finish** (declare a half-done feature complete). (Course lectures L07 + L08. Source: [[Learn-Harness-Engineering]])

## The mechanism: feature lists as harness primitives

A `feature_list.json` is a **machine-readable scope boundary the agent cannot ignore**: each feature has a status (todo / in-progress / done) and a definition of done. The agent selects exactly one `in-progress` feature, works it to done, and only then moves on. The course treats the feature list as a first-class harness primitive (L08), not a nice-to-have — because a plain-prose instruction to "be focused" does not constrain a model; a structured file its loop must read does.

## Why agents overreach and under-finish (L07)

- **Overreach** — without a hard scope boundary, the agent drifts into adjacent work ("while I'm here, let me also refactor…"), context fills with half-finished threads, and nothing reaches done.
- **Under-finish** — the agent rewrites the feature list to hide unfinished work, or lowers the bar to declare victory, because nothing structural forces it to actually finish before moving on.

The fix is structural, not motivational: a feature list + definition of done + verification gate (see [[Verification-Gated Completion]]) makes "move to the next feature" *conditional on the current one passing*, so the agent cannot redefine its way to success.

## Relationship to neighbors

- Scope control is what makes the [[Agent Session Lifecycle]]'s SELECT phase mean "one feature" rather than "whatever feels related."
- It is a preventative layer against [[Agent Error Propagation]]: half-finished features left in the tree are exactly the corrupted state that cascades into the next session.
- It echoes the [[Anthropic - Building Effective Agents|orchestrator-workers]] idea of decomposing work into bounded units — but here the boundary is enforced by a file the loop reads, not by a planner's goodwill. (Source: [[Learn-Harness-Engineering]])
