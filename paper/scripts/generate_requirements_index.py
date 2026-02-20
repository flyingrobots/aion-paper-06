#!/usr/bin/env python3
"""Generate machine-readable requirement indexes from Annex B + Annex D.

This script treats paper/main.tex as the source of truth and emits:
  - paper/requirements-index.csv
  - paper/requirements-index.json
"""

from __future__ import annotations

import argparse
import csv
import hashlib
import json
import re
from pathlib import Path


def normalise_text(value: str) -> str:
    value = value.replace("~", " ")
    value = value.replace("\\allowbreak", "")
    value = value.replace("\\\\", "")
    value = re.sub(r"\s+", " ", value)
    return value.strip()


def extract_block(text: str, start_marker: str, end_marker: str) -> str:
    start = text.find(start_marker)
    if start < 0:
        raise ValueError(f"Start marker not found: {start_marker}")
    end = text.find(end_marker, start)
    if end < 0:
        raise ValueError(f"End marker not found: {end_marker}")
    return text[start:end]


def extract_req_fields(block: str) -> dict[str, dict[str, str]]:
    # Capture each REQ subsection through the next REQ subsection or next annex section.
    req_pattern = re.compile(
        r"\\subsection\*\{(REQ-[A-Z0-9-]+)\}(.*?)(?=\\subsection\*\{REQ-|\\section\{Annex C:|\Z)",
        re.S,
    )

    def field(text: str, label: str) -> str:
        pat = re.compile(rf"\\textbf\{{{re.escape(label)}:\}}\s*(.*?)(?:\\\\\s*\n|\n)")
        m = pat.search(text)
        if not m:
            raise ValueError(f"Missing field '{label}' in REQ block")
        return normalise_text(m.group(1))

    reqs: dict[str, dict[str, str]] = {}
    for m in req_pattern.finditer(block):
        req_id = m.group(1)
        body = m.group(2)
        if req_id in reqs:
            raise ValueError(f"Duplicate requirement ID in Annex B: {req_id}")

        reqs[req_id] = {
            "clause": field(body, "Clause"),
            "owner_roles": field(body, "Owner role"),
            "control": field(body, "Control"),
            "evidence_artefact": field(body, "Evidence artefact"),
            "failure_mode": field(body, "Failure mode"),
        }
    return reqs


def extract_profiles(block: str) -> dict[str, dict[str, str | bool]]:
    # Parse rows from both Annex D tables (base rows and RC2 extension rows).
    row_pattern = re.compile(
        r"^(REQ-[A-Z0-9-]+)\s*&\s*([YN])\s*&\s*([YN])\s*&\s*(.*?)\s*&\s*(.*?)\s*\\\\\s*$",
        re.M,
    )

    profiles: dict[str, dict[str, str | bool]] = {}
    for m in row_pattern.finditer(block):
        req_id = m.group(1)
        baseline = m.group(2) == "Y"
        full = m.group(3) == "Y"
        review_cadence = normalise_text(m.group(5))
        evidence_required = normalise_text(m.group(4))

        if req_id in profiles:
            raise ValueError(f"Duplicate requirement ID in Annex D: {req_id}")

        profiles[req_id] = {
            "baseline": baseline,
            "full": full,
            "review_cadence": review_cadence,
            "evidence_required": evidence_required,
        }
    return profiles


def parse_paper_date(text: str) -> str:
    m = re.search(r"\\renewcommand\{\\paperdate\}\{([^}]*)\}", text)
    return m.group(1).strip() if m else ""


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--tex", default="paper/main.tex")
    parser.add_argument("--csv-out", default="paper/requirements-index.csv")
    parser.add_argument("--json-out", default="paper/requirements-index.json")
    args = parser.parse_args()

    tex_path = Path(args.tex)
    text = tex_path.read_text(encoding="utf-8")

    annex_b = extract_block(text, r"\section{Annex B: Requirement Clauses (REQ-*)}", r"\section{Annex C:")
    annex_d = extract_block(text, r"\section{Annex D: Conformance Profiles}", r"\subsection{One-page conformance declaration template}")

    req_fields = extract_req_fields(annex_b)
    profiles = extract_profiles(annex_d)

    req_ids = list(req_fields.keys())  # preserve Annex B order

    missing_profile = [rid for rid in req_ids if rid not in profiles]
    if missing_profile:
        raise ValueError(f"Missing Annex D profile rows for: {', '.join(missing_profile)}")

    extra_profile = [rid for rid in profiles if rid not in req_fields]
    if extra_profile:
        raise ValueError(f"Annex D has IDs not found in Annex B: {', '.join(extra_profile)}")

    rows: list[dict[str, str]] = []
    items: list[dict[str, object]] = []

    for rid in req_ids:
        f = req_fields[rid]
        p = profiles[rid]
        owner_roles_list = [x.strip() for x in f["owner_roles"].split(",") if x.strip()]

        rows.append(
            {
                "id": rid,
                "clause": f["clause"],
                "owner_roles": ";".join(owner_roles_list),
                "control": f["control"],
                "evidence_artefact": f["evidence_artefact"],
                "failure_mode": f["failure_mode"],
                "baseline": "Y" if p["baseline"] else "N",
                "full": "Y" if p["full"] else "N",
                "review_cadence": str(p["review_cadence"]),
            }
        )

        items.append(
            {
                "id": rid,
                "clause": f["clause"],
                "owner_roles": owner_roles_list,
                "control": f["control"],
                "evidence_artefact": f["evidence_artefact"],
                "failure_mode": f["failure_mode"],
                "profiles": {"baseline": bool(p["baseline"]), "full": bool(p["full"])},
                "review_cadence": p["review_cadence"],
            }
        )

    csv_path = Path(args.csv_out)
    csv_path.parent.mkdir(parents=True, exist_ok=True)
    with csv_path.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=[
                "id",
                "clause",
                "owner_roles",
                "control",
                "evidence_artefact",
                "failure_mode",
                "baseline",
                "full",
                "review_cadence",
            ],
            quoting=csv.QUOTE_ALL,
        )
        writer.writeheader()
        writer.writerows(rows)

    source_sha256 = hashlib.sha256(text.encode("utf-8")).hexdigest()
    json_doc = {
        "paper": "AION Foundations Paper VI",
        "paper_number": "Paper VI",
        "paper_date": parse_paper_date(text),
        "source": "paper/main.tex Annex B, Annex D",
        "schema_version": "1.1",
        "source_sha256": source_sha256,
        "requirements": items,
    }

    json_path = Path(args.json_out)
    json_path.parent.mkdir(parents=True, exist_ok=True)
    json_path.write_text(json.dumps(json_doc, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")

    print(f"Generated {len(rows)} requirements into {csv_path} and {json_path}")


if __name__ == "__main__":
    main()
