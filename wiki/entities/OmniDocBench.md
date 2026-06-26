---
address: c-000040
type: entity
entity_type: benchmark
created: 2026-06-26
updated: 2026-06-26
title: "OmniDocBench"
aliases:
  - "OmniDocBench"
parent_org: "[[OpenDataLab]]"
tags:
  - entity
  - benchmark
  - document-parsing
  - evaluation
status: developing
related:
  - "[[MinerU]]"
  - "[[OpenDataLab]]"
  - "[[Document Parsing]]"
---

# OmniDocBench

**OmniDocBench** is [[OpenDataLab]]'s comprehensive **end-to-end benchmark for document parsing**. MinerU's accuracy claims (e.g. pipeline 86.47, vlm-engine 95.39, hybrid-engine 95.30) are the "End-to-End Evaluation Overall" scores from OmniDocBench **v1.6**, measured against the latest MinerU release.

## Why it matters

Document parsing is hard to evaluate (layout, reading order, formulas, tables, OCR all interact). OmniDocBench is the de-facto yardstick [[MinerU]] and competing parsers (Textin, Marker, Docling, etc.) report against. When a document-parsing tool quotes an accuracy number, check whether it is on OmniDocBench and which version — v1.5 vs v1.6 differ.

> [!gap] Open question
> OmniDocBench is maintained by the same org as MinerU (OpenDataLab). The scores are useful for relative comparison, but self-benchmarking is a known evaluation risk — worth cross-checking against independent benchmarks before betting on a parser for production.

## Provenance

Encountered via [[MinerU]] ingest (2026-06-26). Related OpenDataLab tooling: PDF-Extract-Kit, MinerU-Diffusion.
