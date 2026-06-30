# agent-second-brain — Claude + Obsidian Wiki Vault

This folder is both a Claude Code plugin and an Obsidian vault.

**Plugin name:** `agent-second-brain` (v1.11 — "Compound Vault" since v1.7; methodology modes v1.8; thinking loop v1.9; garden + discuss v1.10; **wiki-teach v1.11**)
**Skills:** `/wiki`, `/wiki-ingest`, `/wiki-query`, `/wiki-lint`, `/wiki-cli` (v1.7), `/wiki-retrieve` (v1.7, opt-in), `/wiki-mode` (v1.8), `/think` (v1.9), `/wiki-garden`, `/wiki-discuss` (v1.10), `/wiki-teach` (v1.11) — **18 skills, 4 agents**
**Vault path:** This directory (open in Obsidian directly)

## What This Vault Is For

This vault demonstrates the LLM Wiki pattern — a persistent, compounding knowledge base for Claude + Obsidian. Drop any source, ask any question, and the wiki grows richer with every session.

## Architecture (how the system fits together — read this first)

This is **both a Claude Code plugin** (`skills/` + `agents/` + `scripts/` + `hooks/` + `bin/` + `commands/`) **and an Obsidian vault** (the `wiki/` knowledge base it maintains). A new agent needs five things:

### Three-layer storage
- **`.raw/`** — immutable sources (gitignored, local only). Read-only. `.raw/.manifest.json` (delta tracker + DragonScale `address_map`) is the only `.raw/` file skills maintain.
- **`wiki/`** — the knowledge base (the product; tracked in git = your "complete brain").
- **plugin code** — the machinery that maintains `wiki/`.

### Five component kinds
- **18 skills** — user-invoked verbs (see Plugin Skills table + 4-verb model below).
- **4 agents** (`agents/`) — sub-agents dispatched BY skills: `verifier` (pre-commit read-only audit), `wiki-ingest` (batch worker), `wiki-lint` (health worker), `wiki-panelist` (read-only depth critic for `/wiki-discuss`).
- **`scripts/`** — reusable primitives every skill composes with (don't reinvent):
  - transport / concurrency / addressing / routing: `detect-transport.sh`, `wiki-lock.sh`, `allocate-address.sh`, `wiki-mode.py`
  - retrieval: `retrieve.py`, `bm25-index.py`, `rerank.py`, `contextual-prefix.py`
  - DragonScale scoring: `boundary-score.py`, `tiling-check.py`
- **`bin/`** — one-time opt-in setup: `setup-vault.sh`, `setup-mode.sh`, `setup-retrieve.sh`, `setup-dragonscale.sh`, `setup-multi-agent.sh`, `launch-debug-chrome.sh`.
- **`hooks/`** — `SessionStart` (restore hot cache + clear stale locks), `PostCompact` (re-read hot cache), `PostToolUse` (auto-commit `wiki/ .raw/ .vault-meta/` on Write|Edit, **deferred while wiki-locks are held** so multi-file writes produce clean commits).

### Skill taxonomy + the 4-verb mental model

| Functional layer | Verb | Skills |
|---|---|---|
| Entry / router | — | `wiki` |
| Capture | 🌱 **plant** | `wiki-ingest` · `autoresearch` · `save` |
| Learn (course) | 🌱 **plant** | `wiki-teach` (multi-session course → sync to wiki) |
| Query | 🧺 **harvest** | `wiki-query` |
| Retrieval substrate | — | `wiki-retrieve` |
| Organize | — | `wiki-mode` |
| Maintain | ✂️ **tend** | `wiki-garden` · `wiki-lint` · `wiki-fold` |
| Depth | 🔍 **probe** | `wiki-discuss` |
| Transport | — | `wiki-cli` |
| Syntax / visual substrate | — | `obsidian-markdown` · `obsidian-bases` · `canvas` · `defuddle` |
| Meta-thinking | — | `think` (10-principle loop; every skill has a "How to think" appendix mapping to it) |

### Data flows
- 🌱 **Plant**: source → `.raw/` → `ingest`/`autoresearch`/`save` → source/entity/concept pages → update `index.md` + `log.md` + `hot.md`. Routed via `wiki-mode.py route`; writes guarded by `wiki-lock`; addresses via `allocate-address.sh`. **Learn variant**: `/wiki-teach <topic>` runs a multi-session course under `course/<slug>/` (MISSION/PATH/lessons/learning-records); `/wiki-teach sync` distills its decision-grade insights into wiki concept pages.
- 🧺 **Harvest**: question → `hot.md` → `index.md` (grouped by MOC) → optional `retrieve.py` chunks → target pages → synthesized answer with citations.
- ✂️ **Tend**: `wiki-garden` (`organize` MOC layer + regroup index / `review` retrospective / `prune` dedup) + `wiki-lint` (diagnose) + `wiki-fold` (log rollup). **`wiki-garden` is the only skill that rewrites structure**; it consumes lint+tiling output rather than re-diagnosing.
- 🔍 **Probe**: `wiki-discuss` dispatches `wiki-panelist` (skeptic / depth-prober / connector) → Moderator → Discussion Digest + `> [!gap]` / `> [!contradiction]`.

### Quick start for a new agent
1. Read `wiki/hot.md` (recent context) → `wiki/index.md` (catalog, grouped by MOC) → relevant MOC → pages.
2. Add knowledge: `ingest [source]` / `/autoresearch [topic]` / `/save`. For depth add `深入` (triggers `/wiki-discuss`).
3. Answer: just ask (or `query:`).
4. **Before every wiki write**: consult `.vault-meta/transport.json` → `wiki-lock acquire` → route via `python3 scripts/wiki-mode.py route <type>` → allocate `address:` for non-meta pages via `./scripts/allocate-address.sh`.
5. Before committing non-trivial work: dispatch the `verifier` agent.

Full mental model + when-to-use-which: [`wiki/references/knowledge-gardening.md`](wiki/references/knowledge-gardening.md).

## Vault Structure

```
.raw/           source documents — immutable, Claude reads but never modifies (gitignored)
course/         learning workspaces — one subdir per domain (wiki-teach); /wiki-teach sync distills insights into wiki/
wiki/           Claude-generated knowledge base (the product; in git)
  ├── index.md / log.md / hot.md / overview.md / getting-started.md   navigation + hot cache + log
  ├── mocs/        topic-cluster hubs (the hierarchy layer; built by /wiki-garden)
  ├── concepts/  entities/  sources/     the three core content types (+ _index.md each)
  ├── meta/        lint/tiling/review reports + dashboard
  ├── folds/       DragonScale log rollups
  ├── comparisons/  questions/  references/  canvases/
_templates/     Obsidian Templater templates
_attachments/   images and PDFs referenced by wiki pages (gitignored)
```

## How to Use

Drop a source file into `.raw/`, then tell Claude: "ingest [filename]".

Ask any question. Claude reads the index first, then drills into relevant pages.

Run `/wiki` to scaffold a new vault or check setup status.

Run "lint the wiki" every 10-15 ingests to catch orphans and gaps.

## Cross-Project Access

To reference this wiki from another Claude Code project, add to that project's CLAUDE.md:

```markdown
## Wiki Knowledge Base
Path: /path/to/this/vault

When you need context not already in this project:
1. Read wiki/hot.md first (recent context, ~500 words)
2. If not enough, read wiki/index.md
3. If you need domain specifics, read wiki/<domain>/_index.md
4. Only then read individual wiki pages

Do NOT read the wiki for general coding questions or things already in this project.
```

## Plugin Skills

| Skill | Trigger |
|-------|---------|
| `/wiki` | Setup, scaffold, route to sub-skills |
| `ingest [source]` | Single or batch source ingestion |
| `query: [question]` | Answer from wiki content |
| `lint the wiki` | Health check |
| `/save` | File the current conversation as a structured wiki note |
| `/autoresearch [topic]` | Autonomous research loop: search, fetch, synthesize, file |
| `/canvas` | Visual layer: add images, PDFs, notes to Obsidian canvas |
| `/wiki-cli` (v1.7) | Obsidian CLI transport wrapper; default mutation path on desktop |
| `/wiki-retrieve` (v1.7) | Hybrid contextual + BM25 + cosine-rerank retrieval (opt-in via `bash bin/setup-retrieve.sh`) |
| `/wiki-mode` (v1.8) | Methodology modes (LYT / PARA / Zettelkasten / Generic). Set via `bash bin/setup-mode.sh`; consumed by wiki-ingest / save / autoresearch for routing new pages |
| `/think` (v1.9) | The 10-principle thinking loop (OBSERVE-OBSERVE-LISTEN-THINK-CONNECT-CONNECT-FEEL-ACCEPT-CREATE-GROW) as an invocable workflow. Apply to architectural decisions, audits, post-mortems, ambiguous user requests. Every other skill has a "How to think" appendix mapping this framework to its specific work |
| `/wiki-garden` (v1.10) | Periodic structure + retrospective ("tend" verb). `organize` builds the MOC layer + regroups the flat index.md by topic cluster + refreshes stale overview/_index; `review` writes a time-windowed retrospective; `prune` acts on lint/tiling findings (merges, never auto-delete). Dry-run default. `/wiki` nudges after 14 days idle |
| `/wiki-discuss` (v1.10) | Multi-agent depth panel ("probe" verb — fixes shallow notes). Dispatches 3 read-only panelists (Skeptic / Depth-prober / Connector) against a page or source, then a Moderator appends a Discussion Digest + `> [!gap]` / `> [!contradiction]` callouts. Also triggered by the `深入`/`--deep` flag on wiki-ingest / autoresearch. Panelists are `agents/wiki-panelist.md` |
| `/wiki-teach` (v1.11) | Learn a domain as a structured multi-session course ("plant" learn variant). Project-scoped adoption of the global `teach` methodology (MISSION / RESOURCES / HTML lessons / learning-records / GLOSSARY / zone of proximal development). Workspace fixed to `course/<slug>/`; adds a PATH.md learning plan + progress tracking; `/wiki-teach sync` promotes decision-grade insights into the wiki (concept pages + a course source page). Does not touch the global `/teach` skill |

## Transport (v1.7+)

`scripts/detect-transport.sh` writes `.vault-meta/transport.json` on first run and refreshes weekly. Skills consult it before mutating the vault. Fallback chain: Obsidian CLI → mcp-obsidian → mcpvault → filesystem (always-available floor). Decision tree: [wiki/references/transport-fallback.md](wiki/references/transport-fallback.md).

## Concurrency (v1.7+)

`scripts/wiki-lock.sh` provides per-file advisory locks for safe multi-writer ingest. Every wiki page write should be guarded by `wiki-lock acquire`/`release`. Stale-after default is 60s; cross-process release allowed by design. The PostToolUse hook defers `git add` while locks are held. Closes the latent multi-writer corruption hole from v1.6.

## Methodology Modes (v1.8+)

Pick an organizational style for the vault via `bash bin/setup-mode.sh`. Four modes available: **generic** (v1.7 default — no opinion), **LYT** (Linking Your Thinking — MOCs + atomic notes), **PARA** (Projects/Areas/Resources/Archives), **Zettelkasten** (timestamped IDs, flat, dense linking). The mode is written to `.vault-meta/mode.json` (gitignored by default; `git add -f` to commit). `wiki-ingest`, `save`, and `autoresearch` consult `python3 scripts/wiki-mode.py route <type> "<name>"` before filing new pages — no special-casing needed in the consumer skills. Full guide: [docs/methodology-modes-guide.md](docs/methodology-modes-guide.md). Closes priority gap 5 from the May 2026 compass artifact.

## Pre-commit verifier (v1.7.1+)

After staging changes for a non-trivial workstream but BEFORE running `git commit`, dispatch the `verifier` agent (`agents/verifier.md`). It reads `git diff --cached`, applies the /best-practices six-cut + agent kernel, and returns findings in four tiers (BLOCKER / HIGH / MEDIUM / LOW) with file:line citations. The agent has read-only tools (Read, Grep, Glob, Bash) — it can inspect but never modify, so its output is purely advisory. This closes the loop the v1.7 audit revealed: code went worker → commit with no separate verifier pass, which is how BLOCKER B1 (data-egress consent gap) slipped through. See `the v1.7.0 audit` §10 for the retrospective.

## MCP (Optional)

If you configured the MCP server, Claude can read and write vault notes directly.
See `skills/wiki/references/mcp-setup.md` for setup instructions.

## Web access substrate (v1.9+)

`autoresearch` and `wiki-ingest` (URL ingestion) depend on the **`web-access`** skill (user-scope, `~/.claude/skills/web-access`, by 一泽Eze — https://github.com/eze-is/web-access). It provides auto tool selection (WebSearch / curl / Jina / **CDP browser**) and lets the research/ingest loops reach JS-rendered, login-gated Chinese platforms (公众号 / 小红书 / 微博 / 知乎) that bare `WebFetch` cannot. Setup + the CDP one-time toggle + 小号 warning: [wiki/references/web-access-setup.md](wiki/references/web-access-setup.md); per-platform selectors: [wiki/references/site-patterns.md](wiki/references/site-patterns.md). The autoresearch §Web egress hygiene write-side gate still applies to all fetched content regardless of method.

