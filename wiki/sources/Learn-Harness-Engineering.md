---
address: c-000054
type: source
created: 2026-06-25
updated: 2026-06-25
title: "Learn Harness Engineering (WalkingLabs)"
source_type: course
author: "WalkingLabs"
date_published: 2026
venue: "GitHub walkinglabs/learn-harness-engineering; 12 lectures + 6 projects; MIT"
url: "https://github.com/walkinglabs/learn-harness-engineering"
course_site: "https://walkinglabs.github.io/learn-harness-engineering/"
confidence: high
key_claims:
  - "The model is smart; the harness makes it reliable (not a model problem, a harness problem)"
  - "Anthropic experiment: same Opus 4.5, no harness = $9/20min/failed; full harness = $200/6h/playable"
  - "A harness has 5 subsystems: Instructions, State, Verification, Scope, Session Lifecycle"
  - "The MODEL decides what code to write; the HARNESS governs when/where/how; it doesn't make the model smarter, it makes output reliable"
  - "Only a passing full-pipeline test run counts as real verification (confidence ≠ correctness)"
  - "Every session must leave a clean state; the next session's success depends on this session's cleanup"
tags:
  - source
  - agents
  - harness-engineering
  - course
status: canonical
related:
  - "[[Harness Engineering]]"
  - "[[Repository as System of Record]]"
  - "[[Agent Session Lifecycle]]"
  - "[[Agent Scope Control]]"
  - "[[Verification-Gated Completion]]"
  - "[[Agent Observability]]"
---

# Learn Harness Engineering (WalkingLabs)

A free, project-based course on **engineering AI coding agents** — building the "harness," the surrounding infrastructure that makes an LLM reliable inside a real repository. 12 lectures + 6 hands-on projects (capstone: an Electron personal-KB desktop app, where each project's solution becomes the next project's starter). Synthesizes practice from OpenAI (Codex), Anthropic, LangChain, Cursor, and Thoughtworks.

## The thesis and its evidence

**The model is smart; the harness makes it reliable.** Course-cited evidence: Anthropic ran a controlled experiment with the same model (Opus 4.5) and same prompt ("build a 2D retro game editor") — without a harness it spent $9 in 20 minutes and produced broken output; with a full harness (planner + generator + evaluator) it spent $200 in 6 hours and built a playable game. OpenAI reports the same qualitative shift with Codex in a well-harnessed repo. See [[Harness Engineering]].

## What it teaches

The harness as 5 subsystems — [[Repository as System of Record|Instructions]], State, [[Verification-Gated Completion|Verification]], [[Agent Scope Control|Scope]], [[Agent Session Lifecycle|Lifecycle]] — plus the [[Agent Session Lifecycle|structured session lifecycle]] (START → SELECT → EXECUTE → WRAP UP) and [[Agent Observability|runtime observability]]. The minimal harness is four repo files: `AGENTS.md`, `init.sh`, `feature_list.json`, `claude-progress.md`.

The course ships a `harness-creator` skill (the same skill available in this Claude Code session) that scaffolds a production harness in minutes.

## Why it matters here

Harness engineering is the **umbrella discipline** that this vault's agent concepts live under: it subsumes [[Context Engineering]] (the Instructions subsystem), governs every transition of the [[Agentic Loop]], and its Verification + [[Agent Observability|Observability]] subsystems are the structural fix for [[Agent Error Propagation]]. It also reframes [[SkillOpt]]: skill optimization trains one piece of the Instructions subsystem; harness engineering is the whole system around the model. (Source: [[Learn-Harness-Engineering]])
