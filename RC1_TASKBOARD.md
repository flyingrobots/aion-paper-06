# RC1 Taskboard — Paper VI

_Date created: 12 February 2026_  
_Last updated: 12 February 2026_

Status values: `TODO` | `IN_PROGRESS` | `BLOCKED` | `DONE`

## Ownership

- **Primary owner:** James Ross
- **Execution support:** Codex
- **Decision authority:** James Ross

---

## Current Status Snapshot

- **Active sprint day:** Day 1 (Thesis/Scope/Continuity lock)
- **In progress:** `R1-04`
- **Next up:** `R1-05`, `R1-06`
- **Blockers:** None logged
- **RC1 confidence (today):** High (Day 1 lock items completed)

---

## RC1 Master Board

| ID | Priority | Workstream | Task | Owner | Due Date | Status | Dependencies | Acceptance Criteria |
|---|---|---|---|---|---|---|---|---|
| R1-01 | MUST | Structural lock | Freeze canonical thesis sentence (Intro + Conclusion verbatim) | James | 2026-02-12 | DONE | None | Identical thesis string appears in §§1 and 8 |
| R1-02 | MUST | Structural lock | Add explicit Paper V → VI continuity bridge paragraph | James | 2026-02-12 | DONE | R1-01 | Bridge paragraph in intro with Paper V citation |
| R1-03 | MUST | Scope | Add runtime-governance vs legal-jurisdiction boundary clause | James | 2026-02-12 | DONE | R1-01 | Scope section includes legal caveat paragraph |
| R1-04 | MUST | Terminology | Create Terminology Lock Table (canonical + forbidden variants) | James | 2026-02-13 | IN_PROGRESS | R1-01 | Annex contains locked term table |
| R1-05 | MUST | Role model | Expand Subject/Operator/Trustee/Reviewer roles with boundary cases | James | 2026-02-13 | TODO | R1-03 | Role section includes edge cases and constraints |
| R1-06 | SHOULD | Role model | Add authority conflict precedence + timeout/escalation mini-table | James | 2026-02-13 | TODO | R1-05 | Deterministic precedence table present and referenced |
| R1-07 | MUST | Governance integrity | Add anti-capture bootstrap constraints for trustee/arbiter composition | James | 2026-02-13 | TODO | R1-05 | Independence/conflict constraints explicit |
| R1-08 | MUST | Classifier | Add deterministic mind-mode decision logic block | James | 2026-02-14 | TODO | R1-04 | Classifier flow present + REQ links |
| R1-09 | MUST | Classifier | Add No Silent Fallback rule (uncertainty => mind-mode + event) | James | 2026-02-14 | TODO | R1-08 | REQ clause + emitted governance event requirement |
| R1-10 | MUST | Degraded controls | Add bounded degraded-mode duration + checkpoints + auto-suspension | James | 2026-02-14 | TODO | R1-08 | REQ clauses enforce timer/escalation/suspension |
| R1-11 | MUST | Evidence model | Define minimum artefact classes per critical REQ | James | 2026-02-14 | TODO | R1-09 | Annex C table with artifact-class minimum set |
| R1-12 | MUST | Traceability | Add Body→REQ coverage map table | James | 2026-02-15 | TODO | R1-08,R1-11 | Coverage map includes all operational body claims |
| R1-13 | MUST | Cases | Expand 3 failure-oriented cases into worked scenarios + artefacts | James | 2026-02-15 | TODO | R1-12 | Each case has control chain + evidence + residual risk |
| R1-14 | SHOULD | Cases | Insert one early abuse narrative in body (convenience misclassification) | James | 2026-02-15 | TODO | R1-09 | Body includes narrative with REQ prevention chain |
| R1-15 | MUST | Testing | Add mind-mode classification test vector(s) + no-silent-fallback vector | James | 2026-02-16 | TODO | R1-08,R1-09 | Annex E includes explicit pass/fail REQ mappings |
| R1-16 | MUST | Adoption | Add one-page conformance declaration template | James | 2026-02-16 | TODO | R1-11 | Template present and cross-referenced in Conformance section |
| R1-17 | SHOULD | Protocol clarity | Add short worked quorum/warrant example (2-of-3 or 3-of-5) | James | 2026-02-16 | TODO | R1-07 | Example included with message flow and evidence outputs |
| R1-18 | SHOULD | Positioning | Add control-plane architecture figure | James | 2026-02-16 | TODO | R1-12 | Figure inserted and referenced in bridge/operations text |
| R1-19 | MUST | Scholarship | Expand related work and bibliography coverage (incl. Paper V continuity references) | James | 2026-02-17 | TODO | R1-02 | Related work section + meaningful bib growth |
| R1-20 | SHOULD | Positioning hygiene | Structure related work into 3 buckets (governance / provenance / safety-security) | James | 2026-02-17 | TODO | R1-19 | 3-bucket structure visible in prose |
| R1-21 | MUST | Conclusion | Expand conclusion with strongest objection + response + OP-ID backlog | James | 2026-02-17 | TODO | R1-13,R1-19 | Conclusion includes objection handling + OP-IDs |
| R1-22 | MUST | QA | Full consistency pass: terminology, REQ refs, UK English, unresolved refs | James | 2026-02-18 | TODO | R1-04..R1-21 | Build clean enough for RC1 review; no structural ref breaks |
| R1-23 | MUST | Release | RC1 freeze and declaration of included/deferred items | James | 2026-02-18 | TODO | R1-22 | RC1 scope locked with RC2 backlog explicitly parked |

---

## Daily Execution Plan (Week 1)

| Day | Date | Focus | Expected Output |
|---|---|---|---|
| Day 1 | 2026-02-12 | Thesis/scope/continuity lock | R1-01 to R1-03 complete |
| Day 2 | 2026-02-13 | Role model + authority boundaries | R1-04 to R1-07 complete |
| Day 3 | 2026-02-14 | Classifier + degraded-mode controls + artefacts | R1-08 to R1-11 complete |
| Day 4 | 2026-02-15 | Coverage map + worked failure cases | R1-12 to R1-14 complete |
| Day 5 | 2026-02-16 | Test vectors + conformance template + quorum example + figure | R1-15 to R1-18 complete |
| Day 6 | 2026-02-17 | Related work + conclusion hardening | R1-19 to R1-21 complete |
| Day 7 | 2026-02-18 | QA + RC1 freeze | R1-22 to R1-23 complete |

---

## RC2 Parking Lot (Do Not Pull Into RC1 Unless MUST Gap Appears)

| ID | Item | Reason Parked |
|---|---|---|
| P2-01 | Observer class taxonomy (OC0..OC3) | Valuable extension, non-blocking for RC1 |
| P2-02 | Replay Impact Label (RIL) | Needs calibration and abuse-model tuning |
| P2-03 | Sovereignty budget controls | Experimental and gameability-sensitive |
| P2-04 | Warrant transparency digest | Better after baseline deployment semantics settle |
| P2-05 | Fork governance addendum / emancipation protocol | Scope-heavy; requires dedicated treatment |
| P2-06 | Machine-checkable policy DSL snippets | Best as companion artefact |
| P2-07 | Reference harness for test vectors | High value but post-RC1 scope |
| P2-08 | Micro-appendix anti-patterns + red-team checklist | Early RC2 quick win |

---

## Weekly Review Questions

1. Which `MUST` items remain unstarted after Day 3?
2. Are any body claims still missing REQ mappings?
3. Is classifier behaviour deterministic under uncertain evidence?
4. Can degraded-mode persist indefinitely under any path?
5. Can a third party verify conformance using artefacts alone?
