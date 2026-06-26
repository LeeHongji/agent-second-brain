---
type: concept
title: "Agent Session Lifecycle"
complexity: intermediate
domain: agents
aliases:
  - "Agent Session Loop"
  - "Init-Clean-Handoff Lifecycle"
created: 2026-06-25
updated: 2026-06-25
tags:
  - concept
  - agents
  - harness-engineering
  - lifecycle
status: developing
related:
  - "[[Harness Engineering]]"
  - "[[Learn-Harness-Engineering]]"
  - "[[Repository as System of Record]]"
  - "[[Agentic Loop]]"
  - "[[Agent Error Propagation]]"
sources:
  - "[[Learn-Harness-Engineering]]"
---

# Agent Session Lifecycle

A harnessed agent session follows a **structured lifecycle**, not a free-for-all. The harness governs every transition between four phases. (Course lectures L05 + L06 + L12. Source: [[Learn-Harness-Engineering]])

```
START → SELECT → EXECUTE → WRAP UP
```

**START** — read `AGENTS.md`/`CLAUDE.md`; run `init.sh` (install + verify + health check); read `progress.md` (last session); read `feature_list.json` (done/next); check `git log`. Initialization is its own phase (L06): verify the environment is healthy *before* the agent starts work, so it doesn't paper over a broken setup.

**SELECT** — pick exactly ONE unfinished feature. Work only on that feature (see [[Agent Scope Control]]).

**EXECUTE** — implement; run verification; if it fails, fix and re-run; if it passes, record evidence (see [[Verification-Gated Completion]]).

**WRAP UP** — update `progress.md` + `feature_list.json`; record what's still broken/unverified; commit only when safe to resume; leave a clean restart path.

## Why each phase exists

- **Init phase (L06)** — an agent that starts mid-broken-environment produces confident garbage. `init.sh` makes env-health a gate, not an assumption.
- **Continuity (L05)** — long-running tasks lose continuity because sessions are stateless; persisting progress to disk lets the next session pick up *exactly* where the last left off, instead of re-deriving or redoing.
- **Clean state (L12)** — the next session's success depends on this session's cleanup. A session that leaves a dirty tree (uncommitted half-work, failing tests, ambiguous state) corrupts every future session that touches the repo.

## Relationship to neighbors

- This lifecycle is the **outer loop** that contains the [[Agentic Loop]]. The agentic loop runs *inside* EXECUTE; the session lifecycle wraps it with init and cleanup.
- Without WRAP UP, you get the canonical [[Agent Error Propagation]] failure: session 1 breaks tests and says "done," session 2 starts fresh with no memory and re-does or worsens it. Clean handoff is the structural fix.
- The START phase is the filesystem mirror of the vault's hot-cache pattern: load persisted context before doing anything. (Source: [[Learn-Harness-Engineering]])
