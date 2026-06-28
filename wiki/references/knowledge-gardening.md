---
type: reference
title: "Knowledge Gardening — the 4-verb mental model"
created: 2026-06-28
updated: 2026-06-28
tags: [reference, meta, usability]
status: developing
related:
  - "[[index]]"
  - "[[Harness Engineering]]"
---

# Knowledge Gardening — the 4-verb mental model

The vault ships ~17 skills. You do **not** memorize 17 commands — skills are intent-triggered (you say what you want; the router matches). To make the skill set legible, hold one metaphor: **the wiki is a garden**, and everything you do is one of four verbs.

| Verb | What it means | Skills | When |
|---|---|---|---|
| 🌱 **plant** | put new knowledge in | `wiki-ingest`, `autoresearch`, `save` | daily, constantly |
| 🧺 **harvest** | get knowledge out | `wiki-query`, `canvas` | when you need it |
| ✂️ **tend** | keep the structure healthy | **`wiki-garden`**, `wiki-lint`, `wiki-fold` | weekly |
| 🔍 **probe** | go deeper on something shallow | **`wiki-discuss`**, the `深入` flag | when a page feels thin |

The two **bold** verbs are new in v1.10. The rest are substrate — Claude reaches for them automatically (you don't cue `wiki-cli` / `wiki-retrieve` / `wiki-mode` / `obsidian-markdown`; they fire when needed, like `git config` fires under `git commit`).

## Why this lowers cognitive load

- **Remember 4 verbs, not 17 nouns.** "I'm planting / harvesting / tending / probing" maps directly to the right skill family.
- **The router reminds you.** `/wiki` always shows current status + nudges when tending is overdue (>14 days). You don't recall — you're reminded.
- **Tending is the load-reducer.** The reason the wiki felt messy was that no skill owned structure. `wiki-garden` does: once it builds the MOC layer and regroups `index.md`, **the structure remembers where everything is, so you don't.** Adding one `tend` skill removes the search cost on every future lookup.

## The weekly rhythm

1. **Daily**: plant (`ingest` / `autoresearch` / `save`). Probe (`深入`) on the sources that matter.
2. **Weekly**: `/wiki-garden review` — what was learned, open contradictions, shallow clusters, what's next. ~1 min.
3. **When the index feels messy** (~monthly): `/wiki-garden organize` — rebuild MOCs + regroup index. Always dry-run → review → commit.
4. **When lint complains**: `/wiki-garden prune` — merge duplicates, fix orphans (human-approved, never auto-delete).

## When to probe (`wiki-discuss`)

A page that reads like a list of definitions ("X is… Y is… Z is…") is shallow. Send the panel:

- `/wiki-discuss [[Shallow Page]]` — 3 read-only agents (Skeptic refutes, Depth-prober chases mechanism, Connector links) → a Discussion Digest + `> [!gap]` / `> [!contradiction]` callouts appended.
- `/wiki-ingest <important source> 深入` — run the panel during ingest so the note lands with depth already in it.

Don't probe trivial sources — it costs ~3 sub-agents of tokens. Reserve it for things that matter.

## See also

- [[index]] — the master catalog (regrouped by MOC after the first `organize`)
- Skill specs: `skills/wiki-garden/SKILL.md`, `skills/wiki-discuss/SKILL.md`
- The non-overlap audit that justified these two as the right gaps to fill: this page is the user-facing artifact of that decision.
