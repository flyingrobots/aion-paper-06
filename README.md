# AIΩN Foundations — Paper VI

## WARP Graphs: Ethics of Deterministic Replay & Provenance Sovereignty

|  |  |  |
|--|--|--|
| **DOI** | `TBD` | — |

**Status:** Draft (in preparation)

### Front Matter

WARP Graphs: Ethics of Deterministic Replay & Provenance Sovereignty  
James Ross (ORCID: [0009-0006-0025-7801](https://orcid.org/0009-0006-0025-7801))  
Independent Researcher  
AIΩN Foundations Series — Paper VI  
February 2026

---

## Overview

This repository contains the LaTeX source and compiled PDF for Paper VI of the AIΩN Foundations Series.
Canonical manuscript source is `paper/main.tex`.

Paper VI addresses the ethical, legal, and social implications of deterministic replay and provenance sovereignty in WARP computation, including accountability, privacy, auditability, and power asymmetries. The manuscript uses an argument-first core narrative with mechanism/conformance annexes for implementers.

---

## Contents

- `paper/main.tex` — Primary LaTeX manuscript (Paper VI)
- `paper/aion.cls` — AIΩN Foundations class file
- `paper/macros.tex` — Notation and helper macros
- `paper/diagrams.tex` — TikZ diagrams and global styles
- `paper/refs.bib` — Bibliography
- `Makefile` — Convenience build (latexmk + jobname/output directory)
- `archive/legacy/main_revised.tex` — Legacy manuscript snapshot (not used by build)
- `archive/legacy/refs_revised.bib` — Legacy bibliography snapshot (not used by build)
- `pdf/` — Compiled PDF + LaTeX build artifacts

---

## Build Instructions

Requires:
- TeX Live or MiKTeX
- `latexmk` recommended (used by the Makefile)

Build from the repo root with:

```bash
make
```

Clean + rebuild:

```bash
make clean
make
```

The compiled paper appears in `./pdf/` as `aion-paper-06-ethics-deterministic-replay-provenance-sovereignty.pdf`.

---

## AIΩN Foundations Series

This paper is part of the AIΩN foundational series:

1. [WARP Graphs: A Worldline Algebra for Recursive Provenance](https://github.com/flyingrobots/aion-paper-01-warp)
2. [WARP Graphs: Canonical State Evolution and Deterministic Worldlines](https://github.com/flyingrobots/aion-paper-02-worldlines)
3. [WARP Graphs: Computational Holography & Provenance Payloads](https://github.com/flyingrobots/aion-paper-03-holography)
4. [WARP Graphs: Rulial Distance & Observer Geometry](https://github.com/flyingrobots/aion-paper-04-observer-geometry)
5. The AIΩN Computer: Architecture & OS (JITOS)
6. **WARP Graphs: Ethics of Deterministic Replay & Provenance Sovereignty *(this repo)***

---

## License

This repository contains the Paper VI manuscript, figures, compiled PDF, and documentation. These materials are © 2025--2026 James Ross and licensed under **Creative Commons Attribution 4.0 (CC BY 4.0)**; see `LICENSE` for details.

The AIΩN Runtime and JITOS software projects referenced by the paper are *not* part of this repository; they live in separate repositories under their own licenses.

---

## More on AIΩN

For updates, see the main AIΩN repository:
[github.com/flyingrobots/aion](https://github.com/flyingrobots/aion)
