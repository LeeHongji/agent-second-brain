---
description: Learn a new domain as a structured multi-session course under course/, then sync durable learnings into the wiki. Project-scoped adoption of the global teach skill.
---

Read the `wiki-teach` skill. Then run the wiki-teach workflow for this request.

Usage:
- `/wiki-teach <topic>` — start a new course on `<topic>`, or continue if `course/<slug>/` already exists
- `/wiki-teach` (no arg) — list existing courses (`course/INDEX.md`) and ask whether to continue one or start new
- `/wiki-teach sync [<course>]` — promote the course's decision-grade learnings (learning-records / glossary) into the wiki as concept pages + a source summary page

If no project vault is set up (no `wiki/` and no `course/`), say: "No project vault found. Run /wiki first to set one up."

Detection rule: derive the course slug from the topic (lowercase, spaces→hyphens). If `course/<slug>/` exists → continue (read MISSION + learning-records + PATH + last lesson → next lesson in the zone of proximal development). If not → new course (interview for MISSION → create workspace + PATH → first lesson). Never touch the global `/teach` skill.
