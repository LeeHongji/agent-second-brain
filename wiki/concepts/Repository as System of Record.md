---
address: c-000023
type: concept
title: "Repository as System of Record"
complexity: intermediate
domain: agents
aliases:
  - "Repo as Source of Truth"
  - "Agent-Readable Workspace"
  - "Progressive Disclosure (instructions)"
created: 2026-06-25
updated: 2026-06-25
tags:
  - concept
  - agents
  - harness-engineering
  - context
status: developing
related:
  - "[[Harness Engineering]]"
  - "[[Learn-Harness-Engineering]]"
  - "[[Context Engineering]]"
  - "[[Augmented LLM]]"
sources:
  - "[[Learn-Harness-Engineering]]"
---

# Repository as System of Record

**The repository itself is the harness's memory.** If the agent cannot see it — in a file it can read — it does not exist. The harness's Instructions subsystem is not a prompt; it is a set of structured files inside the repo (`AGENTS.md`, `feature_list.json`, `progress.md`, `docs/`) that every session starts from. (Course lectures L03 + L04. Source: [[Learn-Harness-Engineering]])

## Why the repo must be the system of record

Anything the agent needs to know — what to build, what's done, how to verify, what happened last session — must live on disk in a machine-readable form, because sessions are stateless and memory does not survive. Conversation context is ephemeral; repo files are the durable substrate. This is the same insight as the vault's [[Persistent Wiki Artifact]] pattern, applied to the agent's own operating environment.

## Progressive disclosure: a map, not an encyclopedia

One giant `AGENTS.md` fails (L04). The agent drowns in a wall of instructions, half of them irrelevant to the current task. The fix is **progressive disclosure**: a short top-level file that points to focused sub-documents the agent loads on demand. Give the agent a map it can navigate, not an encyclopedia it must memorize.

- Bad: 2000-line AGENTS.md covering every possible task.
- Good: AGENTS.md = routing index ("for setup read X; for testing read Y; for the current feature read feature_list.json"), with each concern in its own file.

This is [[Context Engineering]] at the file-system level: the structure of the repo *is* the structure of the agent's attention.

## Relationship to neighbors

- The strongest contrast is with [[Context Engineering]] as usually framed (tuning what the model sees in one prompt). Repo-as-record makes context **persistent and navigable across sessions**, not per-call.
- It is the substrate the [[Agent Session Lifecycle]] reads at START and writes at WRAP UP.
- [[SkillOpt]] optimizes the *content* of instruction files; repo-as-record is the *architecture* that makes those files loadable on demand. (Source: [[Learn-Harness-Engineering]])
