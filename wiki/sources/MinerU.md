---
type: source
created: 2026-06-26
updated: 2026-06-26
title: "MinerU: High-accuracy document parsing engine for LLM/RAG/Agent"
source_type: github_repo
author: "OpenDataLab (Shanghai AI Lab)"
date_published: 2026
venue: "github.com/opendatalab/MinerU · v3.4 (2026-06-18)"
url: "https://github.com/opendatalab/MinerU"
github: "https://github.com/opendatalab/MinerU"
license: "MinerU Open Source License (Apache 2.0 based)"
confidence: high
key_claims:
  - "Converts PDF/image/DOCX/PPTX/XLSX into LLM-ready Markdown + JSON; full-format native parsing since 3.1.0"
  - "Three parsing backends: pipeline (86.47 OmniDocBench v1.6, pure-CPU, no hallucination), vlm-engine (95.39, MinerU2.5-Pro-1.2B VLM), hybrid-engine (95.30, native text + VLM with effort=medium/high)"
  - "Flagship VLM MinerU2.5-Pro-2605-1.2B is a 1.2B decoupled vision-language model; supports image/chart parsing + cross-page table merge"
  - "Formulas → LaTeX, tables → HTML, 109-language OCR (pipeline uses PP-OCRv6), reading-order output, auto header/footer removal"
  - "Born during InternLM pretraining to solve scientific-literature symbol conversion"
  - "Ships MCP Server (Cursor/Claude Desktop/Windsurf) + LangChain/LlamaIndex/RAGFlow/Dify/FastGPT integration + Python/Go/TS SDK + REST API + Docker"
  - "Engineering: sliding-window memory for 10k+ page docs, streaming writes, thread-safe multi-GPU via mineru-router"
  - "License moved AGPLv3 → Apache-2.0-based MinerU OSL in 3.1.0; removed all AGPLv3/CC-BY-NC-SA dependency models in 3.0"
related:
  - "[[OpenDataLab]]"
  - "[[OmniDocBench]]"
  - "[[Document Parsing]]"
  - "[[VLM-based Document Parsing]]"
  - "[[Math Formula Recognition]]"
---

# MinerU — Document Parsing Engine

**MinerU** is a high-accuracy document parsing engine that converts complex documents (PDF, images, DOCX, PPTX, XLSX) into **LLM-ready Markdown and JSON** for retrieval, extraction, and agentic workflows. Maintained by [[OpenDataLab]] (Shanghai AI Lab). It originated during the pre-training of InternLM, where the team needed to solve symbol-conversion problems (formulas, tables, layouts) in scientific literature.

> [!key-insight] Why it matters for a second brain
> MinerU is the canonical "get documents *into* the LLM" step. Any pipeline that turns PDFs/books/papers into the Markdown a knowledge base runs on lives in this category — it is the ingestion front-end for [[Document Parsing]] at scale.

## The three-backend architecture

MinerU's central design choice is offering **three interchangeable parsing backends**, trading accuracy vs. cost vs. hallucination risk:

| Backend | OmniDocBench v1.6 | Profile | Runs on |
|---|---|---|---|
| `pipeline` | 86.47 | Traditional CV pipeline (layout + OCR + formula + table); fast, **no hallucination**, native text | **Pure CPU ok**, 4GB VRAM |
| `vlm-engine` | 95.39 (high) / 95.26 (medium) | End-to-end [[VLM-based Document Parsing\|VLM]] (`MinerU2.5-Pro`); highest accuracy | GPU 8GB VRAM |
| `hybrid-engine` | 95.30 | Native text extraction + VLM for hard regions; `effort` knob | GPU |

The `pipeline` backend is the low-resource, hallucination-free option (good for text PDFs at scale on CPU); `vlm-engine` is the accuracy leader; `hybrid-engine` splits the difference with an `effort=medium`/`high` knob (medium is 35–220% faster at −0.13 accuracy). See [[VLM-based Document Parsing]].

## Capabilities

- **Formulas → LaTeX**, **tables → HTML**, accurate layout reconstruction — see [[Math Formula Recognition]].
- 109-language OCR (pipeline upgraded to **PP-OCRv6** in v3.4, +~11% on OmniDocBench).
- Reading-order output, automatic header/footer/footnote/page-number removal.
- Scanned docs, handwriting, multi-column layouts, cross-page table merging.
- Outputs: multimodal Markdown, NLP Markdown, reading-order JSON, layout/span visualizations.

## Engineering at scale (v3.0+)

- **Sliding-window parsing** keeps peak memory flat for 10k+ page documents (no manual splitting).
- **Streaming writes** flush completed pages during batch inference.
- **Thread-safe** concurrent inference; `mineru-router` gives one-click multi-service / multi-GPU deployment with load balancing.
- API surface: async `POST /tasks` + sync `POST /file_parse`; CLI auto-starts a local `mineru-api` if no `--api-url`.

## Integration surface

- **MCP Server** — Cursor, Claude Desktop, Windsurf.
- **RAG frameworks** — LangChain, LlamaIndex, RAGFlow, RAG-Anything, Flowise, Dify, FastGPT.
- **SDK / runtime** — Python / Go / TypeScript SDK, CLI, REST API, Docker, Gradio WebUI, mineru.net online.
- 10+ domestic AI chips supported (Ascend, Cambricon, Enflame, MetaX, Moore Threads, etc.).

## Provenance

- Source repo: https://github.com/opendatalab/MinerU (v3.4 at fetch).
- Benchmark: [[OmniDocBench]] v1.6 (their own document-parsing eval).
- Papers: MinerU2.5-Pro (arXiv 2604.04771), MinerU2.5 decoupled VLM (2509.22186), MinerU-Diffusion — OCR as inverse rendering via diffusion (2603.22458), original MinerU (2409.18839).
- Upstream components: UniMERNet (formulas), TableStructureRec, PaddleOCR, pypdfium2, vLLM, LMDeploy.
- Local archive of this ingest: `.raw/articles/mineru-2026-06-26.md`.
