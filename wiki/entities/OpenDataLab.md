---
type: entity
entity_type: organization
created: 2026-06-26
updated: 2026-06-26
title: "OpenDataLab"
aliases:
  - "OpenDataLab"
  - "Shanghai AI Lab Data Platform"
url: "https://github.com/opendatalab"
location: "Shanghai, China (Shanghai AI Lab)"
tags:
  - entity
  - organization
  - data
  - open-source
status: developing
related:
  - "[[MinerU]]"
  - "[[OmniDocBench]]"
---

# OpenDataLab

**OpenDataLab** is the open data platform of **Shanghai AI Lab**, focused on open datasets, data tooling, and document/document-AI infrastructure for large-model training. It is the organization behind [[MinerU]] and the [[OmniDocBench]] benchmark.

## Notable projects

- [[MinerU]] — high-accuracy document parsing engine for LLM/RAG/Agent workflows.
- [[OmniDocBench]] — comprehensive benchmark for document parsing & evaluation.
- **PDF-Extract-Kit** — toolkit for high-quality PDF content extraction (MinerU's predecessor/sibling).
- **MinerU-Diffusion** — reframes document OCR as inverse rendering via diffusion decoding.
- **InternLM** — the LLM whose pretraining spawned MinerU (symbol-conversion needs).
- **LabelU / LabelLLM / Dingo** — annotation and data-quality tooling.
- **Magic-HTML / Magic-Doc** — web/office extraction.

## Relevance

OpenDataLab is a major contributor to the **document → LLM-ready data** layer of the open-source AI stack. Their toolchain (MinerU + OmniDocBench + PDF-Extract-Kit) is a reference point for anyone building ingestion pipelines for a knowledge base or RAG system. See [[Document Parsing]].

## Provenance

- Encountered via [[MinerU]] (ingested 2026-06-26).
- Org: https://github.com/opendatalab
- Position paper: OpenDataLab (arXiv 2407.13773).
