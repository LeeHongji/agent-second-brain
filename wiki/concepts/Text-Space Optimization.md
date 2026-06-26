---
type: concept
title: "Text-Space Optimization"
complexity: advanced
domain: agents
aliases:
  - "Prompt Optimization"
  - "Skill Optimization"
  - "Text-Space Training"
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
  - "[[Textual Gradient]]"
  - "[[Validation-Gated Skill Update]]"
  - "[[Context Engineering]]"
  - "[[Augmented LLM]]"
  - "[[Reflexion]]"
sources:
  - "[[SkillOpt]]"
---

# Text-Space Optimization

**Text-space optimization** trains a frozen LLM's behavior by editing the *text* of its prompt/skill — treating the document as the model's trainable parameters — instead of updating weights. The contribution of [[SkillOpt]] is to show this can be done with the **same discipline as deep-learning training**, making it reproducible rather than alchemical.

## The core move

Freeze the model. Make the **skill document (Markdown)** the trainable state. Run rollouts, score them, compute a [[Textual Gradient]] (edit patches), clip/select by a learning rate, apply, and accept the update only if it passes a held-out [[Validation-Gated Skill Update|validation gate]]. Deploy the resulting `best_skill.md` against the unchanged model — zero extra inference cost.

## The DL ↔ text analogy

| Deep learning | Text-space counterpart |
|---|---|
| Model weights | Skill document (Markdown) |
| Forward pass | Rollout |
| Loss | Task evaluator |
| Backpropagation | Reflect (analyze failures) |
| Gradients | Edit patches |
| Gradient clipping | Edit selection (cap edits/step) |
| Learning rate | Max edits applied per step |
| LR scheduler | cosine / linear / constant |
| SGD step | Apply patches to document |
| Validation set | Selection split (gate) |
| Early stopping | Gate patience |
| Momentum | Slow update (epoch boundary) |
| Meta-learning | Meta-skill memory |
| Transfer learning | Seed skill / cross-benchmark init |

## What transfers (and what doesn't)

Empirically (from [[SkillOpt]]): cosine > constant; moderate LR (4–16 edits/step) beats extremes; slow update helps prevent catastrophic forgetting; meta-skill memory improves reflection. **Doesn't** transfer: bigger batch ≠ better (API cost dominates); more epochs ≠ better (skills converge in 2–4, far faster than networks).

## Relationship to neighbors

- vs [[Context Engineering]]: context engineering is the *manual* craft of what the model sees; text-space optimization is its *automated, trained* counterpart. The skill goes from hand-tuned to gradient-tuned.
- vs [[Reflexion]]: Reflexion edits an *episodic memory buffer* within one task; text-space optimization edits the *persistent skill document* across many tasks. Reflexion's self-critique is the local operation; text-space training is the global loop that fixes the root cause in the artifact.
- vs weight-space fine-tuning: no weight changes, no GPU training, model stays frozen and swappable; the artifact is plain Markdown anyone can read and edit. (Source: [[SkillOpt]])
