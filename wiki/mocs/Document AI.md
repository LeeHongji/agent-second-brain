---
address: c-000073
type: moc
title: "Document AI"
domain: document-parsing
created: 2026-06-28
updated: 2026-06-28
tags: [moc, document-parsing, data-engineering]
status: developing
members:
  - "[[Document Parsing]]"
  - "[[VLM-based Document Parsing]]"
  - "[[Math Formula Recognition]]"
related:
  - "[[LLM Wiki Design]]"
---

# Document AI

How documents (PDF / Office / images) become **structured Markdown/JSON** ready for LLM, RAG, and agent pipelines. This is the **ingestion front-end** — literally how papers, books, and scans would enter this vault. The cluster spans the pipeline-vs-VLM-vs-hybrid tradeoff and the sub-task (formula → LaTeX) that makes scientific PDFs machine-readable.

## Members

| Page | Role |
|---|---|
| [[Document Parsing]] | documents → structured Markdown/JSON; the ingestion front-end |
| [[VLM-based Document Parsing]] | single VLM reads a page end-to-end vs the traditional multi-stage pipeline |
| [[Math Formula Recognition]] | detect formulas + transcribe image→LaTeX; makes scientific PDFs readable |

## Foundational source + entities
- [[MinerU]] — OpenDataLab's parsing engine; 3 backends (pipeline 86 / vlm 95 / hybrid 95 on OmniDocBench).
- [[OpenDataLab]] — Shanghai AI Lab's open-data platform; the org behind MinerU + OmniDocBench.
- [[OmniDocBench]] — the end-to-end document-parsing benchmark MinerU et al. report against.

## Cross-cluster
This is the ingestion tool that would feed [[LLM Wiki Design]] — the parsing step before `.raw/` → wiki.
