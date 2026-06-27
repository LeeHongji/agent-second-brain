---
address: c-000062
type: source
created: 2026-06-28
updated: 2026-06-28
status: developing
title: "Agent-Native: a framework for building agent-native applications"
source_type: github_repo
author: "Builder.io"
date_published: 2026
venue: "github.com/BuilderIO/agent-native · TypeScript · ~2.7k★"
url: "https://github.com/BuilderIO/agent-native"
github: "https://github.com/BuilderIO/agent-native"
license: "MIT"
confidence: high
key_claims:
  - "Agent and UI are equal citizens — everything the UI can do the agent can do, and vice versa; both share one SQL DB + one state"
  - "Six Rules: data in SQL (Drizzle); all AI via agent chat (UI never calls LLM directly); actions are the single source of truth; polling sync (2s); agent can modify code; app state in SQL"
  - "defineAction is the unified primitive — ONE definition becomes a Claude-API tool + an HTTP endpoint + Zod validation + a UI-refresh signal"
  - "Per-user SQL-backed workspace: skills, memory, instructions, sub-agents, MCP servers — 'Claude-Code-level flexibility, SaaS-grade economics'"
  - "Agent-to-Agent (A2A): same-origin deploy → shared login + zero-config cross-app agent calls (tag @mail from calendar)"
  - "Agent runtime 'Tools': sandboxed Alpine.js mini-apps the agent creates/edits WITHOUT source changes or migrations (toolData KV, appAction, dbQuery, toolFetch proxy)"
  - "Self-improving: agent edits app source (components/routes/styles) — the app improves itself"
  - "Hard-won prod lessons: no breaking DB changes (2026-04-21 wiped live data, PR #252); no unscoped ownable queries (2026-04-28 cross-user data leak) — both now CI-guarded"
related:
  - "[[Builder.io]]"
  - "[[Agent-Native Applications]]"
  - "[[Unified Action Primitive]]"
  - "[[Agent-to-Agent Communication]]"
  - "[[Self-Modifying Applications]]"
  - "[[Agent Runtime Tools]]"
---

# Agent-Native — Builder.io's framework for agent-native apps

**Agent-Native** ([[Builder.io]]) is a TypeScript framework + cloneable SaaS templates where the **AI agent and the UI are equal citizens** — every action works both ways (click it or ask it), both read/write one SQL database, and changes sync instantly. The agent is context-aware (knows what you're viewing/selecting) and can modify the app's own code. Not a chatbot bolted onto a SaaS; the agent is a first-class runtime participant.

> [!key-insight] Why it matters
> This is the **application-layer** answer to patterns this vault studies at the agent-layer. The [[Agentic Loop]]'s tools become `defineAction`s; [[Context Engineering]] becomes `application_state`; [[Harness Engineering]] becomes `AGENTS.md` + skills + CI guards; [[Agent Observability]] becomes the traces/evals/experiments subsystem. Agent-native is what an app looks like when the agent is load-bearing, not decorative.

## The Six Rules (architecture, from `AGENTS.md`)

1. **Data in SQL** (Drizzle) — portable: SQLite/Postgres/D1/Turso/Supabase/Neon.
2. **All AI through the agent chat** — UI never calls an LLM directly; `sendToAgentChat()`.
3. **Actions are the single source of truth** — [[Unified Action Primitive\|define once]], serve agent + frontend.
4. **Polling sync** — `useDbSync()` polls `/_agent-native/poll` every 2s → React Query invalidation. Works on every serverless/edge host (no websockets).
5. **Agent can modify code** — see [[Self-Modifying Applications]].
6. **App state in SQL** (`application_state`) — both sides read/write; how the agent knows what you see.

## The unified action primitive

Verified in `packages/core/src/action.ts`: `defineAction({description, schema, run, http, readOnly})` → (a) Claude-API tool (schema→JSON Schema), (b) auto-mounted HTTP endpoint `/_agent-native/actions/:name`, (c) Zod validation with **agent-friendly errors** (echoes received args + expected signature so the agent self-corrects), (d) UI-refresh signal (non-readOnly success → poll event → React Query refetch). See [[Unified Action Primitive]].

## Agent ↔ UI

- Shared DB/state; UI mutation = action call = agent tool call → same row.
- Context-awareness via `application_state` (current view/selection); Cmd+I focuses agent on the selection.
- Optimistic UI by default — never `await` before screen update; "spinner after click" is a bug.
- Optional real-time collab (Yjs CRDT + live cursors).

## Runtime Tools, A2A, self-modify

- [[Agent Runtime Tools]] — sandboxed Alpine.js mini-apps the agent builds at runtime, no source changes.
- [[Agent-to-Agent Communication]] — tag `@mail` from calendar; same-origin deploy → zero-config A2A.
- [[Self-Modifying Applications]] — agent edits components/routes/styles; the app improves itself.

## Per-user workspace + MCP

Per-user (SQL-backed): skills, memory, instructions, sub-agents, MCP servers. MCP from local stdio (`mcp.config.json`), remote HTTP (per-user/org), or workspace hub (Dispatch). Tools prefixed `mcp__<server-id>__`. Auto-memory: agent saves learnings to `LEARNINGS.md`.

## Production scars (high-signal lessons)

- **No breaking DB changes — ever.** Hosted templates share prod DB across deploy contexts; a destructive migration **wiped live user data on 2026-04-21** (9 templates, PR #252). CI guard `scripts/guard-no-drizzle-push.mjs` + runtime throw now block it. Schema edits strictly additive.
- **No unscoped ownable queries.** 2026-04-28: a slides user saw other users' decks (a hand-written HTTP handler bypassed `accessFilter`). Every ownable-table read MUST use `accessFilter`/`resolveAccess`/`assertAccess`; `scripts/guard-no-unscoped-queries.mjs` statically enforces it.
- **Integration webhooks = queue pattern** (verify → enqueue → 200 → self-fired processor + 60s retry). Never Netlify Background / CF `waitUntil` / fire-and-forget — must work on every serverless host.

## Stack + templates

TypeScript/pnpm monorepo; Nitro (any host) + React/React Query + Tailwind v4 + shadcn/ui; Drizzle (any SQL); `@anthropic-ai/sdk` (Claude brain); Yjs (collab); diff-match-patch (self-modify diffs). Cloneable SaaS templates: Mail, Calendar, Content, Slides, Video, Analytics, Forms, Issues, Dispatch, … — full products you fork + own + the agent customizes.

## Provenance

Repo: https://github.com/BuilderIO/agent-native (studied 2026-06-28 via README + `AGENTS.md` + `packages/core/src/action.ts` + `package.json`; full clone skipped — repo ~121MB). Local study archive: `.raw/articles/agent-native-2026-06-28.md`.
