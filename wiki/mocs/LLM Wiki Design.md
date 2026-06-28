---
address: c-000074
type: moc
title: "LLM Wiki Design"
domain: knowledge-management
created: 2026-06-28
updated: 2026-06-28
tags: [moc, knowledge-management, meta]
status: developing
members:
  - "[[LLM Wiki Pattern]]"
  - "[[Compounding Knowledge]]"
  - "[[Hot Cache]]"
  - "[[DragonScale Memory]]"
  - "[[Persistent Wiki Artifact]]"
  - "[[Source-First Synthesis]]"
  - "[[Query-Time Retrieval]]"
related:
  - "[[Claude + Obsidian Ecosystem]]"
  - "[[Document AI]]"
---

# LLM Wiki Design

This cluster is **the vault thinking about itself**: the pattern it demonstrates, why it beats RAG at human scale, the mechanisms that make it work (hot cache, persistent artifacts, source-first provenance, query-time synthesis), and the memory-layer spec (DragonScale). If the other clusters are *content*, this one is the *architecture* that holds the content.

## Members

| Page | Role |
|---|---|
| [[LLM Wiki Pattern]] | the core pattern for persistent, compounding knowledge bases |
| [[Compounding Knowledge]] | why wiki knowledge grows more valuable over time, unlike RAG |
| [[Hot Cache]] | ~500-word session context file; cheap recent-context entry |
| [[DragonScale Memory]] | memory-layer spec: fold operator, deterministic addresses, semantic tiling |
| [[Persistent Wiki Artifact]] | durable Markdown page as the LLM's memory object |
| [[Source-First Synthesis]] | provenance discipline; raw sources immutable, wiki synthesized + cited |
| [[Query-Time Retrieval]] | query path synthesizes with citations; complements Obsidian search |

## Related
- [[Wiki vs RAG]] — when to use a wiki KB vs RAG; wiki wins at <1000 pages.
- [[How does the LLM Wiki pattern work]] — the how/why synthesis.
- [[Andrej Karpathy]] — originated the LLM Wiki pattern.

## Cross-cluster
Ingestion fed by [[Document AI]]. Compared against the field in [[Claude + Obsidian Ecosystem]]. The `wiki-garden` / `wiki-discuss` skills you're using right now are themselves instances of this cluster's ideas.
