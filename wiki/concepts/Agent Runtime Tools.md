---
address: c-000068
type: concept
title: "Agent Runtime Tools"
complexity: advanced
domain: agents
aliases: ["Agent Tools", "Runtime mini-apps", "Agent-created tools"]
created: 2026-06-28
updated: 2026-06-28
tags: [concept, agents, architecture, extensibility]
status: developing
related:
  - "[[Agent-Native Applications]]"
  - "[[Self-Modifying Applications]]"
  - "[[Augmented LLM]]"
---

# Agent Runtime Tools

**Agent runtime tools** are mini sandboxed applications an AI agent creates and edits **at runtime, as data — without touching the host app's source code, adding files, or running schema migrations.** The agent builds ephemeral or per-user capability on TOP of the app rather than INTO it. Reference: Builder.io Agent-Native's "Tools" subsystem (`AGENTS.md` → Tools).

## The Agent-Native implementation

- Tools are **Alpine.js HTML apps** stored in a `tools` SQL table, rendered in **sandboxed iframes** at `/_agent-native/tools/:id/render`.
- The agent creates/edits them via actions (`create-tool`, `update-tool` with `patches` find/replace) — **no React components, no actions, no schema changes, no deploy**.
- They inherit the host app's Tailwind theme; sharing uses the standard ownable model (private by default, shareable with org/users).

## What a runtime tool can do (full app access, zero source change)

| Helper | Purpose |
|---|---|
| `toolData.set/get/list/remove` | Per-tool key-value store, user/org scoped — persistence WITHOUT a SQL schema |
| `appAction(name, params)` | Call any host-app action |
| `dbQuery` / `dbExec` | Read/write host SQL |
| `appFetch(path)` | Call any host endpoint |
| `toolFetch(url)` | External API via a proxy that injects encrypted secrets (`${keys.NAME}`) + enforces SSRF protection |

So a tool is a 100%-self-contained mini-app with real data + API access — built live by the agent for a specific need, then discarded or kept.

## Why the pattern matters

- **Extensibility without blast radius.** The user asks "add a quick notes scratchpad" → the agent builds a runtime tool, not a feature branch. Source stays stable; the tool lives in data.
- **The lightest "make it do more."** Sits at the cheap end of [[Self-Modifying Applications]]'s spectrum: per-user, no-migration, instant. The agent should reach for a runtime tool before a source edit for user-specific needs.
- **Sandboxing + secret injection.** `toolFetch` proxies external calls with secret injection + SSRF guard — the tool gets credentials without the secret leaking into its HTML, and can't hit internal hosts.
- **MCP-adjacent.** Like MCP servers (which bring EXTERNAL tools to the agent), runtime tools let the agent BUILD tools — closing the loop on agent tooling (consume external + create local).

## Tension / open questions

- **Governance:** an agent-created tool with `dbExec` is powerful; who audits what tools get created? (Agent-Native gates via the standard access/sharing model + the agent's own skill instructions.)
- **Durability vs ephemerality:** tools live in SQL, so they persist — but they're per-user, not part of the shared product. When does a tool "graduate" into a real source feature? (The answer: when it should apply to everyone → promote to source via [[Self-Modifying Applications]].)

## Reference

[[sources/Agent-Native]] → `AGENTS.md` "Tools" section + the `tools` skill + `packages/core/src/tools/`.
