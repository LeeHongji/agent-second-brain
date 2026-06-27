# Research Program

This file configures the autoresearch loop. Edit it to match your domain and research style. The autoresearch skill reads it before every run.

---

## Search Objectives

Default objectives for every research session:

- Find authoritative sources (prefer: .edu, peer-reviewed papers, official documentation, primary sources, established publications)
- Extract key entities (people, organizations, products, tools)
- Extract key concepts and frameworks
- Note contradictions between sources
- Identify open questions and research gaps
- Prefer sources from the last 2 years unless the topic is foundational

---

## Intent Modeling

Every run starts by building a **Research Brief** with the user (see the autoresearch skill's "Pre-research intent clarification"). Template:

- **Goal**: [one sentence — what the user actually wants to know]
- **Success criterion**: [Done = …]
- **Key angles**: [3-5 distinct facets to cover]
- **Preferred sources / platforms**: [e.g. 公众号, 知乎, arXiv, official docs; or "primary sources only"]
- **Exclusions**: [what to ignore]
- **Depth / budget**: [e.g. 2 rounds, ≤10 pages]

The brief **overrides** the default Search Objectives above when they conflict. If the user says "直接研究" / "just research", skip the clarifying questions and infer the brief from the topic alone — but still write it down.

For Chinese-platform topics (公众号 / 小红书 / 微博 / 知乎), note in the brief that the `web-access` CDP path is preferred for fetching (see the skill's "Web access substrate" section).

---

## Confidence Scoring

Label every claim with confidence when filing:

- **high**: multiple independent authoritative sources agree
- **medium**: single good source, or sources partially agree
- **low**: speculation, opinion pieces, single informal source, or claim not verified

Always note the source date for factual claims. Mark claims from sources older than 3 years as potentially stale.

---

## Loop Constraints

- Max search rounds per topic: **3**
- Max wiki pages created per session: **15**
- Max sources fetched per round: **5**
- If max pages is reached before the loop completes: file what you have, note what was skipped in Open Questions

---

## Output Style

- Declarative, present tense
- Cite every non-obvious claim: `(Source: [[Page]])`
- Short pages: under 200 lines. Split if longer.
- No hedging language ("it seems", "perhaps", "might be")
- Flag uncertainty explicitly: `> [!gap] This claim needs verification.`

---

## Domain Notes

[Add domain-specific instructions here. Examples:]

For AI/tech research:
- Prefer: arXiv, official GitHub repos, official product documentation, Hacker News discussions with high karma
- Note: LLM benchmarks are often gamed: treat leaderboard claims as low confidence unless independently verified

For business/market research:
- Prefer: company filings, Crunchbase, Bloomberg, verified industry reports
- Flag: press releases as low confidence without independent verification

For medical/health research:
- Prefer: PubMed, Cochrane reviews, peer-reviewed clinical trials
- Always note: sample size, study type (RCT vs observational), and recency

---

## Exclusions

Do not cite as high-confidence sources:
- Reddit posts or forums (use as pointers to primary sources only)
- Social media posts
- Undated web pages
- Sources that don't cite their own claims
