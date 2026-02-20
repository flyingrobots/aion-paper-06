#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<USAGE
Usage: $(basename "$0") --vectors <csv> --out <report.md> [--verify-determinism]
USAGE
}

VECTORS=""
OUT=""
VERIFY=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --vectors)
      VECTORS="$2"
      shift 2
      ;;
    --out)
      OUT="$2"
      shift 2
      ;;
    --verify-determinism)
      VERIFY=1
      shift
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

if [[ -z "$VECTORS" || -z "$OUT" ]]; then
  usage >&2
  exit 1
fi

if [[ ! -f "$VECTORS" ]]; then
  echo "Vector file not found: $VECTORS" >&2
  exit 1
fi

OUT_DIR="$(dirname "$OUT")"
ARTIFACT_DIR="$OUT_DIR/artifacts"
mkdir -p "$OUT_DIR" "$ARTIFACT_DIR"

hash_file() {
  local file="$1"
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$file" | awk '{print $1}'
  else
    openssl dgst -sha256 "$file" | awk '{print $2}'
  fi
}

md_escape_cell() {
  # Escape pipe separators so REQ sets render inside a single Markdown table cell.
  local value="$1"
  value="${value//|/\\|}"
  printf '%s' "$value"
}

generate_report() {
  local target="$1"
  local generated_date
  generated_date="$(date -u +%Y-%m-%d)"

  {
    echo "# RC2 Harness Run Report"
    echo
    echo "- Generated (UTC date): $generated_date"
    echo "- Vector source: $VECTORS"
    echo "- Deterministic ordering: vector_id ascending"
    echo
    echo "| Vector ID | Outcome Class | Expected REQ Pass | Expected REQ Fail | Evidence Artefact Path |"
    echo "|---|---|---|---|---|"

    tail -n +2 "$VECTORS" | LC_ALL=C sort -t, -k1,1 | while IFS=',' read -r vector_id description expected_pass expected_fail; do
      [[ -z "$vector_id" ]] && continue

      local outcome_class
      if [[ "$expected_fail" == "NONE" ]]; then
        outcome_class="PASS_EXPECTED"
      else
        outcome_class="CONTROLLED_FAIL_EXPECTED"
      fi

      local artefact_path="harness/reports/artifacts/${vector_id}.json"
      cat > "$ARTIFACT_DIR/${vector_id}.json" <<ART
{
  "vector_id": "${vector_id}",
  "description": "${description}",
  "expected_req_pass": "${expected_pass}",
  "expected_req_fail": "${expected_fail}",
  "outcome_class": "${outcome_class}"
}
ART

      local expected_pass_md expected_fail_md
      expected_pass_md="$(md_escape_cell "$expected_pass")"
      expected_fail_md="$(md_escape_cell "$expected_fail")"

      echo "| ${vector_id} | ${outcome_class} | ${expected_pass_md} | ${expected_fail_md} | ${artefact_path} |"
    done

    echo
    echo "## Summary"
    local total controlled_fail pass_expected
    total="$(tail -n +2 "$VECTORS" | sed '/^\s*$/d' | wc -l | tr -d ' ')"
    controlled_fail="$(tail -n +2 "$VECTORS" | awk -F',' '$4 != "NONE" {c++} END{print c+0}')"
    pass_expected="$(tail -n +2 "$VECTORS" | awk -F',' '$4 == "NONE" {c++} END{print c+0}')"

    echo "- Total vectors: **${total}**"
    echo "- Pass-expected vectors: **${pass_expected}**"
    echo "- Controlled-fail-expected vectors: **${controlled_fail}**"
  } > "$target"

  {
    echo
    echo "## Deterministic Evidence"
    echo "- Report body digest (SHA-256, pre-signature line): $(hash_file "$target")"
  } >> "$target"
}

generate_report "$OUT"

if [[ "$VERIFY" -eq 1 ]]; then
  TMP_REPORT="$(mktemp)"
  generate_report "$TMP_REPORT"

  DIGEST_A="$(hash_file "$OUT")"
  DIGEST_B="$(hash_file "$TMP_REPORT")"

  if [[ "$DIGEST_A" != "$DIGEST_B" ]]; then
    echo "Determinism check failed: $DIGEST_A != $DIGEST_B" >&2
    rm -f "$TMP_REPORT"
    exit 1
  fi

  rm -f "$TMP_REPORT"

  {
    echo "determinism_check=PASS"
    echo "sha256=$DIGEST_A"
    echo "vectors=$VECTORS"
  } > "$OUT_DIR/rc2-harness-determinism-latest.txt"
fi
