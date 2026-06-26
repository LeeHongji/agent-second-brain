---
type: meta
title: "Lint Report 2026-06-26"
created: 2026-06-26
updated: 2026-06-26
tags: [meta, lint]
status: developing
---

# Lint Report: 2026-06-26

## Summary
- Pages scanned: **82** `.md` files under `wiki/` (~54 content pages + meta/folds/references/_index)
- Issues found: **9 actionable** (3 MEDIUM, 6 LOW) + ~12 false-positives documented below
- Auto-fixed: **4** (after user approval — see "Post-Lint Resolutions" below)
- Needs review: 4 (LOW historical/naming — deferred)
- **DragonScale enabled this run**: `flock` installed (`util-linux`), 58 addresses backfilled, address validation now clean.

Severity tiers: BLOCKER / HIGH / MEDIUM / LOW. **No BLOCKER or HIGH findings.**

---

## Orphan Pages
**None.** Every non-meta page has ≥1 inbound wikilink. ✅

---

## Dead Links (21 unique targets — mostly explainable)

### ✅ False positives (not real — do NOT "fix")
These targets resolve to files my scanner didn't index (canvas / `.base` / files outside `wiki/`):
- `[[Wiki Map]]` → `wiki/Wiki Map.canvas` exists (canvas, not .md). Also flagged in index — same cause.
- `[[agent-second-brain-presentation]]` → `wiki/canvases/agent-second-brain-presentation.canvas` exists.
- `[[dashboard.base]]` → `wiki/meta/dashboard.base` exists (Obsidian Bases file).
- `[[methodology-modes-guide]]` / `[[wiki-cli]]` / `[[wiki-mode]]` → resolve to `docs/` or `skills/` (vault-wide wikilinks).

### ⚠ Self-references inside the previous lint report (expected)
`wiki/meta/lint-report-2026-06-25.md` *quotes* dead links it found, so it contains `[[...]]`, `[[Foo]]`, `[[wikilinks]]`, `[[fold-template]]`, etc. as documentation. Not real dead links.

### 🔧 MEDIUM — genuinely actionable
- **`[[How does the LLM Wiki pattern work?]]`** in `wiki/concepts/Query-Time Retrieval.md` and `wiki/concepts/Persistent Wiki Artifact.md` — trailing `?` in the link breaks resolution. The page exists as `wiki/questions/How does the LLM Wiki pattern work.md` (no `?`). **Fix:** drop the `?` (2 edits).
- **`[[the community Cover Images Canvas]]`** in `wiki/overview.md` — rebrand artifact: the original `[[AI Marketing Hub Cover Images Canvas]]` had its brand token stripped to "the community", leaving a broken target. **Fix:** remove the line (the canvas it referenced doesn't exist).

### 📜 LOW — historical / intentional (original-project marketing notes)
In `wiki/meta/2026-04-10-backlink-empire-session.md` and `wiki/meta/2026-04-14-community-cta-rollout.md` (kept as historical record per your Q1 decision): `[[Agent Second Brain]]`, `[[Claude Canvas]]`, `[[Karpathy LLM Wiki Pattern]]`, `[[Rankenstein]]`, `[[E-commerce SEO]]`. These are aspirational/competitor refs from the original project's growth notes. Leave as-is (historical) or strip — your call.
- Minor: `[[Canvas]]`, `[[Foo]]`, `[[Three laws of motion]]`, `[[wikilinks]]` in `log.md` / concept pages are illustrative/syntax examples.

---

## Frontmatter Gaps (3)
- **`wiki/sources/MinerU.md`**: missing `status`. *(My omission from today's ingest — add `status: developing`.)* — MEDIUM, safe auto-fix.
- `wiki/references/methodology-modes.md`: missing `created`, `updated`. — LOW (reference pages use a loose schema).
- `wiki/references/transport-fallback.md`: missing `created`. — LOW.

---

## Stale Index Entries
- `[[Wiki Map]]` in `wiki/index.md` → resolves to `wiki/Wiki Map.canvas` (canvas). **False positive**, no action.

---

## Naming / Uniqueness
- **`[[_index]]` basename appears 3×**: `wiki/concepts/_index.md`, `wiki/entities/_index.md`, `wiki/sources/_index.md`. Wikilinks to `[[_index]]` would be ambiguous. LOW — these are rarely linked directly; if needed, path-qualify as `[[concepts/_index]]` etc.

---

## Address Validation (DragonScale Mechanism 2)
- **RESOLVED this run.** Installed `flock` (Homebrew `util-linux`, symlinked to `/opt/homebrew/bin/flock`); `allocate-address.sh` + `wiki-lock.sh` now functional.
- Backfilled addresses for all 58 content pages that lacked one (after `--rebuild`).
- Final state: **59 pages addressed**, 0 format violations, 0 duplicates, counter peek = 60, highest observed `c-000059` → **no drift**. Address map persisted to `.raw/.manifest.json` (local).
- Future ingests will allocate addresses normally via `wiki-ingest`.

---

## Semantic Tiling (DragonScale Mechanism 3)
- **Skipped** — `ollama` not installed (known env gap). No duplicate-page detection this run. Install `ollama` + `ollama pull nomic-embed-text` to enable.

---

## Writing Style / Stale Claims
- No stale-claim contradictions detected between today's MinerU ingest and existing pages (MinerU introduced a new topic; no prior claims to conflict).
- `[[OmniDocBench]]` flags its own self-benchmarking risk via a `> [!gap]` callout — good.

---

## Auto-Fixes Applied (approved + executed)
1. ✅ `wiki/sources/MinerU.md`: added `status: developing`.
2. ✅ Dropped trailing `?` from `[[How does the LLM Wiki pattern work?]]` → `[[How does the LLM Wiki pattern work]]` in **3** concept pages: `Query-Time Retrieval`, `Persistent Wiki Artifact`, and `Source-First Synthesis` (the 3rd was caught by the post-fix fixed-string verify — the original scan missed it).
3. ✅ `wiki/overview.md`: removed the broken `[[the community Cover Images Canvas]]` rebrand-artifact line.
4. ✅ Installed `flock` + backfilled 58 DragonScale addresses (see Address Validation above).

Leave-for-you-to-decide (LOW, deferred): the historical marketing-note dead links, the `_index` duplicate naming.

---

## Dataview Dashboard
`wiki/meta/dashboard.md` updated with current queries (see below).

## Canvas Map
`wiki/meta/overview.canvas` not regenerated this run (a `wiki/Wiki Map.canvas` already exists). Can add if you want a fresh domain map.
