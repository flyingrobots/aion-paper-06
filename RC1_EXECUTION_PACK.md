# RC1 Execution Pack — Paper VI

_Date: 12 February 2026_

This pack is the implementation companion for the RC1 roadmap. It is intentionally operational and edit-ready.

---

## 1) Section-by-Section Edit Checklist

Use this checklist in order. Do not start prose polishing until sections marked “Control lock” are complete.

## Section 1 — Introduction and Thesis
- [ ] Insert canonical thesis sentence and freeze wording.
- [ ] Ensure thesis includes authority, bounded override, and contestable evidence.
- [ ] Add explicit bridge sentence from Paper V to Paper VI.
- [ ] Reuse the exact thesis sentence in Conclusion.

## Section 2 — Scope and Explicit Non-Scope
- [ ] Add explicit runtime-governance vs legal-jurisdiction boundary paragraph.
- [ ] Confirm metaphysics remains out of normative scope.
- [ ] Add statement that legal harmonisation is external mapping.

## Section 3 — Constitutional Principles for Replay Governance
- [ ] Ensure each operational claim cites at least one REQ ID.
- [ ] Add one early abuse narrative (convenience misclassification).
- [ ] Add classifier cross-reference to Annex B.
- [ ] Confirm no mechanism-level pseudocode appears outside designated classifier block.

## Section 4 — Role Model and Authority Boundaries
- [ ] Expand Subject / Operator / Trustee / Reviewer-Arbiter roles with concrete boundary cases.
- [ ] Add conflict case handling (e.g., Subject disagrees with Operator).
- [ ] Add authority precedence mini-table with escalation and timeout behaviour.
- [ ] Add anti-capture constraints (independence, conflict disclosures).

## Section 5 — Conformance Model (Baseline / Full)
- [ ] Ensure Baseline and Full requirements are explicit and non-overlapping.
- [ ] Add one-page declaration cross-reference (template in this pack).
- [ ] Add “No Silent Fallback” requirement reference.

## Section 6 — Bridge: Principle → Enforcement
- [ ] Add section-to-REQ coverage map table (template below).
- [ ] Confirm each bridge row includes enforcement point, artefact, and failure mode.
- [ ] Validate all cited REQ IDs exist and resolve.

## Section 7 — Failure-Oriented Cases
- [ ] Expand each case to include input context, control chain, artefacts emitted, residual risks.
- [ ] Include one safety-abuse case and one sovereignty-abuse case explicitly.
- [ ] Add explicit pass/fail REQ coverage references.

## Section 8 — Conclusion
- [ ] Repeat canonical thesis sentence verbatim.
- [ ] Add strongest objection and response.
- [ ] Add OP-ID backlog handoff to Paper VII.

## Annex A — Normative Definitions
- [ ] Add Terminology Lock Table (canonical terms + forbidden variants).
- [ ] Ensure all role and key control terms are defined exactly once.

## Annex B — Requirement Clauses (REQ-*)
- [ ] Add classifier requirement with default-to-mind-mode fallback on uncertainty.
- [ ] Add degraded-mode duration, checkpoint, and auto-suspension clauses.
- [ ] Ensure each REQ has owner role, control, evidence, failure mode.

## Annex C — Controls and Evidence Artefacts
- [ ] Add minimum artefact class set per critical REQ.
- [ ] Confirm artefact names are reused consistently in cases and conformance declaration.

## Annex D — Conformance Profiles
- [ ] Ensure Baseline/Full matrix includes review cadence and artefact requirements.
- [ ] Add conformance declaration reference and checklist mapping.

## Annex E — Test Vectors
- [ ] Add at least one mind-mode classification test vector.
- [ ] Add explicit no-silent-fallback test vector.
- [ ] Ensure each test vector references expected pass/fail REQ IDs.

## Annex F — Machine-Readable Requirement Index
- [ ] Ensure terminology lock terms are reflected in machine-readable schema fields.
- [ ] Validate IDs and profile flags for Baseline/Full.

---

## 2) Coverage-Map Template Table (Body → REQ)

Use this in Section 6 (or immediately after it) as the authoritative traceability map.

| Body Section | Constitutional Claim | REQ IDs | Owner Role(s) | Enforcement Point | Required Evidence Artefact(s) | Failure Mode | Status |
|---|---|---|---|---|---|---|---|
| §3.x | _Claim text_ | REQ-XXX-001, REQ-YYY-002 | Subject/Operator/... | _Control gate_ | _Signed decision + policy hash_ | _Silent override_ | Draft/Locked |
| §4.x | _Claim text_ | REQ-XXX-00n | ... | ... | ... | ... | ... |
| §5.x | _Claim text_ | REQ-CNF-... | ... | ... | ... | ... | ... |

Rules:
- Every operational claim in body must appear at least once.
- No REQ in Annex B should be orphaned from all body claims.
- Status becomes `Locked` only when prose, REQ text, and test vector all align.

---

## 3) Mind-Mode Classifier Pseudocode (Deterministic + No Silent Fallback)

```text
function classify_mode(request_context, subject_profile, runtime_state):
    indicators = evaluate_mind_mode_indicators(subject_profile, runtime_state)
    evidence = collect_classifier_evidence(indicators, request_context)

    if evidence.is_incomplete or evidence.is_inconsistent:
        emit_governance_event("CLASSIFIER_INCOMPLETE", request_context, evidence)
        return MIND_MODE, "PRECAUTION_NO_SILENT_FALLBACK"

    if indicators.any_true:
        return MIND_MODE, "INDICATOR_TRIGGERED"

    return SYSTEM_MODE, "NO_INDICATOR_TRIGGERED"

function authorise_replay(request):
    mode, reason = classify_mode(request.context, request.subject, request.runtime)

    if mode == MIND_MODE:
        require_explicit_authority(request)
        require_subject_consent_or_mandate(request)
        enforce_scope_bounds(request)
        record_signed_decision(request, mode, reason)
        return proceed_or_deny_by_policy(request)

    # system mode
    record_signed_decision(request, mode, reason)
    return proceed_or_deny_by_policy(request)
```

Normative notes:
- Classifier uncertainty MUST NOT degrade silently to system-mode.
- Any fallback to precautionary mind-mode MUST emit a governance event.
- Reclassification MUST produce a new signed decision artefact and policy-hash linkage.

---

## 4) Degraded-Mode Enforcement Clause Text (Ready to Adapt into Annex B)

Use as starting language for REQ clauses.

### REQ-OVR-004 (Degraded Mode Bound)
**Clause:** Degraded-mode replay MUST be time-bounded by a declared maximum duration and MUST include milestone checkpoints for recovery/migration.

**Owner role:** Operator, Trustee

**Control:** Degraded-mode timer + checkpoint scheduler + automatic deadline enforcement

**Evidence artefact:** Degraded-mode warrant, start timestamp, checkpoint records, migration-plan digest

**Failure mode:** Indefinite degraded operation treated as routine

---

### REQ-OVR-005 (Degraded Mode Escalation)
**Clause:** If degraded-mode duration exceeds the declared bound or checkpoint obligations are missed, the system MUST auto-suspend mind-mode replay and MUST trigger independent review escalation.

**Owner role:** Trustee, Reviewer/Arbiter

**Control:** Deadline monitor + auto-suspension gate + dispute trigger

**Evidence artefact:** Suspension event record, escalation ticket, arbiter intake packet

**Failure mode:** Temporary degraded state becoming permanent override channel

---

### REQ-LOG-004 (Degraded Mode Traceability)
**Clause:** Every degraded-mode decision and transition MUST be linked to policy hash, authority source, and review outcome in tamper-evident logs.

**Owner role:** Operator, Auditor

**Control:** Append-only degraded-mode event chain

**Evidence artefact:** Log digest with policy linkage and review correlation IDs

**Failure mode:** Non-attributable degraded-mode governance actions

---

## 5) One-Page Conformance Declaration Template

Use this as a signed deployment declaration for Baseline or Full claims.

## Paper VI Conformance Declaration

**System name:** __________________________

**Version / build:** ______________________

**Deployment environment:** _______________

**Declaration date:** _____________________

**Declaring authority (name/role):** ______

### Profile Claim
- [ ] Baseline
- [ ] Full

### Claim Matrix

| Requirement Set | Claimed | Implemented | Evidenced | Evidence Location |
|---|---:|---:|---:|---|
| REQ-THS-* | [ ] | [ ] | [ ] | __________________ |
| REQ-RAC-* | [ ] | [ ] | [ ] | __________________ |
| REQ-AUT-* | [ ] | [ ] | [ ] | __________________ |
| REQ-OVR-* | [ ] | [ ] | [ ] | __________________ |
| REQ-LOG-* | [ ] | [ ] | [ ] | __________________ |
| REQ-DSP-* | [ ] | [ ] | [ ] | __________________ |
| REQ-EVD-* | [ ] | [ ] | [ ] | __________________ |
| REQ-CNF-* | [ ] | [ ] | [ ] | __________________ |
| REQ-TST-* | [ ] | [ ] | [ ] | __________________ |

### Mandatory Assertions
- [ ] No-silent-fallback classifier behaviour is enforced.
- [ ] Degraded-mode maximum duration and checkpoint policy are configured.
- [ ] Independent review path is available and testable.
- [ ] Evidence artefact minimum set is complete for all critical controls.

### Exceptions / Residual Risks
____________________________________________________________
____________________________________________________________

### Sign-Off

**Operator signatory:** ____________________  Date: __________

**Trustee signatory:** _____________________  Date: __________

**Auditor acknowledgement:** _______________  Date: __________

---

## Usage Note

This pack is a drafting and control tool, not part of final reader-facing prose by default. Components may be lifted into Annexes and companion governance artefacts as needed.
