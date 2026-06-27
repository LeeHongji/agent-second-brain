---
address: c-000067
type: concept
title: "Self-Modifying Applications"
complexity: advanced
domain: agents
aliases: ["Self-modifying code", "Self-improving apps", "Agent-modified apps"]
created: 2026-06-28
updated: 2026-06-28
tags: [concept, agents, architecture, codegen]
status: developing
related:
  - "[[Agent-Native Applications]]"
  - "[[Agent Runtime Tools]]"
  - "[[Repository as System of Record]]"
  - "[[Harness Engineering]]"
---

# Self-Modifying Applications

A **self-modifying application** is one where the AI agent can edit the app's own source code — components, routes, styles, actions — so the application improves itself over time (add features, fix bugs, refine UI) rather than being a fixed artifact the agent merely operates within. Distinct from an agent that *uses* an app; this is an agent that *authors* the app.

Builder.io's [[Agent-Native Applications|Agent-Native]] bakes this in as Six-Rule #5: "the agent can modify code — components, routes, styles, actions. Design expecting this." There's a dedicated `self-modifying-code` skill; diffs use `diff-match-patch`.

## Two flavors (don't conflate)

1. **Source-level self-modification** — the agent edits the repo (`.tsx`/`.ts`/styles), changes ship as real code. Persistent, version-controlled, reviewed. This is the Agent-Native `self-modifying-code` mode.
2. **Runtime extension without source changes** — the agent creates capability that lives in DATA, not code: [[Agent Runtime Tools]] (Alpine.js mini-apps in a `tools` SQL table), `toolData` KV, skills. No files, no migrations, no deploy.

Both are "the app extends itself," but the blast radius differs: source edits change what every user gets; runtime tools are per-user/ephemeral. Good designs let the agent reach for the **lightest** mechanism that fits (a runtime tool before a source change; a skill/instruction before a new action).

## Why it's powerful — and dangerous

- **Power:** the app is never "done"; the agent closes the gap between "I wish it did X" and "it now does X" without a human developer in the loop. Compounding customization.
- **Danger:** an agent that edits its own app + shares a production DB can destroy data. Agent-Native's scars prove it — a self-modifying agent (or its migrations) wiped live user data (2026-04-21, PR #252). Hence hard guards: schema edits strictly additive, no destructive SQL ever, CI guards (`guard-no-drizzle-push`).

## What makes it safe-ish

- [[Repository as System of Record]] — the app + `AGENTS.md` + skills ARE the agent's instruction surface; self-modification updates that surface, so changes are inspectable and reviewable.
- [[Harness Engineering]] — the harness (guards, scopes, verification) constrains WHAT the agent may change and verifies it.
- Prefer runtime/data extensions (flavor 2) for user-specific needs; reserve source edits (flavor 1) for changes that should apply to everyone and survive review.

## Connection

The mirror image of [[Agent Runtime Tools]] (which extends without source). Together they span the agent's "make the app do more" spectrum: from ephemeral per-user tools → persistent per-user config → shared source changes.

## Reference

[[sources/Agent-Native]] — Six Rules #5, `self-modifying-code` skill, and the production-data-destruction scar (2026-04-21).
