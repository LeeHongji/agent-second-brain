---
address: c-000013
type: concept
title: "Document Parsing"
complexity: intermediate
domain: data-engineering
aliases:
  - "Document Extraction"
  - "PDF Parsing"
  - "Document-to-Markdown"
created: 2026-06-26
updated: 2026-06-26
tags:
  - concept
  - document-parsing
  - ingestion
  - rag
status: developing
related:
  - "[[MinerU]]"
  - "[[VLM-based Document Parsing]]"
  - "[[Math Formula Recognition]]"
---

# Document Parsing

**Document parsing** is the task of converting complex, presentation-oriented documents (PDF, images, Office files, web pages) into **structured, machine-readable text** (Markdown, JSON, or a semantic tree) that preserves the document's *meaning* — reading order, headings, lists, tables, formulas, figures — while discarding presentation noise (headers, footers, page numbers, decorative layout).

It is the **ingestion front-end** for almost every LLM/RAG/Agent knowledge pipeline: you cannot retrieve, extract, or reason over a document until it has been parsed into tokens in the right order.

## Why it is hard

- **Layout** — multi-column, sidebars, callouts, nested tables. The visual 2D layout must be flattened into a 1D reading order.
- **Mixed content** — text interleaved with formulas, images, tables, and charts, each needing different handling.
- **Born-digital vs scanned** — digital PDFs have a text layer; scans need OCR first. Some PDFs have garbled/missing text layers.
- **Cross-page structure** — a table or section that spans pages must be reassembled.
- **Semantic vs visual** — a small bold line could be an H1, a footnote, or a caption; the parser must decide.

## Two approaches

1. **Traditional pipeline** — a chain of specialized CV/OCR models: layout detection → OCR → [[Math Formula Recognition\|formula recognition]] → table recognition → reading-order assembly. Deterministic, fast, **no hallucination**, CPU-friendly. Lower accuracy on hard layouts. (MinerU's `pipeline` backend scores ~86 on OmniDocBench.)
2. **VLM-based** — a single vision-language model reads the page and emits structured Markdown end-to-end. Higher accuracy, handles charts/images, but slower, GPU-bound, and can hallucinate. (MinerU's `vlm-engine` scores ~95.) See [[VLM-based Document Parsing]].

Most production systems pick per-document: pipeline for clean text PDFs at scale, VLM for scans/complex layouts. MinerU's `hybrid-engine` formalizes this by using native text where available and VLM only for hard regions.

## Evaluation

The standard benchmark is [[OmniDocBench]] (end-to-end document-parsing accuracy). When comparing parsers (MinerU, Docling, Marker, Textin, unstructured.io, etc.), check the OmniDocBench version and whether the score is overall or per-category (formula/table/OCR).

## Reference tools

- [[MinerU]] (OpenDataLab) — the reference open-source engine; three backends.
- Docling (IBM), Marker, unstructured.io, LlamaParse — alternatives in the same category.
- PDF-Extract-Kit — the toolkit MinerU grew out of.

## Connection to this vault

This wiki ingests sources (articles, papers, repos) into Markdown. A document parser like MinerU is how *PDFs/papers/books* would enter the same pipeline — it is the upstream of `.raw/` ingestion when the source is a non-Markdown document. See [[MinerU]] for the concrete engine.
