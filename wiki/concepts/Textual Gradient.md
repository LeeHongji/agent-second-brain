---
type: concept
title: "Textual Gradient"
complexity: advanced
domain: agents
aliases:
  - "Edit Patch"
  - "Text Gradient"
created: 2026-06-25
updated: 2026-06-25
tags:
  - concept
  - agents
  - optimization
  - skills
status: developing
related:
  - "[[SkillOpt]]"
  - "[[Text-Space Optimization]]"
  - "[[Validation-Gated Skill Update]]"
  - "[[Reflexion]]"
  - "[[Agent Error Propagation]]"
sources:
  - "[[SkillOpt]]"
---

# Textual Gradient

A **textual gradient** is the text-space analogue of a weight gradient: a structured **edit patch** (add / delete / replace) to a skill document, produced by an optimizer model *reflecting on failed rollouts*. Where backprop computes ∂loss/∂weights, the textual-gradient step computes "what to add/remove from the skill so this class of failure stops happening."

## How it is produced

After a [[Text-Space Optimization|rollout]], an **optimizer** model reads the failed trajectories and emits edit patches against the current skill document. Two reflection modes:

- **Shallow** — analyze each trajectory independently (cheap, local fixes).
- **Deep** — cross-reference multiple failures to surface *systemic* issues (a repeated mistake across tasks usually points at a missing or wrong rule in the skill, not N independent errors).

Patches are then **aggregated** (merge semantically similar edits) and **selected/ clipped** by the learning rate before being applied.

## Why "gradient" is the right word

Three properties justify the analogy (and make optimization stable):

1. **Directional** — a patch points from the current skill toward lower error on a specific failure class, like a gradient direction.
2. **Composable/aggregate-able** — overlapping patches merge, the way gradients sum across a minibatch.
3. **Rate-controllable** — clipping the number of applied patches per step (the learning rate) prevents overshooting, exactly like gradient clipping.

## Connection to existing ideas

- It is the engine inside [[SkillOpt]]'s Reflect stage.
- It generalizes [[Reflexion]]'s self-critique: Reflexion writes a verbal critique into *memory* for the next retry; a textual gradient writes a *patch into the skill document* so the failure class is fixed for every future run. Reflexion fixes the trajectory; textual gradients fix the program.
- Deep reflection is a direct mitigation for [[Agent Error Propagation]]: by finding the systemic root across many failures and editing the skill, it removes the upstream cause rather than patching downstream symptoms. (Source: [[SkillOpt]])
