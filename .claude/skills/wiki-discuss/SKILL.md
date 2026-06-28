---
name: wiki-discuss
description: "Multi-agent panel that stress-tests a wiki page, source, or claimed synthesis for depth. The 'probe' verb — fixes '理解偏浅'. Dispatches 3 read-only panelists (agents/wiki-panelist.md) with distinct lenses (Skeptic refutes claims, Depth-prober chases mechanism/first-principles, Connector links to existing pages via retrieve.py), then a Moderator reconciles agreements and escalates unresolved tensions as > [!gap] / > [!contradiction] callouts. Appends a Discussion Digest to the target. Opt-in: standalone by invocation; also triggered by the '深入/deep' flag on wiki-ingest and the '--deep' flag on autoresearch. Triggers on: discuss this page, stress-test this, deep dive this, panel review, probe this, wiki-discuss, 深入讨论, 多 agent 讨论, 审一下这页, 这页理解太浅, 这页是不是太浅了."
allowed-tools: Read Edit Glob Grep Bash Agent
---

# wiki-discuss: Multi-Agent Depth Panel

A single agent reads a source and writes a note. That note is often a surface-level description — accurate but shallow. **wiki-discuss fixes that.** It dispatches several independent read-only agents, each with a different lens, to interrogate the same target. The friction between their verdicts is where depth lives.

It is the multi-agent realization of what `/think` does solo: each panelist is one focused stage of the 10-principle loop (Skeptic = ACCEPT, Depth-prober = THINK, Connector = CONNECT-lateral), run in fresh context with no allegiance to how the target was written.

---

## Scope boundary (explicit)

This skill **does**:
- Stress-test a FIXED target (one page, one source's claims, one synthesis) for depth.
- Produce a Discussion Digest + `> [!gap]` / `> [!contradiction]` callouts.
- Optionally revise confidence on claims the panel examined.

It **does not**:
- Gather new external sources — that is `autoresearch`.
- Answer a user question — that is `wiki-query`.
- Rewrite the target's conclusions. It appends a digest and inserts callouts; the original prose stays.
- Run by default on every ingest. It is opt-in (standalone invocation, or the `深入`/`--deep` flag).

---

## Transport (v1.7+)

Only the final digest write uses transport. Consult `.vault-meta/transport.json` and use the `preferred` chain (cli → mcp-obsidian → mcpvault → filesystem). Panelists are read-only and transport-agnostic. Full decision tree: [`wiki/references/transport-fallback.md`](../../wiki/references/transport-fallback.md).

---

## Concurrency (v1.7+)

Panelists do not acquire locks (read-only). Only the final digest write is lock-guarded:

```bash
bash scripts/wiki-lock.sh acquire "<target page path>" || sleep 2 && bash scripts/wiki-lock.sh acquire "<target page path>"
# … append digest via §Transport (obsidian-cli append, or Edit) …
bash scripts/wiki-lock.sh release "<target page path>"
```

If the digest goes to a sidecar (`wiki/discussions/<page>-YYYY-MM-DD.md`) instead, lock that path.

---

## Cost guard (read this before dispatching)

A panel run = **3 sub-agents (default) × their own context**. That is real tokens. Rules:

- **Standalone**: opt-in by nature (you invoked `/wiki-discuss`). Still state the cost up front: "Dispatching 3 panelists (~3× context). Proceed?"
- **Ingest integration**: only fires when the user said `深入` / `deep` / `仔细`. Default ingest stays single-agent and fast.
- **`--panel N`**: cap panelists. Default 3; max 4 (add Practitioner). Do not inflate to "be thorough" — 3 focused lenses beats 6 redundant ones.
- A page already carrying a `## Panel Discussion` from the last 14 days probably does not need re-running. Note the existing one before dispatching.

---

## The panelists

All panelists are **one parameterized read-only agent**: [`agents/wiki-panelist.md`](../../agents/wiki-panelist.md). You dispatch it N times in parallel, passing a different LENS each time. The agent reads the target + neighbors, applies its lens, and returns a structured verdict. It never edits files.

| Lens | Question it answers | think principle |
|---|---|---|
| **skeptic** | "What's wrong / unsupported / over-claimed here? Can I refute it?" | ACCEPT (anti-sycophancy) |
| **depth-prober** | "What's the mechanism? Why does it work / when does it break? Where does the page go silent?" | THINK (first principles) |
| **connector** | "Where does this slot into the vault? What does it reinforce / contradict? Hidden isomorphisms?" | CONNECT (lateral) |
| **practitioner** *(opt, `--panel 4`)* | "So what? How would I use this? Practical risk if it's wrong?" | FEEL + CREATE |

Full lens spec + output format: `agents/wiki-panelist.md`.

---

## Orchestration procedure

### 1. Resolve the target

- `[[Page Name]]` → find the page (`Glob` for the filename), read it in full.
- A source → read the source page + its key claims (the bullets under Key Claims / Summary).
- A synthesis (e.g. from autoresearch) → read the synthesis page.
- A free topic with no page → refuse gracefully: "No target page for '<topic>'. /wiki-discuss examines an existing page or source; use /autoresearch to research a new topic." Do not fabricate a target.

Extract the **2-4 key claims** the panel should pressure-test. These are the load-bearing assertions, not every sentence.

### 2. Dispatch panelists in parallel

One message, multiple `Agent` tool calls (so they run concurrently, not sequentially). Each call dispatches `agents/wiki-panelist.md` with:
- `LENS` (skeptic / depth-prober / connector [, practitioner])
- `TARGET` (page path)
- `CONTEXT` (the 2-4 key claims, quoted)

Default 3 panelists. Each returns its verdict string (CLAIMS EXAMINED, DEPTH FLOOR, CONNECTIONS/COUNTER-EVIDENCE, OPEN QUESTIONS, overall tier SHALLOW/ADEQUATE/DEEP).

### 3. Moderate (this skill's main context)

You are the Moderator. Reconcile the verdicts:

- **Agreements** → fold into the digest with the strongest supporting verdict cited.
- **Disagreements** → adjudicate. If resolvable from the vault, resolve and note how. If not → escalate:
  - Missing depth/evidence → `> [!gap]`
  - Conflicting claims (between panelists, or panelist vs page) → `> [!contradiction]`
- **Revise confidence**: a claim the skeptic tried and failed to refute → raise confidence. A claim the depth-prober found no mechanism for → lower it.
- Pick the **deepest insight** any panelist surfaced (often the depth-prober's mechanism).

### 4. Write the Discussion Digest

If the digest is small (≤ ~40 lines): append to the target page:
```markdown

---

## Panel Discussion (YYYY-MM-DD)

**Panel**: skeptic, depth-prober, connector (via [[agents/wiki-panelist|wiki-panelist]])

### Stress-tested claims
- "<quoted claim>" — **<revised confidence>**. <one-line finding, cite lens>.
- ...

### Deepest mechanism surfaced
- <the depth-prober's mechanism / first-principles, in 1-3 sentences>

### > [!gap] Open gaps
- <missing depth/evidence the panel could not resolve>

### > [!contradiction] Tensions
- <conflicting claims, with the pages/panelists on each side>

### New connections
- ↔ [[<existing page>]]: <why this link matters>
```

If large (> ~40 lines, e.g. a 4-panelist run on a big source): write a sidecar `wiki/discussions/<page-stem>-YYYY-MM-DD.md` and link it from the target with a one-line `> [!abstract] Panel Discussion [[<sidecar>]] (YYYY-MM-DD)`.

For specific claims flagged `> [!gap]` / `> [!contradiction]`, also insert an inline callout at the claim's location in the page body (surgical `Edit`), so the reader hits the flag where the claim lives — not just in the digest.

### 5. Record

- Append to `wiki/log.md` (TOP):
  ```
  ## [YYYY-MM-DD] discuss | <target>
  - Target: [[<page>]]
  - Panel: skeptic, depth-prober, connector
  - Digest: appended to [[<page>]] (or sidecar wiki/discussions/...)
  - Callouts: N x > [!gap], M x > [!contradiction]
  - Key shift: <one line on confidence/mechanism/connections>
  ```
- Refresh `wiki/hot.md` if the panel materially changed understanding (acquire lock). Otherwise skip.

---

## Standalone vs integrated invocation

**Standalone** — re-examine an existing page that feels shallow:
```
/wiki-discuss [[Harness Engineering]]
"这页理解太浅了" / "审一下这页"
```

**Integrated via `深入` flag** — wired into `wiki-ingest` and `autoresearch`:
- `wiki-ingest`: after the source is read and key claims identified (Single Source Ingest step ~2), if the user said `深入`/`deep`/`仔细` → run this skill on the source's key claims BEFORE writing concept pages. The concept pages then reflect resolved depth; the source page gets the digest. See `skills/wiki-ingest/SKILL.md` §Depth panel.
- `autoresearch`: `--deep` flag → run this skill on the synthesis in the Filing phase, before writing `wiki/questions/Research: <Topic>.md`. See `skills/autoresearch/SKILL.md` §Depth panel.

The integration is a short section in each of those skills that says "load wiki-discuss"; this skill owns the panel logic.

---

## What NOT to do

- Do NOT let panelists edit files. They are read-only by design (`agents/wiki-panelist.md` `tools: Read, Grep, Glob, Bash`). The Moderator (this skill) is the only writer.
- Do NOT rewrite the target's conclusions. Append a digest + insert callouts; the original prose is the author's.
- Do NOT run on trivial/short pages or every ingest. State the cost; default off in ingest/research.
- Do NOT fabricate a target. If there's no page, say so and point to `/autoresearch`.
- Do NOT inflate the panel past 4. More lenses ≠ more depth; it is redundancy + cost.
- Do NOT suppress `> [!gap]` / `> [!contradiction]` to make the page look finished. Unresolved tension is the deliverable.

---

## How to think (10-principle mapping)

When working on this skill, apply the 10-principle loop. See [`skills/think/SKILL.md`](../think/SKILL.md) for the canonical framework.

| # | Principle | Application here |
|---|-----------|-------------------|
| 1 | OBSERVE (ext) | Read the target fully before extracting key claims. A panel pressure-testing the wrong claims is wasted tokens. |
| 2 | OBSERVE (int) | Am I (Moderator) smoothing over disagreements to produce a tidy digest? Disagreement is the signal — escalate it, don't sand it. |
| 3 | LISTEN | The user's "这页太浅" is a precision cue — what specifically feels shallow? If they said it, target the depth-prober lens there. |
| 4 | THINK | Which 2-4 claims are load-bearing? Pressure-test those, not the page's trivia. |
| 5 | CONNECT (lat) | The connector lens IS lateral thinking. Its non-obvious retrieve.py hits are often the most valuable output. |
| 6 | CONNECT (sys) | wiki-panelist agent + retrieve.py + wiki-lock + think (each lens) compose into the panel. |
| 7 | FEEL | The digest should leave the reader knowing exactly what is solid, what is gappy, and what to do next — not drowning in transcript. |
| 8 | ACCEPT | A panel that returns "ADEQUATE, no findings" on some axis is a valid result. Don't force a gap to justify the run. |
| 9 | CREATE | The Discussion Digest + inline callouts. The callout at the claim's location is what changes how the page reads. |
| 10 | GROW | Every `> [!gap]` is a seed for the next ingest/autoresearch; every `> [!contradiction]` is a seed for resolution. The panel feeds the garden. |
