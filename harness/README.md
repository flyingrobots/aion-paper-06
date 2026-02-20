# RC2 Harness Workspace

This directory contains lightweight reference tooling for RC2 conformance evidence generation.

## Components

- `scripts/run_rc2_harness.sh`: emits a deterministic RC2 vector matrix report and per-vector artefact JSON files.
- `scripts/validate_policy_dsl.sh`: validates the RC2 policy DSL snippet and REQ mapping manifest.
- `scripts/audit_rc2_traceability.sh`: audits promoted RC2 requirements for clause/conformance/vector linkage.
- `vectors/rc2_vectors.csv`: RC2 vector expectations (TV-012 to TV-019).
- `policy/RC2_REPLAY_CONTROL.dsl`: machine-checkable policy snippet input.
- `policy/rc2_policy_req_map.csv`: statement-to-REQ mapping manifest.

## Quick Run

```sh
harness/scripts/run_rc2_harness.sh \
  --vectors harness/vectors/rc2_vectors.csv \
  --out harness/reports/rc2-vector-run-latest.md \
  --verify-determinism

harness/scripts/validate_policy_dsl.sh \
  --dsl harness/policy/RC2_REPLAY_CONTROL.dsl \
  --map harness/policy/rc2_policy_req_map.csv \
  --out harness/reports/rc2-policy-parse-latest.md

harness/scripts/audit_rc2_traceability.sh \
  --tex paper/main.tex \
  --out harness/reports/rc2-traceability-audit-latest.md
```

## Evidence Outputs

- `reports/rc2-vector-run-latest.md`
- `reports/rc2-harness-determinism-latest.txt`
- `reports/rc2-policy-parse-latest.md`
- `reports/rc2-traceability-audit-latest.md`
- `reports/artifacts/TV-*.json`
