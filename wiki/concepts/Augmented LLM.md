---
type: concept
title: "Augmented LLM"
complexity: basic
domain: agents
aliases:
  - "LLM with Tools"
  - "Augmented Language Model"
created: 2026-06-24
updated: 2026-06-24
tags:
  - concept
  - agents
  - architecture
status: developing
related:
  - "[[Agentic Loop]]"
  - "[[Context Engineering]]"
  - "[[Agentic Workflow Patterns]]"
sources:
  - "[[Anthropic - Building Effective Agents]]"
---

# Augmented LLM

The **augmented LLM** is Anthropic's foundational building block for all agentic systems: a language model enhanced with **retrieval, tools, and memory**. Modern models *actively use* these augmentations — generating their own search queries, selecting tools, deciding what to retain — rather than receiving them passively.

## Why it is the base unit

Every workflow and agent in [[Agentic Workflow Patterns]] and the [[Agentic Loop]] is built on the assumption that each LLM call can retrieve, act, and remember. Strip the augmentations and you have a stateless text completer; add them and you have the smallest unit capable of grounded, multi-step work. Anthropic recommends two implementation foci: tailor the augmentations to the use case, and give them an easy, well-documented interface for the model (Model Context Protocol is one such interface). (Source: [[Anthropic - Building Effective Agents]])

## The three augmentations

- **Retrieval** — pull external knowledge (RAG, search, API lookups) so the model reasons over fresh, specific facts rather than stale parametric memory.
- **Tools** — call functions/APIs to act on the world (write a file, query a DB, send a message). Tool *outputs* become the bulk of the model's context — see [[Context Engineering]] (tools are ~80% of what an agent sees).
- **Memory** — persist state across turns and sessions (transcript window, episodic buffers like [[Reflexion]]'s self-critique, long-term stores).

## Relationship to the loop

The augmented LLM is the *body*; the [[Agentic Loop]] is the *heartbeat*. The loop calls the augmented LLM repeatedly, feeding each augmentation's output (a tool result, a retrieved doc, a memory recall) back as context. Agentic architecture = augmented LLM × loop × autonomy level.
