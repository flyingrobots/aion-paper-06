# AIΩN Foundations — Paper VI

## WARP Graphs: Ethics of Deterministic Replay & Provenance Sovereignty

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.18863648.svg)](https://doi.org/10.5281/zenodo.18863648)

- DOI: [10.5281/zenodo.18863648](https://doi.org/10.5281/zenodo.18863648)
- Author: James Ross (ORCID: [0009-0006-0025-7801](https://orcid.org/0009-0006-0025-7801))
- Date: March 2026

## Repository Purpose

This repository is intentionally minimal and contains only the files needed to build and ship Paper VI.

## Layout

- `LICENSE` — CC BY 4.0 license notice
- `CITATION.cff` — Citation metadata for GitHub and downstream tools
- `.zenodo.json` — Zenodo metadata (title, description, creators, keywords, related identifiers)
- `paper/main.tex` — Canonical manuscript source
- `paper/refs.bib` — Bibliography database
- `Makefile` — Build entrypoint (`latexmk`)
- `pdf/aion-paper-06-ethics.pdf` — Compiled paper

## Build

Prerequisites:

- TeX Live (or equivalent LaTeX distribution)
- `latexmk`

From repo root:

```bash
make
```

Rebuild cleanly:

```bash
make clean
make
```

Build output:

- `pdf/aion-paper-06-ethics.pdf`
