---
address: c-000012
type: concept
title: "Context Engineering"
complexity: intermediate
domain: agents
aliases:
  - "Agent-Computer Interface"
  - "ACI"
  - "Tool Design"
created: 2026-06-24
updated: 2026-06-24
tags:
  - concept
  - agents
  - prompt-engineering
status: developing
related:
  - "[[Augmented LLM]]"
  - "[[Agentic Loop]]"
  - "[[Braintrust - Canonical Agent Loop]]"
  - "[[Anthropic - Building Effective Agents]]"
sources:
  - "[[Braintrust - Canonical Agent Loop]]"
  - "[[Anthropic - Building Effective Agents]]"
---

# Context Engineering

**Context engineering** is the deliberate design of *everything the model sees at each loop iteration* — system prompt, tool definitions, tool outputs, and the running transcript. Braintrust's measurement: in a typical agent run, **tool responses are 67.6%** of context tokens, **tool definitions 10.7%**, and the **system prompt only 3.4%** — so tools are ~80% of what the agent actually reads. "Prompt engineering" (tuning that 3.4%) is the wrong lever; **tool/output design** is.

## Engineer tool outputs like prompts

A tool that returns a giant JSON blob wastes the context budget and buries signal. The readable summary wins:

```text
Found 2 users:
1. John Smith (john@company.com) — Premium, expired — last seen 2 days ago
2. Jane Doe (jane@startup.io) — Basic, expired — last seen yesterday
Need more? Use 'get_user_details' with the email.
```

The transcript — previous actions and their results — is where most reasoning happens, and it is entirely under your control. Filter irrelevant fields, use concise language, format for readability. If you wouldn't read a wall of JSON, don't feed it to the agent. (Source: [[Braintrust - Canonical Agent Loop]])

## Agent-Computer Interface (ACI)

Anthropic's parallel point: spend as much effort on the **agent-computer interface** as on a human-computer interface. Tool definition deserves real prompt-engineering attention. Lessons from their SWE-bench agent:

- **Purpose-built tools beat generic APIs.** Don't expose a 12-parameter REST endpoint; absorb complexity into a 2-parameter tool matching the agent's mental model.
- **Poka-yoke the parameters.** A tool using *relative* filepaths broke after the agent left the root dir; forcing *absolute* filepaths fixed it flawlessly.
- **Write tool docs like a great docstring for a junior dev** — include example usage, edge cases, format requirements, boundaries from other tools.
- **Give the model room to think** before it writes itself into a corner; keep formats close to natural internet text; avoid formatting overhead (manual line-counting, heavy escaping).

Anthropic spent *more time optimizing tools than the prompt* on their SWE-bench agent. (Source: [[Anthropic - Building Effective Agents]])

## Why it compounds

Because the loop re-feeds context every iteration, a 10% context-quality improvement applies *N* times across a run. Context engineering is the highest-leverage, lowest-ceiling skill in loop engineering — the model is fixed, the loop is trivial, the context is where you actually move the needle.

---

## Connection: SkillOpt

[[SkillOpt]] is **automated context engineering**: it turns the skill/prompt (the ~3.4% system-prompt + tool-def slice, plus the tool-output stream) into a *trained* artifact via [[Text-Space Optimization]] rather than a hand-tuned one. The Braintrust finding that tools are ~80% of context becomes an optimization target, not just a design heuristic. See [[Textual Gradient]].

---

## Connection: Harness Engineering (umbrella)

[[Harness Engineering]] **subsumes** context engineering: the harness's **Instructions** subsystem is structured context engineering, persisted as repo files (`AGENTS.md`, `feature_list.json`) rather than per-call prompts, organized for progressive disclosure (see [[Repository as System of Record]]). Context engineering is one subsystem; harness engineering is the whole system around the model. Source: [[Learn-Harness-Engineering]].
