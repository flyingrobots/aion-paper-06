# RC2 Tasks — Paper VI

_Date created: 20 February 2026_  
_Source baseline: RC2 parking list in `RC1_TASKBOARD.md`_

Status marker: `- [ ]` = not started, `- [x]` = hardening complete and execution-locked

## Sequenced Checklist

1. - [x] `P2-08` Micro-appendix anti-patterns + red-team checklist
2. - [x] `P2-01` Observer class taxonomy (`OC0..OC3`)
3. - [x] `P2-02` Replay Impact Label (`RIL`)
4. - [x] `P2-04` Warrant transparency digest
5. - [x] `P2-03` Sovereignty budget controls
6. - [x] `P2-06` Machine-checkable policy DSL snippets
7. - [x] `P2-07` Reference harness for test vectors
8. - [x] `P2-05` Fork governance addendum / emancipation protocol

## First-Pass Evidence Pointers

- Draft body framing: `paper/main.tex` section `RC2 First-Pass Extensions (Draft)`.
- Draft implementation pack: `paper/main.tex` section `Annex G: RC2 First-Pass Extension Pack (Draft)`.
- Priority anti-pattern set (`P2-08`): `paper/main.tex` subsection `P2-08 Micro-appendix anti-patterns + red-team checklist`.

## Hardening Pass 2 Evidence Pointers

- Selected RC2 controls promoted into Annex B `REQ-*`: `REQ-OBS-001`, `REQ-RIL-001..002`, `REQ-SOV-001`, `REQ-WTD-001`, `REQ-FRK-001`, `REQ-DSL-001`, `REQ-TST-003..004`.
- Full-profile RC2 conformance rows added in Annex D for the promoted controls.
- RC2 verification vectors added in Annex E: `TV-012` to `TV-019`.

## Executable Evidence Pointers

- Harness matrix report: `harness/reports/rc2-vector-run-latest.md`
- Harness determinism proof: `harness/reports/rc2-harness-determinism-latest.txt`
- Policy DSL parser report: `harness/reports/rc2-policy-parse-latest.md`
- RC2 traceability/orphan audit: `harness/reports/rc2-traceability-audit-latest.md`
- Per-vector artefacts: `harness/reports/artifacts/TV-012.json` .. `harness/reports/artifacts/TV-019.json`

## Sequence Rationale

- `P2-08` first: delivers immediate misuse resistance and review discipline with low dependency cost.
- `P2-01` and `P2-02` establish shared semantics for downstream governance and enforcement controls.
- `P2-04` and `P2-03` then operationalise transparency and bounded authority using the new labels.
- `P2-06` externalises policy semantics into machine-checkable snippets once terms are stable.
- `P2-07` validates the RC1/RC2 stack in executable form.
- `P2-05` last: constitutional fork/emancipation logic is high-impact and should rely on settled lower-level primitives.

## Advanced Task Descriptions

### `P2-08` Micro-appendix anti-patterns + red-team checklist

- Objective: publish a compact misuse-prevention appendix that highlights likely governance failure modes and operator anti-patterns.
- Scope: add a micro-appendix with named anti-patterns, red-team probes, expected control responses, and evidence artefacts.
- Dependencies: none.
- Primary outputs:
  - New appendix subsection in `paper/main.tex`.
  - Cross-references from relevant control sections.
- Definition of done:
  - At least 8 anti-patterns mapped to `REQ-*` controls.
  - Each anti-pattern has one red-team probe and expected pass/fail evidence.
  - No conflicts with RC1 terminology lock.
- Risks to manage: checklist inflation without operational value.
- Review gate: independent read-through confirms the appendix can drive an actual tabletop exercise.

### `P2-01` Observer class taxonomy (`OC0..OC3`)

- Objective: define a bounded observer taxonomy to classify visibility, authority proximity, and risk of interpretive leakage.
- Scope: specify class definitions (`OC0` to `OC3`), allowed actions, prohibited actions, and escalation triggers.
- Dependencies: `P2-08` (anti-pattern framing informs class boundaries).
- Primary outputs:
  - Taxonomy table and normative definitions in `paper/main.tex`.
  - REQ mappings for each class boundary rule.
- Definition of done:
  - All classes have deterministic classification criteria.
  - Boundary cases are provided for ambiguous observer behaviour.
  - At least one worked example per class references required artefacts.
- Risks to manage: class overlap leading to discretionary interpretation.
- Review gate: no class definition can be interpreted in two mutually inconsistent ways.

### `P2-02` Replay Impact Label (`RIL`)

- Objective: introduce an impact-labelling mechanism that determines replay control strictness and evidence burden.
- Scope: define `RIL` levels, assignment procedure, override constraints, and re-labelling audit requirements.
- Dependencies: `P2-01`.
- Primary outputs:
  - RIL schema table in `paper/main.tex`.
  - Mapping from `RIL` levels to control intensity and required review path.
- Definition of done:
  - Labels are deterministic from stated inputs.
  - Label transitions emit mandatory governance events.
  - No silent downgrades are permitted.
- Risks to manage: gaming labels to reduce governance burden.
- Review gate: red-team attempts to under-label high-impact replay are caught by mandatory checks.

### `P2-04` Warrant transparency digest

- Objective: define a publishable digest model for warrants that improves external verifiability without exposing sensitive internals.
- Scope: specify digest fields, redaction rules, publication cadence, and tamper-evidence linkage.
- Dependencies: `P2-02`.
- Primary outputs:
  - Digest schema and publication protocol text.
  - Evidence model updates for digest-chain verification.
- Definition of done:
  - Digest fields are sufficient for third-party consistency checks.
  - Redaction boundaries are explicit and testable.
  - Publication failures create escalation events.
- Risks to manage: over-redaction (no accountability) or over-disclosure (privacy/security harm).
- Review gate: sample digests can be validated against case artefacts without privileged access.

### `P2-03` Sovereignty budget controls

- Objective: constrain replay authority through budgeted sovereignty envelopes that cap intervention rate, scope, and duration.
- Scope: define budget dimensions, reset rules, emergency extensions, and budget-exhaustion behaviour.
- Dependencies: `P2-02`, `P2-04`.
- Primary outputs:
  - Sovereignty budget model in `paper/main.tex`.
  - Control clauses for enforcement and automatic suspension on budget breach.
- Definition of done:
  - Budgets are machine-evaluable and non-ambiguous.
  - Exhaustion paths are deterministic and auditable.
  - Extension authority is role-bounded with independent review.
- Risks to manage: strategic budget fragmentation and exception abuse.
- Review gate: simulated abuse scenarios cannot sustain indefinite governance override.

### `P2-06` Machine-checkable policy DSL snippets

- Objective: provide machine-checkable snippets for key policy constraints to reduce interpretive drift.
- Scope: define minimal DSL grammar examples for classifier fallback, authority gating, budget enforcement, and evidence emission.
- Dependencies: `P2-01`, `P2-02`, `P2-03`.
- Primary outputs:
  - DSL snippet appendix with line-by-line semantic notes.
  - Mapping between DSL fields and Annex requirement IDs.
- Definition of done:
  - Snippets parse under a declared grammar.
  - Every snippet maps to one or more normative clauses.
  - Contradictory clauses are identified and resolved.
- Risks to manage: pseudo-formal syntax that cannot be executed or validated.
- Review gate: at least one independent parser pass succeeds on every snippet.

### `P2-07` Reference harness for test vectors

- Objective: ship a reference harness that executes RC1/RC2 vectors and reports conformance outcomes reproducibly.
- Scope: implement a lightweight harness for deterministic replay tests, classifier fallback tests, and governance event assertions.
- Dependencies: `P2-06` (preferred), plus RC1 Annex E vectors.
- Primary outputs:
  - Harness scripts and fixtures.
  - Execution report template and failure taxonomy.
- Definition of done:
  - Harness runs all declared vectors with stable pass/fail semantics.
  - Output includes REQ-linked evidence pointers.
  - Negative tests prove no-silent-fallback and degraded-mode bounds still hold.
- Risks to manage: brittle fixtures and environment-specific outcomes.
- Review gate: two fresh runs on clean environments produce equivalent results.

### `P2-05` Fork governance addendum / emancipation protocol

- Objective: define constitutional rules for legitimate governance forks and emancipation when trusteeship fails.
- Scope: specify trigger conditions, quorum requirements, continuity obligations, artefact portability, and anti-coercion safeguards.
- Dependencies: `P2-01` to `P2-04` and `P2-03` should be stable first.
- Primary outputs:
  - Addendum section in `paper/main.tex` with worked fork scenario.
  - Explicit dispute and reconciliation flow with evidence requirements.
- Definition of done:
  - Fork triggers are objective and contestable.
  - Emancipation path preserves audit continuity.
  - Abuse-resistant guardrails prevent unilateral capture.
- Risks to manage: legitimising opportunistic forks or entrenching incumbents.
- Review gate: worked scenario demonstrates both continuity and anti-capture properties.

## Suggested Execution Cadence

- Sprint A: `P2-08`, `P2-01`, `P2-02`
- Sprint B: `P2-04`, `P2-03`
- Sprint C: `P2-06`, `P2-07`
- Sprint D: `P2-05` and integrated consistency pass

## Exit Criteria for RC2 Draft Complete

- [x] All eight `P2-*` tasks marked done.
- [x] Each new operational claim maps to at least one `REQ-*` clause.
- [x] No orphan `REQ-*` entries introduced.
- [x] Worked examples include artefact paths for independent verification.
- [x] Paper builds cleanly with no unresolved structural references.
