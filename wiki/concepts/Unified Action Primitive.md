---
address: c-000065
type: concept
title: "Unified Action Primitive"
complexity: intermediate
domain: agents
aliases: ["defineAction", "Action as Single Source of Truth", "Unified Action"]
created: 2026-06-28
updated: 2026-06-28
tags: [concept, agents, architecture, api-design]
status: developing
related:
  - "[[Agent-Native Applications]]"
  - "[[Augmented LLM]]"
  - "[[Agentic Loop]]"
---

# Unified Action Primitive

A **unified action primitive** is a single definition that simultaneously serves as (a) a tool the AI agent can call, (b) an HTTP endpoint the frontend can call, (c) a validated interface, and (d) a UI-refresh signal. One definition → both consumers. It is the concrete mechanism behind [[Agent-Native Applications]]'s "click it or ask it" contract.

The reference implementation is Builder.io's **`defineAction`** (verified in `packages/core/src/action.ts`):

```ts
export default defineAction({
  description: "Create a form",
  schema: z.object({ title: z.string(), status: z.enum(["draft","published"]).default("draft") }),
  run: async (args) => { /* validated; both agent + HTTP reach here */ },
  http: { method: "POST" },   // auto-mounted at /_agent-native/actions/create-form
});
```

## What one definition produces

1. **A Claude-API tool.** The Zod/Standard-Schema is converted to JSON Schema and registered as the agent's tool definition. The agent discovers and calls it.
2. **An HTTP endpoint.** Auto-mounted at `/_agent-native/actions/<name>`; the frontend calls the same `run()`.
3. **Runtime validation with agent-friendly errors.** Invalid args never reach `run()`. The error **echoes what was received AND the expected signature** (`{deckId*: string, slideId?: string}` where `*`=required) so the agent sees its own mistake and self-corrects on the next turn — instead of a cryptic "Required".
4. **A UI-refresh signal.** `readOnly` is auto-inferred (`GET` → read-only). A non-readOnly success emits a poll event → the UI's React Query auto-refetches → the screen reflects the agent's change.

## Why it matters

- **No divergence.** UI and agent can't drift apart because there's only one `run()`. There's no "the agent's version of create-deck" vs "the frontend's version."
- **Tool definitions stay in sync with code.** The agent's tool schema IS the code's schema (same Zod), so the agent never calls a stale signature.
- **Errors that teach.** The validation error is designed for an LLM caller (show expected vs received), not a human — a small but real piece of [[Context Engineering]] for tool-use agents.

## Generalization

The pattern is broader than Agent-Native: any agent+UI system benefits from a single action layer where the agent's tools and the app's API are the same definitions. The alternative — separate agent-tool schemas hand-maintained alongside HTTP routes — guarantees drift. This is the application-layer analogue of the [[Augmented LLM]]'s "tools" being first-class.

## Reference

`packages/core/src/action.ts` in [[sources/Agent-Native]]. Schema→JSON-Schema conversion handles Zod v4 (vendor `toJSONSchema` first, manual fallback for object/string/number/enum/array/union).
