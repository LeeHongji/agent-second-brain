---
type: meta
title: "Lint Report 2026-06-25"
created: 2026-06-25
updated: 2026-06-25
tags:
  - meta
  - lint
status: developing
related:
  - "[[index]]"
  - "[[dashboard]]"
---

# Lint Report: 2026-06-25

## Summary

- **Pages scanned:** 61 (wiki/**.md, real files; symlinks skipped)
- **Transport:** filesystem
- **Issues found (initial):** 58 (12 dead links, 8 orphans, 13 frontmatter gaps, 24 empty sections, 1 DragonScale address-state review)
- **Auto-fixed this pass:** 10 ✅ — 1 dead link + 6 source-page frontmatters + 3 meta-page `created` fields
- **Remaining / needs review:** 48 (11 dead links, 8 orphans, 4 frontmatter gaps, 24 empty sections, 1 address-state review)
- **DragonScale semantic tiling:** skipped — ollama unreachable (exit 10); run `ollama pull nomic-embed-text` + start ollama to enable.

### Severity at a glance (post-fix)

| Tier | Count | Items |
|---|---|---|
| BLOCKER | 0 | — |
| HIGH | 0 | (was 6 source-page frontmatter gaps — all fixed ✅) |
| MEDIUM | 1 | DragonScale address adoption ambiguity |
| LOW | 47 | Skill-reference dead links, illustrative example links, orphans, empty sections, 4 pre-existing frontmatter gaps |

---

## Dead Links (11 remaining; 1 fixed this pass)

Filtered out as false-positives (resolved once `.canvas`/`.base`/root/docs scopes included): `[[concepts/_index]]`, `[[sources/_index]]`, `[[Wiki Map]]`, `[[methodology-modes-guide]]`, `[[agent-second-brain-presentation]]`.

**Fixed ✅:**
- The [[log]] entry referenced the question page with a stray `?`; corrected to [[How does the LLM Wiki pattern work]] (the actual filename has no `?`).

**Skill / template references (link points to a skill name, no wiki page) — LOW, needs judgment:**
- `[[wiki-fold]]`, `[[fold-template]]` ← [[fold-k3-from-2026-04-23-to-2026-04-24-n8]]
- `[[wiki-mode]]` ← [[methodology-modes]]
- **Fix:** convert to plain/code references, or create thin wiki stubs.

**Illustrative / documentation examples (likely by-design) — LOW:**
- `[[Foo]]`, `[[notes/Foo]]` ← [[DragonScale Memory]] (used to explain link-resolution semantics)
- `[[Three laws of motion]]` ← [[Persistent Wiki Artifact]] (example)
- **Fix:** none needed, or escape the brackets if you want them off the graph.

**Minor — LOW:**
- `[[wikilinks]]` ← [[cherry-picks]] (lowercase token, likely accidental bracket)
- `[[dashboard.base]]` ← [[dashboard]] (link text includes extension; target file stem is `dashboard`)
- `[[the community Cover Images Canvas]]` ← [[overview]] (canvas may be renamed/absent)
- **Fix:** verify/reword.

> Scanner note: the linter's regex does not respect code spans, so any `[[...]]` written inside backticks (e.g. in this report or in prose) is flagged. In Obsidian these render as code, not links.

## Orphan Pages (8 — informational, LOW)

No inbound wikilinks. Mostly session/report/reference pages:
- [[2026-04-10-backlink-empire-session]], [[agent-second-brain-v1.2.0-release-session]], [[full-audit-and-system-setup-session]]
- [[fold-k3-from-2026-04-23-to-2026-04-24-n8]], [[methodology-modes]], [[retrieval-benchmark-v1.7]], [[tiling-report-2026-04-24]], [[transport-fallback]]
- **Suggestion:** link the meta/reference ones from [[index]] or a `_index`; session pages are fine as log-driven orphans. (Do not delete; some are intentional.)

## Frontmatter Gaps (4 remaining; 9 fixed this pass)

Required fields: `type, status, created, updated, tags`.

**Fixed ✅ (9):** the 6 autoresearch source pages now carry `created: 2026-06-24` / `updated: 2026-06-25`; [[2026-04-15-release-report-session]], [[2026-04-15-slides-and-release-session]], [[boundary-frontier-2026-04-24]] now carry `created`.

**Remaining (4 — need judgment on tags/type/status, left as-is per "safe items only"):**
- [[methodology-modes]] missing created, updated
- [[retrieval-benchmark-v1.7]] missing created, tags
- [[tiling-report-2026-04-24]] missing type, status, created, updated, tags
- [[transport-fallback]] missing created, tags

## Empty Sections (24 — mostly pre-existing stubs, LOW)

Notable clusters: [[cherry-picks]] (Tier 1–4 headings empty), several session pages (`## What Was Done` / `## What Was Built`), [[SVG Diagram Style Guide]] (`## Color Palette`, `## Layout Primitives`), entity pages (`## Key Innovations` / `## Key Features`). `_index`'s `## Add new entities here…` is a comment-as-heading false positive. (Informational; fill or remove stubs over time.)

## Stale Index Entries (0)

[[index]] links all resolve. ✓

## Address Validation (DragonScale Mechanism 2) — needs review (MEDIUM)

- Mechanism **detected as enabled**: `scripts/allocate-address.sh` + `.vault-meta/address-counter.txt` present.
- Counter file value: `3`. (Note: `allocate-address.sh --peek` returned empty — same macOS `flock` gap as `wiki-lock.sh`; the script can't acquire its meta-lock.)
- Pages with an `address:` field vault-wide: **1 of 61**.
- **Assessment:** DragonScale is in a **half-adopted state** — counter advanced to 3 but only one page carries an address; the structured concept/entity pages from ecosystem research carry none. Under strict post-rollout enforcement, the 14 newest pages (created 2026-06-24/25, i.e. ≥ 2026-04-23) would be missing-address errors.
- **Recommendation (no auto-fix):** decide adopt-vs-disable first. If adopting, backfill addresses via `wiki-ingest` / `allocate-address.sh` consistently (and fix the `flock` gap so allocation works on macOS). If not, remove `address-counter.txt` to disable detection.

## Semantic Tiling (DragonScale Mechanism 3)

- Skipped: ollama not reachable (exit 10). Enable with `ollama pull nomic-embed-text` + running ollama, then re-lint.

---

## Remaining items that need your judgment

- **Skill-reference dead links** (`wiki-fold`, `wiki-mode`, `fold-template`) — stub vs. reword?
- **4 pre-existing frontmatter gaps** — what `tags`/`type`/`status` to assign?
- **Orphan session/report pages** — link from index, or leave?
- **DragonScale addresses** — adopt + backfill, or disable?
- **Empty sections** — fill or prune?
