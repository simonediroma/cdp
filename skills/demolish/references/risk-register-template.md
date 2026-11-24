# Risk Register — [project name]

One register per project, covering **every artifact** that has been swept or attacked — `project-spec.md`, a
PRD, a brief. Each row names the artifact it is about, and each artifact has its own verdict: a risk on the PRD
never blocks or colours the spec, and vice versa.

## Verdict

| Artifact | Verdict | Date |
|---|---|---|

One row per artifact, added by the first skill that sets a verdict for it. Verdict is `proceed` ·
`proceed-with-tests` · `rework`; for a given artifact the last writer wins, and the date says which is current.

> **What this file is for.** `demolition-history.md` records *what was attacked*. This records *what is still
> dangerous*, and what would cheaply settle it. An issue that survived a cycle by being deferred is not closed —
> it is an open risk with nobody assigned to it, and this is where it stops being invisible.
>
> **Two skills write here, and they find different things.** `/cdp:derisk` sweeps every lens mechanically in one
> pass — breadth, including lenses no persona would pick — and nobody has pushed back on any of it.
> `/cdp:demolish` attacks one criticism at a time and makes the author defend it — depth. `/cdp:integrate`
> retires what a pass closed. Never start a second file, and never rewrite a row you didn't add.
>
> **The register is about the risks, not about how it was written.** No list of documents read, no narration of
> the cycle. The **Basis** is the exception, and it is content: it is what separates a risk from an opinion.

## The principal risk

One paragraph: the single biggest thing that can make this fail, said plainly. If the register has one line
someone should read before the table, it is this one.

## Risks

| # | Artifact | Category | Risk | Sev | Prob | Basis | Triage proposed | Triage confirmed | Cheapest test | Status |
|---|---|---|---|---|---|---|---|---|---|---|

**The table starts empty.** No example row, not even inside a comment: skills read this file's source, not its
rendering, so a commented example with triage ACT NOW would read as a real open risk and block the freeze of
whatever document it names. A row has eleven cells, in the column order above — for instance: R1 · project-spec.md
· claim · *what could be wrong, in one line* · H · M · *the fact it rests on* · ACT NOW · ACT NOW · *what would
settle it* · open · cycle 1.

An empty table is a legitimate state: after a pass recorded in the artifact's `version_history`, it means nothing
dangerous is left. It is **not** evidence that anyone looked — that evidence lives in `version_history`, never here.

**Columns.**

- **Artifact** — the document the risk is about, by path: `project-spec.md`, `docs/checkout-prd.md`. Every check
  that reads this file — the freeze, a verdict, `/cdp:ticket`'s match — filters by it. This is the "documento di
  riferimento" every row carries; there is no separate column for it.

- **Category** — for a BRAND spec, one of `demolish`'s seven: `audience-fit` · `claim` · `differentiation` ·
  `hierarchy` · `channel` · `tone` · `objective-gap`. For a PRODUCT spec, name the dimension plainly
  (feasibility, usability, viability, compliance, …).
- **Sev / Prob** — H / M / L. Severity is how bad it is if true; probability is how likely it is true.
- **Basis** — the fact the risk rests on: a datum, a constraint, the absence of evidence. Where no basis exists,
  write `[ASSUMPTION]` — and where the *missing* thing is what makes it risky, **that absence is the risk**, not
  a disclaimer about the register.
- **Triage proposed / Triage confirmed** — `ACT NOW` (retire before building), `MONITOR` (stays open, with a
  signal that would escalate it), or `ACCEPT` (accepted and closed, with a mandatory reason). The skill that
  found the risk — `/cdp:derisk` or `/cdp:demolish` — proposes the tier; the operator confirms it or changes it.
  When they're identical, write the same value twice rather than collapsing them, so a reader can tell at a
  glance that every row passed through a confirmation, not just an algorithm. When they differ, it's almost
  always a **downgrade from a proposed ACT NOW**, and that downgrade's reason and date belong in "Declassamenti"
  below, not squeezed into this cell.

  **`Triage confirmed` can be left blank — that row is `in sospeso` (pending).** If the operator hasn't
  responded to a proposal yet — reviewing a long sweep in batches, a session that ends before going through every
  row — write the row anyway with `Triage proposed` filled and `Triage confirmed` empty, rather than holding it
  back. A pending `ACT NOW` **blocks the freeze exactly like a confirmed one** (check 3 in `/cdp:integrate`
  reads both), but it does **not** reopen an already-`frozen` document — reopening needs an explicit confirmed
  `ACT NOW`, per the reopening rule in `/cdp:derisk` and `/cdp:demolish`. The row stops being pending the moment
  the operator confirms, changes, or downgrades it — never on its own.
- **Cheapest test** — the least expensive thing that would prove the risk real or dead. Not a plan, a probe.
- **Status** — this is also where the risk's **origin** lives (`sweep` vs `cycle`), and the difference between
  the first two is **content, not bookkeeping**:
  - `open · sweep N` — found by `/cdp:derisk`. **Nobody has pushed back on it yet.**
  - `open · cycle N` — raised in a demolition cycle: either it survived somebody trying to argue it away
    (`deferred`), or it was mapped and the cycle ended before reaching it (basis `[not yet attacked]`).
  - `retired · [date]` — an integration pass closed it. Kept, never deleted: a risk that comes back matters more
    than one that never appeared.
  - `accepted · cycle N` / `accepted · [date]` — the confirmed triage was `ACCEPT`; stamped with the date once
    integration writes it down. Deliberate is not the same as harmless.

  A reader deciding what to worry about needs to know which of these they are looking at.

## Act now

The `ACT NOW` subset (confirmed triage), ordered by severity × probability, each with its test and an owner.
**These block the freeze.** A spec cannot go to `frozen` with an open ACT NOW risk unless the user overrides
explicitly, and the override is recorded here.

## Monitor

Risks being monitored rather than retired or accepted (confirmed triage `MONITOR`). Each carries the **signal or
threshold** that would move it to ACT NOW — without that, it is not being monitored, it is being ignored.

## Accepted

Risks whose confirmed triage is `ACCEPT` — closed deliberately, each with its mandatory reason. A limitation
declared in §10 of the spec lands here too: a deliberate exposure, and deliberate is not the same as harmless.
Its mitigation is the reason recorded here.

## Declassamenti

Every row where the confirmed triage came in **below** the proposed one — most often ACT NOW proposed, something
milder confirmed. One line each: row #, date, proposed → confirmed, the operator's reason. This is a different
trace from a freeze-time override (recorded in "Act now" above, written by `/cdp:integrate`'s check 3): there,
an ACT NOW risk stays open and the freeze happens anyway; here, the risk itself was judged not to rise to ACT
NOW at all. Keep the two distinguishable — they answer different questions about what happened.

## Retired

Risks a cycle closed, kept with the cycle number and one line on what closed them. Short, and never deleted — a
risk that comes back matters more than one that never appeared, and this is the only place that shows it.

---

**Length.** Ten real risks beat thirty plausible ones. A line that changes no decision and carries no test is a
comment, not a risk — cut it.
