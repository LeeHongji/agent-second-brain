---
name: wiki-garden
description: "Periodic knowledge-base gardening for the Compound Vault. The 'tend' verb. Four operations: status (cheap read-only dashboard), organize (build/refresh the MOC layer + regroup the flat index.md by topic cluster + refresh stale overview/_index), review (time-windowed retrospective: what was learned / open contradictions / shallow clusters / what to dig next), prune (act on lint+tiling findings — propose merges, fix orphans, never auto-delete). Dry-run by default; --commit writes. Nudges after 14 days idle via the /wiki router. Triggers on: garden the wiki, tidy the wiki, reorganize the wiki, review the wiki, wiki review, retro, retrospective, prune the wiki, wiki-garden, tend the wiki, knowledge gardening, 整理 wiki, 复盘, 清理重复."
allowed-tools: Read Write Edit Glob Grep Bash
---

# wiki-garden: Periodic Structure + Retrospective

The vault is a well-cross-linked **graph** that has been filed as a **flat list**. `index.md` is 70+ bullets with no grouping; `overview.md` and the `_index.md` sub-indexes drift stale; nobody owns the "which pages belong together, and what did we recently learn" question. **wiki-garden owns it.**

It is the *only* skill that reorganizes structure. `wiki-lint` diagnoses (read-only); `wiki-garden` treats (writes). `wiki-fold` rolls up the *log*; `wiki-garden` rolls up *pages into clusters* and writes the retrospective. They compose: a review calls `wiki-fold` for log compression and adds the synthetic layer on top.

---

## Scope boundary (explicit)

This skill **does**:
- Build / refresh a MOC (Map of Content) layer above the flat folders.
- Regroup `index.md` by cluster; refresh `overview.md` + the `_index.md` files.
- Produce time-windowed retrospective notes.
- Propose — and on approval apply — merges / orphan-fixes / dead-link fixes.

It **does not**:
- Delete pages. Ever. Every prune action is human-approved and additive (merge = consolidate + redirect stub, not delete).
- Replace `wiki-lint`. It *consumes* the latest lint report rather than re-diagnosing.
- Replace `wiki-fold`. The review *calls* fold for log compression; it does not reimplement extractive summarization.
- Auto-run on a schedule. It is manual + nudge (the `/wiki` router nudges after 14 days idle). No cron by default.

---

## Lightweight stance (by design)

This skill is **agent-maintained, not model-dependent.** The engine is Claude reading pages and the link graph — NOT external embedding models. Specifically:

- **Cluster detection** runs on the **`related:` + wikilink co-occurrence graph** + `domain:`/`tags` + agent editorial judgment. This is the primary signal and needs zero extra infrastructure. It separates the implicit clusters cleanly (verified: this vault's 64 pages → 8 clusters on graph signal alone).
- **`tiling-check.py` (ollama embeddings) is OPTIONAL corroboration**, never a gate. If ollama is absent/unreachable (common on minimal hosts), the skill proceeds on the graph signal and notes "tiling unavailable this run." Never block organize/review on it.
- **Near-duplicate detection (prune)** generates candidates **structurally** (shared title token + ≥2 common `related:` + same `domain:`), then the **agent judges** true duplicates by reading both pages. `tiling-check.py` ≥0.90 is an optional accelerator, not the detector.
- **Shallow-cluster detection (review)** uses `boundary-score.py` (pure graph: out-degree − in-degree) + agent judgment. No model.

Rationale: the link graph IS the author-declared semantic structure — stronger and cheaper than recomputing embeddings. Reserve embedding similarity for when a vault genuinely outgrows graph navigation. Do NOT pull in ollama or other heavy models just to garden.

---

## Transport (v1.7+)

Before mutating any vault file, consult `.vault-meta/transport.json` (auto-created by `bash scripts/detect-transport.sh`). Use the `preferred` transport per the fallback chain (cli → mcp-obsidian → mcpvault → filesystem). Full decision tree: [`wiki/references/transport-fallback.md`](../../wiki/references/transport-fallback.md).

Dry-run mode does NOT use transport — it emits via Bash stdout only (see Modes below).

---

## Concurrency (v1.7+)

Every page write in commit mode MUST be preceded by `wiki-lock acquire`:

```bash
bash scripts/wiki-lock.sh acquire wiki/mocs/<Cluster>.md || {
  echo "skipped: <path> locked by another writer"; continue
}
# … write via §Transport-selected method …
bash scripts/wiki-lock.sh release wiki/mocs/<Cluster>.md
```

For multi-file commits (MOC + index.md + _index + overview), acquire locks in **sorted-path order** to avoid deadlock (same convention as `save`). The PostToolUse auto-commit hook defers `git add` while locks are held, so a multi-file organize produces clean commits rather than torn ones. See `skills/wiki-ingest/SKILL.md` §Concurrency.

---

## Modes

| Mode | Writes? | Invocation |
|---|---|---|
| **dry-run (default)** | **No Write tool calls.** Emit proposals via Bash `cat`/heredoc to stdout only. | `garden organize`, `garden review` (review's note is still proposed, not written) |
| **commit** | Uses Write/Edit. Each Write fires the PostToolUse hook (auto-commits). Accept this. | append `--commit` (or say "commit it") only after reviewing the dry-run |

**Why stdout-only in dry-run**: the PostToolUse hook fires on any `Write|Edit` and stages `wiki/ .raw/`. Writing to `/tmp` still triggers the hook and could commit unrelated pending wiki changes under a generic message. Dry-run leaves zero residue. (Same discipline as `wiki-fold`.)

---

## Operations

### `garden` / `garden status` (default, no sub-op) — read-only dashboard

Cheap. The渐进式披露 entry point.

1. Read `.vault-meta/garden-state.json` (absent → "never gardened").
2. Report:
   - Days since last `review` / `organize` / `prune`.
   - Count of pages created/updated since last organize (candidates for clustering) — from `wiki/log.md` top entries.
   - Open contradictions carried from the latest `wiki/meta/lint-report-*.md` (grep `> [!contradiction]`).
   - The most underdeveloped cluster (from `boundary-score.py --json --top 1` if available; else "unknown").
3. Recommend the next operation. Do nothing else.

---

### `garden organize` — build/refresh the MOC layer + regroup index (the core readability fix)

1. **Cluster detection** (link-graph first — see §Lightweight stance). The primary signal is structural, no model required:
   - `related:` frontmatter + inline `[[wikilink]]` co-occurrence graph (a small `grep`/python pass over `wiki/`). This alone cleanly separates the implicit clusters.
   - Shared `domain:` / `tags` frontmatter (corroborates graph groupings).
   - The agent reads cluster-boundary cases and judges membership (editorial decision — cluster boundaries are judgment, not an embedding score; never auto-commit a grouping the user hasn't seen).
   Optional accelerators (only if already provisioned; never required):
   - `retrieve.py "<page>" --top 5` (BM25 path works with no model) for non-obvious neighbors.
   - `tiling-check.py` semantic similarity (`--peek` exit 0) as CORROBORATION when ollama is up — never a gate; if it flakes, proceed on the graph.
   Produce **6–10 cluster proposals**, each with: a name, a one-line thesis, and a member list (page + one-line role). Aim for the implicit clusters already in the vault (agent loops / harness eng / document parsing / agent-native / text-space training / wiki-pattern-meta / SEO ecosystem / vault ops). A page may belong to one primary cluster (listed in its MOC) and be cross-linked from others.

2. **Propose MOC pages** (dry-run shows this; `--commit` writes). For each cluster, file via the new router:
   ```bash
   python3 scripts/wiki-mode.py route moc "<Cluster Name>"   # → wiki/mocs/<Cluster Name>.md (generic)
   ```
   Each MOC page frontmatter:
   ```yaml
   ---
   address: c-NNNNNN          # via ./scripts/allocate-address.sh
   type: moc
   title: "<Cluster Name>"
   domain: <domain>
   created: YYYY-MM-DD
   updated: YYYY-MM-DD
   tags: [moc, <domain>]
   status: developing
   members:
     - "[[Member Page 1]]"
     - "[[Member Page 2]]"
   related:
     - "[[Other MOC]]"        # cross-cluster links
   ---
   ```
   Body: one synthesis paragraph ("why these belong together") → a member table (member | one-line role) → "Open tensions within this cluster" (carry any `> [!contradiction]` between members).

3. **Bidirectional link**: each member page gets a light additive marker — either a `moc:` frontmatter field or a single line near the top: `Part of: [[<Cluster MOC>]]`. Use `property:set` (CLI) or a surgical `Edit`. Never rewrite the member body.

4. **Rewrite `index.md`** from flat bullets → grouped-by-MOC. MOCs become `##` section headers; members nest as bullets under their MOC; ungrouped stragglers go under `## Ungrouped`. **Preserve every existing entry — no deletions.** Keep the meta header (Total pages / Sources ingested) updated to real counts.

5. **Refresh the `_index.md` sub-indexes** (`wiki/concepts/_index.md`, `wiki/entities/_index.md`, `wiki/sources/_index.md`) to actually list all members, grouped by cluster. These are currently minimal/stale.

6. **Regenerate `overview.md`**: current page count, the cluster map (MOC list), recent activity (from log), last-review date. Replaces the stale stub.

7. **Idempotency**: MOC filenames are deterministic (`wiki/mocs/<Cluster>.md`). Re-running organize **updates** existing MOCs + index in place; it does not create duplicates. Before writing a MOC, check if it exists; if so, merge the new member list into the existing one (preserve existing prose, update members + updated date).

8. **Dry-run** emits the proposed cluster list + a preview of the new grouped `index.md` via stdout. `--commit` writes.

---

### `garden review` — time-windowed retrospective

1. **Window**: since `garden-state.json:last_review` (first run → last 14 days, derivable from `wiki/log.md` dates).
2. **Inputs**: top `wiki/log.md` entries in window + `wiki/hot.md` + pages whose `updated:` falls in window.
3. **Reuse fold for log compression**: the window's log entries go through the `wiki-fold` extractive rollup (call the skill / its procedure; do not reimplement). Cite log entries; zero invention.
4. **Add the synthetic layer** (what fold deliberately does NOT do):
   - **What was learned** — by cluster (which MOCs grew, what's new).
   - **Open contradictions** — carry forward every `> [!contradiction]` still unresolved; note any resolved.
   - **Shallow clusters** — from `boundary-score.py` frontier (pure graph: high out-degree / low in-degree = lots of links out, little pointing back = underdeveloped) + agent judgment. Optionally corroborated by `tiling-check.py` Review band when ollama is up. These are `/wiki-discuss` candidates.
   - **Emergent connections** — cross-cluster links that appeared this window.
   - **Next** — what to ingest/research/dig next.
5. **Output**: `wiki/meta/review-YYYY-MM-DD.md` (frontmatter `type: meta`, `review_window:`, `related:` → cluster MOCs). Meta files are excluded from DragonScale addressing — no `address:` field. One per day (deterministic filename → re-run same day overwrites).
6. **Stamp state**: write `.vault-meta/garden-state.json` `{last_review: today, review_count: +1, last_review_window: "<range>"}`. (Bash-written, gitignored — see State.)
7. **Refresh `wiki/hot.md`** with the retrospective summary (ownership of hot.md shared with save/ingest; acquire lock).
8. **`--deep` (default off)**: dispatch `/wiki-discuss` on the single shallowest cluster to surface concrete depth-gaps. Opt-in — costs tokens. When off, just name the shallow cluster and let the user decide.

---

### `garden prune` — act on lint + tiling findings

1. Consume the latest `wiki/meta/lint-report-*.md`. Generate near-duplicate **candidates structurally (no model)**: pairs that share a title token AND have ≥2 common `related:` targets AND the same `domain:`. Then the **agent reads each candidate pair and judges** whether it is a true duplicate (not a neighbor, not a subtopic).
2. Surface, categorized:
   - **Merge candidates**: agent-confirmed duplicates. (`tiling-check.py` ≥0.90, when ollama is up, is an optional pre-filter/accelerator — not the detector.) Propose consolidate A→B (move A's unique content into B, replace A with a redirect stub `> [!merge-candidate] Redirected to [[B]] on YYYY-MM-DD`). Both pages get the callout.
   - **Orphans**: pages with no inbound links. Propose linking from their cluster MOC.
   - **Dead links**: `[[X]]` with no target. Propose stub creation or link removal.
   - **Stale stubs**: `status: seed` not updated in 30+ days.
3. **Every action human-approved. Never auto-delete.** Propose → user picks → apply (commit mode only). Dry-run is the proposal itself.

---

## State

`.vault-meta/garden-state.json` (gitignored — regenerable runtime state; avoids the address-counter-style desync where bash-written state files don't trigger the auto-commit hook):

```json
{
  "last_review": "2026-06-28",
  "last_organize": "2026-06-28",
  "last_prune": null,
  "review_count": 1,
  "last_review_window": "2026-06-14 to 2026-06-28",
  "cluster_map_hash": "<sha1 of current MOC member map, for change detection>"
}
```

If absent, treat all timestamps as never. The `/wiki` router reads this to emit the >14-day nudge.

---

## Procedure checklist (commit mode)

1. Run the chosen operation in dry-run; show the user; get confirmation.
2. For each file to be written: `wiki-lock acquire <path>` (sorted-path order for multi-file).
3. For each new MOC: `./scripts/allocate-address.sh` → put `address: c-NNNNNN` in frontmatter; record in `.raw/.manifest.json` `address_map` (reuse existing address if the MOC path already has one).
4. Write via §Transport.
5. `wiki-lock release <path>`.
6. Update `garden-state.json` (bash, gitignored).
7. Append to `wiki/log.md` (TOP):
   ```
   ## [YYYY-MM-DD] garden | <operation>
   - Operation: organize|review|prune
   - Files written: [[MOC 1]], [[MOC 2]], index.md (regrouped), overview.md (regenerated)
   - Key change: <one line>
   ```
8. For review: also refresh `hot.md`.

---

## What NOT to do

- Do NOT use Write/Edit during dry-run. Bash stdout only.
- Do NOT delete pages in prune. Merge = consolidate + redirect stub.
- Do NOT auto-commit a cluster grouping the user has not seen. organize is always dry-run → review → commit.
- Do NOT reimplement `wiki-fold`'s extractive summarization in review — call it.
- Do NOT reimplement `wiki-lint`'s diagnosis in prune — consume its report.
- Do NOT assign an `address:` to `wiki/meta/review-*.md` — meta files are address-exempt.
- Do NOT suppress or bypass the PostToolUse auto-commit hook.
- Do NOT switch the vault's methodology mode. MOCs route via `route moc` regardless of mode; organize works in generic mode without forcing LYT.

---

## Reversal

Committed organize/review reversal — all changes are additive:
1. `git revert` the organize commits (restores prior index.md/overview/_index; MOC pages come back as new files, trivially `rm` if unwanted).
2. Review note: `rm wiki/meta/review-YYYY-MM-DD.md` + remove its log entry.
3. Member-page `Part of:` markers: surgical `Edit` to remove, or leave (they are harmless additive links).

No data is ever destroyed by running this skill.

---

## How to think (10-principle mapping)

When working on this skill, apply the 10-principle loop. See [`skills/think/SKILL.md`](../think/SKILL.md) for the canonical framework.

| # | Principle | Application here |
|---|-----------|-------------------|
| 1 | OBSERVE (ext) | Read the full vault state (index, overview, _index, log, latest lint report) before proposing any structure. Structure proposals on a partial read are wrong by construction. |
| 2 | OBSERVE (int) | Am I imposing a cluster taxonomy from my training rather than detecting the vault's own implicit clusters? The clusters already exist in the link graph — detect, don't invent. |
| 3 | LISTEN | Did the user name a concern this session ("the agent pages are a mess")? Prioritize that cluster. The user's "mess" signal is the highest-priority input. |
| 4 | THINK | Cluster boundaries are editorial judgment, not an algorithm. Multi-signal fusion proposes; the human dry-run approves. Never auto-commit a grouping. |
| 5 | CONNECT (lat) | The whole point — surface the implicit hierarchy. A MOC's value is the "why these belong together" sentence. |
| 6 | CONNECT (sys) | related-graph (primary) + boundary-score + retrieve + wiki-fold + wiki-lock + allocate-address + route moc — compose, don't reimplement. tiling-check is optional corroboration only (§Lightweight stance). |
| 7 | FEEL | The regrouped index.md is what the user reads first. If it isn't scannable in 30 seconds, the organize failed regardless of correctness. |
| 8 | ACCEPT | Some pages are ungroupable stragglers. An honest `## Ungrouped` section beats a forced cluster. Don't paper over. |
| 9 | CREATE | MOC pages + regrouped index + retrospective note. All additive, all reversible. |
| 10 | GROW | Each review's "shallow clusters" feed the next `/wiki-discuss` cycle; each review's "next" feeds the next ingest/research. The garden is a loop, not a chore. |
