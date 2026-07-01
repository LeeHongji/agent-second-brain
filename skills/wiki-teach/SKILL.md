---
name: wiki-teach
description: "Teach the user a new skill or domain over multiple sessions, as a structured course that lives in this project's course/ directory and syncs its durable learnings into the wiki (second brain). Project-scoped adoption of the global `teach` skill's methodology (MISSION / RESOURCES / lessons / learning-records / GLOSSARY / zone of proximal development), plus: workspace fixed to course/<slug>/, a PATH.md learning plan, progress tracking, and /wiki-teach sync to promote decision-grade insights into the wiki. Triggers on: teach me, 学, learn, 开始一门课, 继续学, learn a new domain, wiki-teach, teach me about, 我想学."
argument-hint: "What would you like to learn about?"
allowed-tools: Read Write Edit Glob Grep Bash
---

# wiki-teach: Learn a domain as a structured course → sync to the second brain

The user wants to **learn something over multiple sessions**. This skill runs that learning as a **course** that lives under this project's `course/` directory, tracks progress, and — when the user is ready — **syncs the durable learnings into the wiki** (the second brain) so they compound with everything else.

**Methodology origin**: this skill adopts the pedagogy of the global `teach` skill (`~/.agents/skills/teach/`) — MISSION, RESOURCES, lessons, learning-records, GLOSSARY, zone of proximal development, fluency vs storage strength. The format files in [`references/`](./references/) are verbatim copies. What this project version **adds** (the global skill does not have): a fixed workspace location, an explicit learning path (PATH.md), progress tracking, and a sync-to-wiki bridge.

This skill is **project-scoped** (`skills/wiki-teach/`, mirrored to `.claude/skills/wiki-teach/`). It does not touch the global `/teach` skill, which remains independent for use outside this project.

---

## Project integration (what's different from the global teach skill)

### Workspace = `course/<course-slug>/` (not the current directory)

The global teach skill treats the current directory as the workspace. This version fixes the workspace to **`course/<course-slug>/`** at the project root. One course = one domain = one subdirectory.

- **Slug derivation**: lowercase the topic, spaces/non-word → hyphens, strip leading/trailing hyphens (e.g. "Rust CLI" → `rust-cli`). Path-separators and control characters stripped (no escaping `course/`).
- The course workspace holds: `MISSION.md`, `RESOURCES.md`, `NOTES.md`, `GLOSSARY.md`, `PATH.md` (new), and the `lessons/`, `learning-records/`, `reference/`, `assets/` directories (lazy-created).

### Operations

| Invocation | Action |
|---|---|
| `/wiki-teach <topic>` | Derive slug. If `course/<slug>/` does not exist → **new course**. If it exists → **continue**. |
| `/wiki-teach` (no arg) | Read `course/INDEX.md`, list all courses (status + lesson count + last touched), ask: continue which, or start new. |
| `/wiki-teach sync [<course>]` | Promote the course's decision-grade learnings into the wiki (see §Sync below). |

**New course flow**: **first, ask the teaching language** (中文 / English / …) — see §Teaching language below; record it in `NOTES.md` before generating any content. Then interview the user to establish the MISSION (use [`references/MISSION-FORMAT.md`](./references/MISSION-FORMAT.md); push back on vagueness — concrete outcomes, not "to understand X") → create `course/<slug>/` + `MISSION.md` → seed `RESOURCES.md` (curate high-trust sources; load the `web-access` / `autoresearch` skills to find them — never trust parametric knowledge) → write `PATH.md` (the learning plan) → create the first lesson in `lessons/0001-*.html` (zone of proximal development, **in the chosen language**) → register the course in `course/INDEX.md` + append a one-line open to `wiki/log.md`.

**Continue flow**: read `NOTES.md` first (for the teaching language + preferences), then `MISSION.md` + `learning-records/*` + `PATH.md` + the last lesson → compute the zone of proximal development → produce the next lesson (**in the recorded language**). As the user demonstrates decision-grade understanding, write `learning-records/000N-*.md` (per [`references/LEARNING-RECORD-FORMAT.md`](./references/LEARNING-RECORD-FORMAT.md)). Update PATH progress.

### Teaching language (ask at course open — do NOT skip)

Before generating **any** content for a new course, ask the user which language they want the course taught in (e.g. 中文 / English / 日本語). This is the single highest-leverage preference — getting it wrong produces a whole course in the wrong language.

- Ask it as the **first question** of the new-course interview (before or alongside the MISSION interview).
- Record the answer at the top of `NOTES.md` under a `## Teaching language` heading, e.g. `Teaching language: 中文 (zh)`.
- **All learner-facing artifacts** — lessons (`lessons/*.html`), reference docs (`reference/*.html`), the glossary (`GLOSSARY.md`) — are authored in that language for the whole course. Technical proper nouns and code stay in their original form (e.g. "Tauri", "FastAPI", `just dev`); the surrounding prose is in the chosen language.
- Workspace meta (`MISSION.md` / `PATH.md` / `RESOURCES.md`) may be written in the chosen language too; prefer it for consistency.
- The **continue flow reads `NOTES.md` first** and keeps the language — never re-derive it, never silently switch.
- If the user asks to change language mid-course, update `NOTES.md` + add a learning-record noting the switch; future lessons follow the new language (past lessons are not retroactively rewritten unless the user asks).

### PATH.md — the learning plan (new)

The global skill has no syllabus; its curriculum is emergent. This version adds a lightweight, **revisable** learning path written at course start from the MISSION's success criteria. It does **not** override the zone-of-proximal-development rule (the next lesson is still driven by learning-records); it makes the direction + progress visible. Format: [`references/PATH-FORMAT.md`](./references/PATH-FORMAT.md).

### Progress tracking (new)

The global skill tracks nothing explicitly. This version tracks:
- **Per-milestone status** in PATH.md (◇ not-started / ▶ learning / ✅ mastered).
- **Course-level status**: `in-progress` | `completed` (PATH.md header + `course/INDEX.md`).
- Mastery itself is still authored via learning-records (ADR-style). PATH aggregates them into visible progress.
- A course is **completed** when the user declares the MISSION's success criteria met → then offer `/wiki-teach sync`.

### Sync to the wiki (second brain) — `/wiki-teach sync`

Distills the course's **decision-grade** artifacts into `wiki/` (human-in-the-loop; do not blindly dump):

1. Read `learning-records/*.md` + `GLOSSARY.md` + `reference/*` + `MISSION.md`.
2. For each durable insight / term that is substantive enough to stand alone → create or update a **wiki concept page** via the standard ingest ceremony:
   - path: `python3 scripts/wiki-mode.py route concept "<Name>"`
   - address: `./scripts/allocate-address.sh` → `address: c-NNNNNN` in frontmatter
   - `bash scripts/wiki-lock.sh acquire <path>` → Write (use `obsidian-markdown` syntax) → release
   - cross-reference existing wiki pages; flag contradictions with `> [!contradiction]`.
3. Create a **`wiki/sources/<course-name>.md`** summary page: the mission, what was learned, links to the promoted concept pages, key RESOURCES. The course becomes a "source" in the wiki.
4. If the course spawned a topic cluster → suggest running `/wiki-garden organize` to build a MOC (compose, don't reimplement).
5. Update `wiki/index.md` + prepend a `sync` entry to `wiki/log.md` + refresh `wiki/hot.md`.
6. **Write-side hygiene**: any content pulled from external RESOURCES passes the autoresearch §Web egress hygiene gate (strip `<script>`, escape `[[`, reject injected `---`, truncate ~50KB) before writing to the vault.

HTML lessons stay in `course/<slug>/lessons/` — sync promotes the *insights*, not the pedagogical artifacts.

---

## The teaching workspace (`course/<slug>/`)

The state of the user's learning is captured in the course directory:

- **`MISSION.md`**: the _reason_ the user is interested. Grounds all teaching. Format: [`references/MISSION-FORMAT.md`](./references/MISSION-FORMAT.md).
- **`PATH.md`**: the learning plan + progress tracker (project add). Format: [`references/PATH-FORMAT.md`](./references/PATH-FORMAT.md).
- **`RESOURCES.md`**: curated high-trust sources for grounding. Format: [`references/RESOURCES-FORMAT.md`](./references/RESOURCES-FORMAT.md).
- **`GLOSSARY.md`**: canonical terminology for the workspace. Format: [`references/GLOSSARY-FORMAT.md`](./references/GLOSSARY-FORMAT.md).
- **`lessons/*.html`**: the lessons — single self-contained HTML files teaching one tightly-scoped thing tied to the mission. The primary unit of teaching.
- **`learning-records/*.md`**: ADR-style records of what was learned (the floor for what to teach next). Format: [`references/LEARNING-RECORD-FORMAT.md`](./references/LEARNING-RECORD-FORMAT.md).
- **`reference/*.html`**: compressed reference materials — cheat sheets, algorithms, syntax, pose sequences. The raw units of learning; designed for quick reference and printing.
- **`assets/*`**: reusable **components** shared across lessons (stylesheets, quiz widgets, simulators).
- **`NOTES.md`**: scratchpad for user preferences (incl. the **teaching language** — see §Teaching language) and working notes.

Lazy-create `lessons/`, `learning-records/`, `reference/`, `assets/` only when the first file in each is written.

---

## Philosophy

To learn at a deep level, the user needs three things:

- **Knowledge**, captured from high-quality, high-trust resources.
- **Skills**, acquired through highly-relevant interactive lessons devised by you, based on the knowledge.
- **Wisdom**, which comes from interacting with other learners and practitioners.

Before `RESOURCES.md` is well-populated, focus on finding high-quality resources. **Never trust your parametric knowledge.** Some topics are more knowledge-based (theoretical physics), others more skills-based (yoga).

### Fluency vs storage strength

- **Fluency strength**: in-the-moment retrieval.
- **Storage strength**: long-term retention — the real goal.

Design lessons that build long-term retention by desirable difficulty: retrieval practice (recall from memory), spacing (distribute practice), interleaving (mix related topics — skills practice only).

---

## Lessons

A lesson is the main thing you produce. Each is one self-contained HTML file in `lessons/`, titled `0001-<dash-case-name>.html` (number increments each time).

- **Beautiful** — clean, readable typography and layout (think Tufte); the user returns to review these.
- **Short** — completable quickly; working memory is small. But each lesson gives **one tangible win** the user can build on.
- Tied to the mission, in the user's **zone of proximal development**.
- Link via HTML anchors to other lessons and reference documents.
- Recommend **one primary source** to read/watch (the highest-trust resource on the topic).
- End with a reminder to ask the agent follow-up questions.
- Architecture / framework / flow **diagrams use Excalidraw SVG** (see §Diagrams below) — avoid ASCII art for non-trivial diagrams.

If possible, open the lesson file for the user via a CLI command.

## Diagrams (Excalidraw)

When a lesson needs an **architecture / framework / flow diagram**, author it as a hand-drawn **Excalidraw** diagram and embed the rendered SVG — **not ASCII art**. (ASCII is fine only for tiny inline text sketches.) Excalidraw gives rigor + beauty, is editable in Obsidian, and the hand-drawn (roughjs + Virgil) look matches the "beautiful, returns-to-review" lesson ethos.

### Pipeline
1. **Master**: author `course/<slug>/reference/<name>.excalidraw` (Excalidraw JSON — box / arrow / text primitives; schema below).
2. **Render** (once, then after every edit): `bash scripts/excalidraw-render.sh course/<slug>/reference/<name>.excalidraw course/<slug>/assets/<name>.svg` — pure roughjs, no browser. Needs `bash bin/setup-excalidraw.sh` run once on the machine.
3. **Embed** in the lesson: `<img class="diagram-svg" src="../assets/<name>.svg" alt="...">`.
4. **Commit both** the `.excalidraw` master (diffable JSON) and the rendered `.svg`.

### Excalidraw element schema (minimal, validated)
Every element carries these common fields:
`type, version, versionNonce, isDeleted:false, id (unique), fillStyle ("hachure"|"solid"), strokeWidth (1), strokeStyle ("solid"), roughness (1 = hand-drawn; 0 = clean), opacity (100), angle (0), x, y, strokeColor ("#1e1e1e"), backgroundColor ("transparent" or hex), width, height, seed (int), groupIds ([]), boundElements ([]), updated (int), link (null), locked (false)`.

Per type, add:
- **rectangle**: `"roundness": {"type": 3}` (rounded corners; or `null`).
- **text**: `"roundness": null, "fontSize": 20, "fontFamily": 1` (1 = Virgil hand-drawn; 2 = Helvetica; 3 = Cascadia), `"text", "textAlign": "center", "verticalAlign": "middle", "baseline": 18, "containerId": null, "originalText"`.
- **arrow**: set `width`/`height` to the Δx/Δy; add `"points": [[0,0],[dx,dy]], "lastCommittedPoint": null, "startBinding": null, "endBinding": null, "startArrowhead": null, "endArrowhead": "arrow"`. (Bindings optional — they only matter for re-flowing in the Obsidian editor; a rendered SVG looks right without them.)

File wrapper: `{ "type":"excalidraw", "version":2, "source":"wiki-teach", "elements":[...], "appState":{"viewBackgroundColor":"#ffffff"}, "files":{} }`.

**Worked example** (validated — renders to a hand-drawn SVG): the 2-box smoke fixture inside `bin/setup-excalidraw.sh`, and the voicebox course's `course/voicebox/reference/voicebox-sidecar-architecture.excalidraw`.

### Layout conventions
- `roughness: 1` + `fontFamily: 1` (Virgil) — keep both consistent across the course.
- Grid ≈ 80–120 px units; align boxes in rows/columns; leave headroom for labels.
- **One diagram, one relationship type.** If a picture tries to show more than two axes of information, split it into two diagrams.
- Color: restrained (1–2 accents); `backgroundColor` can tint a group.
- Be rigorous: every arrow has an unambiguous start/end and a label where the relationship isn't obvious.
- Re-render after any edit to the `.excalidraw`; the `.svg` is a rendered artifact, never hand-edited.

### Fallback
If `excalidraw-render.sh` exits non-zero (malformed JSON, exporter unavailable), fall back to `mmdc -i <name>.mmd -o <name>.svg` (mermaid-cli — clean style, not hand-drawn) so the lesson always has an image, and note in the lesson "clean fallback — re-render from excalidraw". Fix the `.excalidraw` and re-render when you can.

## Assets

Lessons are built from reusable **components** in `assets/`: stylesheets, quiz widgets, the shared `style.css`, **and the rendered diagram `.svg`s**. Reuse is the default: before authoring a lesson, read `assets/` and build from what is there. When something new and reusable is needed, write it as a component and link — never inline code a future lesson would duplicate. A shared stylesheet is the first component every course earns.

---

## The mission

Every lesson ties into the mission — the _reason_ the user is learning. If the mission is unclear or `MISSION.md` unpopulated, your first job is to question the user on _why_. A bad mission is worse than no mission: lessons feel abstract and you cannot judge what to do next.

Missions change as the user develops. When the goal moves, update `MISSION.md` + add a learning record capturing the change. **Confirm with the user before changing the mission.**

## Zone of proximal development

Each lesson should challenge the user "just enough." If the user did not specify an exact thing to learn, figure out the zone by reading `learning-records`, reasoning from the mission, and teaching the most relevant thing that fits.

---

## Knowledge and skills

**Knowledge**: design the lesson around a skill the user will learn; teach only the knowledge required to acquire it. Gather knowledge from trusted resources (`RESOURCES.md`); litter lessons with citations. For knowledge acquisition, difficulty is the enemy — it eats working memory.

**Skills**: durability and flexibility. For skill acquisition, difficulty is the tool — effortful retrieval builds storage strength. Teach skills through interactive lessons with a tight feedback loop (quizzes, in-browser tasks, guided real-world steps). For quizzes, each answer should be the same length so formatting gives no clue.

## Acquiring wisdom

Wisdom comes from real-world interaction. When a question needs wisdom, attempt to answer but ultimately delegate to a **community** (forum, subreddit, real-world class, local group). Find high-reputation communities; respect an opt-out.

## Reference documents

While creating lessons, also create reference documents (`reference/*.html`) — the compressed essence, designed for quick reference. Lessons are rarely revisited; reference docs are. Glossaries are essential — once created, adhere to them in every lesson. The `reference/` folder also holds the **`.excalidraw` diagram masters** (see §Diagrams).

## `NOTES.md`

Record user preferences and things to keep in mind when designing lessons.

---

## Concurrency (v1.7+)

Wiki writes during **sync** (concept/source pages, index/log/hot) MUST be lock-guarded:

```bash
bash scripts/wiki-lock.sh acquire wiki/concepts/<X>.md || sleep 2 && bash scripts/wiki-lock.sh acquire wiki/concepts/<X>.md
# … write via transport (CLI/MCP/filesystem) …
bash scripts/wiki-lock.sh release wiki/concepts/<X>.md
```

Multi-file syncs (several concept pages + source page + index/log/hot): acquire locks in sorted-path order. Course-workspace writes (`course/<slug>/...`) do not need wiki-locks — they are outside `wiki/`. See `skills/wiki-ingest/SKILL.md` §Concurrency.

---

## What NOT to do

- Do NOT write to the wiki outside of the `sync` operation. The course workspace (`course/`) and the wiki (`wiki/`) are separate; sync is the only bridge.
- Do NOT promote mere lesson coverage into the wiki — only decision-grade learning-records / glossary terms that earned their place.
- Do NOT trust parametric knowledge for the topic — ground everything in `RESOURCES.md`.
- Do NOT skip the MISSION interview. A vague mission wrecks the whole course.
- Do NOT start writing lessons before asking + recording the teaching language. A course in the wrong language is the most expensive mistake to fix.
- Do NOT touch the global `/teach` skill or assume it is installed — this skill is self-contained.
- Do NOT auto-sync on every session. Sync is user-initiated (typically at completion).

---

## How to think (10-principle mapping)

When working on this skill, apply the 10-principle loop. See [`skills/think/SKILL.md`](../think/SKILL.md) for the canonical framework.

| # | Principle | Application here |
|---|-----------|-------------------|
| 1 | OBSERVE (ext) | Read the full course state (MISSION/PATH/records/last lesson) before deciding the next lesson. State drives the zone of proximal development. |
| 2 | OBSERVE (int) | Am I teaching what I find interesting, or what the user's mission requires? The mission decides, not my curiosity. |
| 3 | LISTEN | The user's _why_ (mission) — concrete outcome, not abstract. Interview until it is real. |
| 4 | THINK | One tangible win per lesson, in the zone of proximal development. Difficulty is the tool for skills, the enemy for knowledge. |
| 5 | CONNECT (lat) | Tie each lesson to prior learning-records; surface cross-links to the wiki during sync. |
| 6 | CONNECT (sys) | Reuses teach methodology + web-access (resources) + wiki-ingest ceremony (sync) + wiki-garden (MOC) + wiki-lock/address. |
| 7 | FEEL | Lessons are beautiful and short; the user returns to them. A lesson that drains is a failed lesson. |
| 8 | ACCEPT | Some topics the user will never master; record honestly in PATH. Don't inflate mastery — coverage ≠ learning. |
| 9 | CREATE | HTML lessons + learning-records + (at completion) distilled wiki concept pages. |
| 10 | GROW | Sync turns one person's course into the vault's compounding knowledge; the next learner (or future-you) starts from it. |
