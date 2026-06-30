# PATH.md Format

`PATH.md` lives at the course workspace root (`course/<slug>/PATH.md`). It is the **learning plan** derived from the mission, plus the **progress tracker**. This is a project addition — the global `teach` skill has no syllabus; this gives the user a visible direction and progress without overriding the zone-of-proximal-development rule (the next lesson is still driven by `learning-records/`).

## Template

```md
# Path: {Topic}

**Status**: in-progress | completed
**Mission**: [[MISSION.md]]
**Last revised**: YYYY-MM-DD

## Direction

{1-3 sentences: the arc from where the user is now to the mission's success criteria. What changes about their ability over this course?}

## Milestones

Milestones are coarse goals, not lessons. One milestone = several lessons + the records that prove it stuck. Update each milestone's status as `learning-records` accumulate; revise the milestones themselves when the mission shifts.

- [ ] ◇ M1 — {milestone name}
      _Evidence needed_: {what a learning-record must show to mark this mastered}
- [~] ▶ M2 — {milestone name}
      _Evidence needed_: {…}
- [x] ✅ M3 — {milestone name}
      _Evidence_: [[learning-records/0003-<slug>]]

## Next

{The single most relevant next lesson, derived from the lowest un-mastered milestone + the zone of proximal development. One line.}
```

## Status glyphs

| Glyph | Meaning |
|---|---|
| ◇ / `[ ]` | not started |
| ▶ / `[~]` | learning — some records, not yet mastered |
| ✅ / `[x]` | mastered — a learning-record shows genuine understanding |

## Rules

- **Derive from the mission.** Every milestone traces to a `MISSION.md` success criterion. If it does not, either the milestone or the mission is wrong.
- **Coarse, not a lesson list.** Milestones are goals ("read and write a basic Rust struct with derived traits"), not lesson titles. The lesson sequence is emergent.
- **Progress follows records, not coverage.** Mark a milestone ✅ only when a `learning-records/` entry shows the user can _use_ the concept — not when a lesson was merely delivered. Coverage is not mastery.
- **Revise openly.** When the mission moves (a learning-record says it did), rewrite milestones. Strike old ones rather than deleting — the path's evolution is signal. Bump `Last revised`.
- **"Next" is one line.** It is a working pointer, recalculated each session from the lowest ◇/▶ milestone + the zone of proximal development. Do not turn PATH.md into a queue.
- **Course status**: `in-progress` until the user declares the mission's success criteria met → set `completed` → offer `/wiki-teach sync`.

## What PATH.md is NOT

- Not a syllabus to obey rigidly. It is a compass; the zone of proximal development chooses each lesson.
- Not a session log (that is not what learning-records are either — they are decision-grade). PATH aggregates; it does not journal.
- Not the source of truth for mastery — `learning-records/` is. PATH only mirrors it visibly.
