#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<USAGE
Usage: $(basename "$0") --dsl <policy.dsl> --map <req_map.csv> --out <report.md>
USAGE
}

DSL=""
MAP=""
OUT=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dsl)
      DSL="$2"
      shift 2
      ;;
    --map)
      MAP="$2"
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

if [[ -z "$DSL" || -z "$MAP" || -z "$OUT" ]]; then
  usage >&2
  exit 1
fi

if [[ ! -f "$DSL" ]]; then
  echo "DSL file not found: $DSL" >&2
  exit 1
fi

if [[ ! -f "$MAP" ]]; then
  echo "REQ map not found: $MAP" >&2
  exit 1
fi

mkdir -p "$(dirname "$OUT")"

readarray -t actual_lines < <(sed -e 's/[[:space:]]\+$//' "$DSL" | sed '/^\s*$/d' | sed '/^\s*#/d')
expected_lines=(
  "policy RC2_REPLAY_CONTROL"
  "classify mode using indicators"
  "when evidence.incomplete or evidence.inconsistent"
  "set mode = MIND_MODE"
  "emit event CLASSIFIER_INCOMPLETE"
  "end_when"
  "require authority.explicit when mode == MIND_MODE"
  "enforce budget.temporal <= warrant.max_duration"
  "on budget.exhausted -> suspend replay and open dispute"
  "end_policy"
)

syntax_ok=1
syntax_notes=()

if [[ "${#actual_lines[@]}" -ne "${#expected_lines[@]}" ]]; then
  syntax_ok=0
  syntax_notes+=("Line count mismatch: expected ${#expected_lines[@]}, got ${#actual_lines[@]}")
else
  for i in "${!expected_lines[@]}"; do
    if [[ "${actual_lines[$i]}" != "${expected_lines[$i]}" ]]; then
      syntax_ok=0
      syntax_notes+=("Line $((i + 1)) mismatch: expected '${expected_lines[$i]}', got '${actual_lines[$i]}'")
    fi
  done
fi

required_req_ids=("REQ-THS-002" "REQ-THS-003" "REQ-AUT-001" "REQ-SOV-001" "REQ-LOG-001")
map_ok=1
for req in "${required_req_ids[@]}"; do
  if ! rg -q "${req}" "$MAP"; then
    map_ok=0
  fi
done

overall="PASS"
if [[ "$syntax_ok" -ne 1 || "$map_ok" -ne 1 ]]; then
  overall="FAIL"
fi

{
  echo "# RC2 Policy DSL Validation Report"
  echo
  echo "- DSL input: \`$DSL\`"
  echo "- Mapping input: \`$MAP\`"
  echo "- Validation result: **$overall**"
  echo
  echo "## Syntax Check"
  if [[ "$syntax_ok" -eq 1 ]]; then
    echo "- Status: PASS"
    echo "- All policy statements match expected grammar lines."
  else
    echo "- Status: FAIL"
    for note in "${syntax_notes[@]}"; do
      echo "- ${note}"
    done
  fi
  echo
  echo "## REQ Mapping Check"
  if [[ "$map_ok" -eq 1 ]]; then
    echo "- Status: PASS"
    echo "- Required REQ IDs present: ${required_req_ids[*]}"
  else
    echo "- Status: FAIL"
    echo "- One or more required REQ IDs are missing from mapping file."
  fi
} > "$OUT"

if [[ "$overall" != "PASS" ]]; then
  exit 1
fi
