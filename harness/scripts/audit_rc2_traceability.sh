#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<USAGE
Usage: $(basename "$0") --tex <paper/main.tex> --out <report.md>
USAGE
}

TEX=""
OUT=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --tex)
      TEX="$2"
      shift 2
      ;;
    --out)
      OUT="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ -z "$TEX" || -z "$OUT" ]]; then
  usage >&2
  exit 1
fi

if [[ ! -f "$TEX" ]]; then
  echo "TeX file not found: $TEX" >&2
  exit 1
fi

mkdir -p "$(dirname "$OUT")"

req_ids=(
  "REQ-OBS-001"
  "REQ-RIL-001"
  "REQ-RIL-002"
  "REQ-SOV-001"
  "REQ-WTD-001"
  "REQ-FRK-001"
  "REQ-DSL-001"
  "REQ-TST-003"
  "REQ-TST-004"
)

fail_count=0

{
  echo "# RC2 Traceability Audit"
  echo
  echo "- Source: \`$TEX\`"
  echo "- Scope: promoted RC2 REQ set"
  echo
  echo "| REQ ID | Clause Present | Annex D Row Present | Annex E Vector Ref Present | Occurrences | Orphan Status |"
  echo "|---|---|---|---|---:|---|"

  for req in "${req_ids[@]}"; do
    clause="NO"
    annex_d="NO"
    annex_e="NO"

    if rg -q "\\\\subsection\*\{${req}\}" "$TEX"; then
      clause="YES"
    fi

    if rg -q "^${req} &" "$TEX"; then
      annex_d="YES"
    fi

    if rg -q "Expected REQ (pass|fail) set:.*${req}" "$TEX"; then
      annex_e="YES"
    fi

    occurrences="$(rg -o "${req}" "$TEX" | wc -l | tr -d ' ')"

    orphan_status="PASS"
    if [[ "$clause" != "YES" || "$annex_d" != "YES" || "$annex_e" != "YES" ]]; then
      orphan_status="FAIL"
      fail_count=$((fail_count + 1))
    fi

    echo "| ${req} | ${clause} | ${annex_d} | ${annex_e} | ${occurrences} | ${orphan_status} |"
  done

  echo
  echo "## Claim-to-REQ Coverage Checks"
  echo "- RC2 hardening promotion paragraph present: $(if rg -q "Hardening pass 2 promotion" "$TEX"; then echo PASS; else echo FAIL; fi)"
  echo "- TV-012..TV-019 section present: $(if rg -q "TV-012" "$TEX" && rg -q "TV-019" "$TEX"; then echo PASS; else echo FAIL; fi)"

  echo
  if [[ "$fail_count" -eq 0 ]]; then
    echo "## Audit Verdict"
    echo "- **PASS**: no orphan promoted RC2 requirements detected."
  else
    echo "## Audit Verdict"
    echo "- **FAIL**: ${fail_count} promoted RC2 requirements are missing a required linkage."
  fi
} > "$OUT"

if [[ "$fail_count" -ne 0 ]]; then
  exit 1
fi
