---
type: concept
title: "Verification-Gated Completion"
complexity: intermediate
domain: agents
aliases:
  - "End-to-End Verification"
  - "Anti-Premature-Victory"
  - "Evidence-Based Completion"
created: 2026-06-25
updated: 2026-06-25
tags:
  - concept
  - agents
  - harness-engineering
  - verification
status: developing
related:
  - "[[Harness Engineering]]"
  - "[[Learn-Harness-Engineering]]"
  - "[[Agent Scope Control]]"
  - "[[Agent Session Lifecycle]]"
  - "[[Validation-Gated Skill Update]]"
  - "[[Agent Error Propagation]]"
  - "[[Reflexion]]"
sources:
  - "[[Learn-Harness-Engineering]]"
---

# Verification-Gated Completion

The Verification subsystem enforces one rule: **confidence is not correctness — only a passing full-pipeline run counts as "done."** The agent cannot declare victory without runnable proof. (Course lectures L09 + L10. Source: [[Learn-Harness-Engineering]])

## Premature victory (L09)

Agents declare victory too early because nothing structural distinguishes "I think it works" from "it works." The agent writes code, it looks right, and the agent reports done — skipping the step that would have caught the break. The harness replaces the agent's self-assessment with an external, runnable signal: tests pass, lint is clean, types check. "Agent says it looks fine" becomes "tests pass, lint clean, types check."

## End-to-end verification (L10)

Unit tests alone are insufficient because they miss integration breaks. Only a **full-pipeline run** (build + tests + lint + type-check + smoke + e2e) counts as real verification. The course's evidence: switching from partial to full-pipeline verification measurably changes results — it catches the failures that partial checks let through. This is the difference between "the function returns the right value" and "the feature actually works end to end."

## Relationship to neighbors

- This is the completion-time analog of [[Validation-Gated Skill Update]]: there, a skill edit is accepted only if it beats held-out validation; here, a feature is "done" only if the full pipeline passes. Both replace self-judgment with an external gate.
- It is the structural fix for the most common [[Agent Error Propagation]] failure — the "says done, nothing works" case — by forcing evidence before the WRAP-UP phase of the [[Agent Session Lifecycle]] commits.
- It connects to [[Reflexion]]: P05 of the course makes the agent verify its *own* work (self-verification + grounded Q&A), but the gate is the full pipeline, not the model's self-critique — avoiding Reflexion's self-critique blind spot. (Source: [[Learn-Harness-Engineering]])
