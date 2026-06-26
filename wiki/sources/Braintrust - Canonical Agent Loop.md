---
address: c-000051
type: source
created: 2026-06-24
updated: 2026-06-25
title: "The Canonical Agent Architecture: A While Loop with Tools"
source_type: blog
author: "Ankur Goyal (Braintrust)"
date_published: 2025-08-07
url: "https://www.braintrust.dev/blog/agent-while-loop"
confidence: high
key_claims:
  - "The most successful agents (Claude Code, OpenAI Agents SDK) share one architecture: a while loop that makes tool calls"
  - "The Bitter Lesson applies to agent design — simplest general pattern wins over hand-crafted rigid frameworks"
  - "Tool responses are 67.6% of agent context tokens; tool definitions 10.7%; system prompt only 3.4% — tools are ~80% of what the agent sees"
  - "Context engineering matters more than prompt engineering"
  - "An agent is just a system prompt and a handful of well-crafted tools"
tags:
  - source
  - agents
  - architecture
status: current
related:
  - "[[Agentic Loop]]"
  - "[[Context Engineering]]"
  - "[[Anthropic - Building Effective Agents]]"
---

# The Canonical Agent Architecture: A While Loop with Tools

Braintrust argues that the production-proven agent architecture has converged to a trivial loop:

```
while (!done) {
  response = callLLM(messages);
  if (response.toolCalls) execute tools, push results;
  else push user message;
}
```

This wins for the same reason UNIX pipes and React components do: simple, composable, flexible. It extends naturally to sub-agents (a tool call that invokes an independent loop) and multi-agents (independent loops passing messages via tool calls).

**Why this matters for loop engineering:** the engineering effort is not in the loop primitive — it is at the *edges*: tool design, context engineering, and evaluation. Three concrete levers:

1. **Purpose-built tools over generic APIs.** Don't expose a 12-parameter REST endpoint; absorb complexity into a 2-parameter tool matching the agent's mental model (the article's `notify_customer` vs `send_message` example). Specific tools score higher on evals.
2. **Engineer tool outputs like prompts.** A readable summary ("Found 2 users: …") beats a raw JSON blob. The transcript is where reasoning happens and is fully in your control.
3. **Evaluation is the foundation.** An agent is an *evaluatable system*: agent + representative dataset + scorers. Evals must be durable across model/prompt/tool changes.

**Thesis:** teams that start with sophisticated graph frameworks or multi-phase planners often converge back to the simple loop in production. (Source: [[Braintrust - Canonical Agent Loop]])

---

## Connection: SkillOpt

Braintrust's "an agent is just a system prompt and a handful of well-crafted tools" is the premise [[SkillOpt]] operationalizes: it makes that system prompt a *trained* artifact ([[Text-Space Optimization]]) instead of a hand-written one. Once you accept the agent's intelligence lives in the prompt rather than the weights, optimizing the prompt with DL-grade discipline is the logical next step.
