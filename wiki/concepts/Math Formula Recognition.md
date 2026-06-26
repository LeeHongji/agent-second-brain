---
address: c-000017
type: concept
title: "Math Formula Recognition"
complexity: advanced
domain: document-parsing
aliases:
  - "MFR"
  - "Formula Recognition"
  - "Formula-to-LaTeX"
  - "Equation Recognition"
created: 2026-06-26
updated: 2026-06-26
tags:
  - concept
  - document-parsing
  - formula
  - latex
  - ocr
status: developing
related:
  - "[[Document Parsing]]"
  - "[[MinerU]]"
---

# Math Formula Recognition

**Math Formula Recognition (MFR)** is the sub-task of [[Document Parsing]] that detects mathematical formulas in a document (inline and display) and converts their image into structured, machine-readable code — almost always **LaTeX**. It is what makes scientific PDFs machine-readable: without MFR, a parser returns "∫₀^∞ e^(−x²) dx" as a garbled image or wrong Unicode; with MFR it returns `\int_{0}^{\infty} e^{-x^2}\,dx`.

## Two sub-problems

1. **Formula detection (MFD)** — find the bounding boxes of formulas on the page (distinguishing them from prose, tables, figures). Historically a YOLO-style detector.
2. **Formula recognition (MFR)** — crop each detected formula and transcribe it to LaTeX. This is the hard part — it is image→sequence (like a small image-captioning model, but for dense notation).

## Why it is hard

- **2D grammar** — LaTeX is linear, but math is two-dimensional (fractions, superscripts, matrices, roots, summation limits). The model must serialize a 2D structure into a linear string with correct nesting.
- **Symbol density** — a small region can contain dozens of distinct glyphs; a single misread symbol breaks the expression.
- **Inline vs display** — inline formulas are small and baseline-aligned; display formulas are large and centered; both must be detected.
- **Handwritten input** — a different (harder) regime.

## Approaches

- **Specialized models** — UniMERNet (a MinverU upstream component) is a purpose-built formula-recognition network. PaddleOCR also provides formula support.
- **VLM** — modern [[VLM-based Document Parsing]] models (e.g. MinerU2.5-Pro) handle formulas as part of end-to-end page reading, often outperforming specialized models on complex layouts.
- **Hybrid** — detect with a specialized detector, recognize with a VLM.

## Quality matters downstream

Bad formula recognition silently corrupts the knowledge base — a misread integral or subscript propagates into retrieval and reasoning. For math-heavy ingestion (papers, textbooks), check MFR quality on a sample before scaling, and prefer tools that output LaTeX you can re-render to verify visually. [[MinerU]] exposes this via its layout/span visualizations.

## Interline formulas and numbering

Beyond the formula itself, a complete MFR pipeline also captures **interline formula numbering** (the "(3)" beside a display equation) and links it back, so references like "see Eq. (3)" still resolve. MinerU added this in its 3.0 pipeline upgrade.
