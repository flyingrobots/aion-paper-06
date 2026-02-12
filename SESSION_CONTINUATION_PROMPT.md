# New Session Continuation Prompt (Paper VI RC1)

Copy/paste the prompt below into a new session.

---

You are continuing active editorial execution for AIΩN Paper VI in this repository:
`/Users/james/git/aion-paper-06`

## Context you must load first

1. Read `/Users/james/git/aion-paper-06/FEEDBACK_REPORT.md`.
2. Read `/Users/james/git/aion-paper-06/RC1_EXECUTION_PACK.md`.
3. Read `/Users/james/git/aion-paper-06/RC1_TASKBOARD.md`.
4. Read `/Users/james/git/aion-paper-06/paper/main.tex`.
5. Read `/Users/james/git/aion-paper-06/paper/refs.bib`.

## Working mode

- Treat `FEEDBACK_REPORT.md` as the authoritative policy and prioritisation document.
- Treat `RC1_EXECUTION_PACK.md` as the implementation playbook.
- Treat `RC1_TASKBOARD.md` as the execution state; update statuses as work progresses.
- Use UK English.
- Preserve the two-plane architecture:
  - body = governance/normative argument,
  - annexes = enforceable requirements and evidence model.
- Do not introduce RC2 ideas unless needed to close a documented MUST gap.

## Immediate objective

Execute **Day 1** items from the taskboard:
- `R1-01` Freeze canonical thesis sentence (intro + conclusion verbatim).
- `R1-02` Add explicit Paper V → VI continuity bridge paragraph.
- `R1-03` Add scope clause separating runtime governance from legal harmonisation.

## Execution requirements

- Make direct edits to `paper/main.tex`.
- Keep changes minimal and surgical.
- After edits, compile and verify:
  - run `make -j4` from repo root,
  - confirm PDF builds successfully.
- Update `RC1_TASKBOARD.md` statuses:
  - mark completed tasks as `DONE`,
  - move next task to `IN_PROGRESS`.
- Create a daily standup log for today using:
  - `/Users/james/git/aion-paper-06/RC1_DAILY_STANDUP_TEMPLATE.md`
  - save as `/Users/james/git/aion-paper-06/standups/2026-02-12.md` (create folder if missing).

## Deliverable format

Return:
1. concise summary of edits,
2. file paths changed,
3. compile status,
4. updated task statuses,
5. suggested next task (`R1-04` unless blocked).

---

