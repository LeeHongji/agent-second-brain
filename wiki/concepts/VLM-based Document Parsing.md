---
address: c-000031
type: concept
title: "VLM-based Document Parsing"
complexity: advanced
domain: multimodal-ai
aliases:
  - "VLM Document Parsing"
  - "End-to-end Document VLM"
  - "Vision-Language Document Parsing"
created: 2026-06-26
updated: 2026-06-26
tags:
  - concept
  - document-parsing
  - vlm
  - multimodal
status: developing
related:
  - "[[Document Parsing]]"
  - "[[MinerU]]"
  - "[[Math Formula Recognition]]"
---

# VLM-based Document Parsing

**VLM-based document parsing** replaces the traditional multi-stage [[Document Parsing]] pipeline with a single (or decoupled) **vision-language model** that looks at a rendered page and emits structured output (Markdown/JSON) directly. Instead of "detect layout → OCR each region → classify each block → assemble," the VLM reads the page like a human and writes it out.

## Pipeline vs VLM vs Hybrid

| Approach | How it works | Strengths | Weaknesses |
|---|---|---|---|
| Pipeline | Layout detector + OCR + formula/table models, then assemble | Fast, CPU-friendly, deterministic, **no hallucination** | Struggles on hard layouts/charts; many moving parts |
| VLM | One VLM (or decoupled ViT+LLM) renders page → Markdown | Highest accuracy; handles images/charts/handwriting; simple conceptually | GPU-bound; slower; **can hallucinate**; cost |
| Hybrid | Native text extraction + VLM only for hard regions | Accuracy near VLM, cost near pipeline, low hallucination | More engineering; needs a routing policy |

[[MinerU]] ships all three (`pipeline`, `vlm-engine`, `hybrid-engine`). The hybrid `effort` knob (`medium` vs `high`) lets you trade speed for accuracy — `medium` is 35–220% faster at only −0.13 accuracy on [[OmniDocBench]] v1.6, and is the default.

## The decoupled-VLM pattern

A key engineering insight from MinerU2.5: rather than a monolithic VLM, **decouple the vision encoder from the language model** (a ViT front-end + a small LLM). Benefits:
- The vision tower can be high-resolution without bloating the LLM.
- The LLM can be swapped/served with standard inference stacks (vLLM, LMDeploy, SGLang, mlx).
- Keeps the model small — MinerU2.5-Pro is **1.2B params** yet reaches SOTA parsing accuracy, so it runs on a single consumer GPU.

## When to choose VLM parsing

- Scanned or photographed documents (no text layer).
- Scientific papers with heavy formulas and figures — see [[Math Formula Recognition]].
- Documents with charts, stamps, handwriting, or multi-column "magazine" layouts.
- When you can afford a GPU and want max accuracy.

Prefer the pipeline backend for clean born-digital text PDFs at scale on CPU, where hallucination risk and GPU cost are not worth it.

## Hallucination risk

A VLM that generates text can invent content (especially in low-resolution or ambiguous regions). For factual/legal/medical ingestion, prefer `pipeline` or `hybrid` (which uses native text where it exists) over pure `vlm-engine`, and keep the source document for audit.
