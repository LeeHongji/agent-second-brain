---
type: overview
title: "Wiki Overview"
created: 2026-04-07
updated: 2026-06-28
tags:
  - meta
  - overview
status: evergreen
related:
  - "[[index]]"
  - "[[hot]]"
  - "[[log]]"
  - "[[dashboard]]"
  - "[[LLM Wiki Pattern]]"
  - "[[knowledge-gardening]]"
---

# Wiki Overview

Navigation: [[index]] | [[hot]] | [[log]] | [[dashboard]] | [[knowledge-gardening|🌿 garden]]

---

## Purpose

This is the **agent-second-brain** vault — a persistent, compounding knowledge base built on the [[LLM Wiki Pattern]] (Claude + Obsidian). Drop any source, ask any question; the wiki grows richer with every session. Unlike RAG, the synthesis, cross-references, and contradiction-flagging are already done — knowledge compounds like interest (see [[Compounding Knowledge]]; verdict in [[Wiki vs RAG]]: wiki wins at <1000 pages).

## State (2026-06-28)

- **64 non-meta pages** across **12 ingested sources**, organized into **8 topic clusters (MOCs)**.
- Last organized by `/wiki-garden organize` on 2026-06-28 (first garden).

## Cluster map

| Cluster | What it covers |
|---|---|
| [[Agent Loops]] | the canonical while-loop + reasoning patterns around it |
| [[Agent Reliability]] | the harness/environment that makes a frozen LLM reliable (★ keystone) |
| [[Text-Space Training]] | training a frozen LLM by editing skill/prompt text |
| [[Agent-Native Architecture]] | apps where agent + UI are equal citizens (Builder.io) |
| [[Document AI]] | documents → structured Markdown/JSON (MinerU / OpenDataLab) |
| [[LLM Wiki Design]] | this vault's own knowledge architecture |
| [[SEO & Search Engineering]] | engineering SEO, not guessing it (Claude SEO origin) |
| [[Claude + Obsidian Ecosystem]] | neighbor/competitor research + tooling |

The load-bearing idea: **reliability is an environment property** ([[Agent Reliability]]). The model is smart; the harness makes it reliable. Everything agent-related in the vault radiates from that reframe.

## How to use this vault

- **Plant**: `ingest [source]` / `/autoresearch [topic]` / `/save` — daily.
- **Harvest**: ask any question; `/wiki-query` reads the index then drills in.
- **Tend** (weekly): `/wiki-garden review` (retrospective) + `organize` (regroup index) + `prune` (dedup).
- **Probe** (when shallow): `/wiki-discuss [[page]]` — multi-agent depth panel.

Full mental model: [[knowledge-gardening]]. Setup/scaffold: `/wiki`.
