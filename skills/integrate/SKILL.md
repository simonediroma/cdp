---
name: integrate
description: Integrates demolition cycle resolutions into project-spec.md. Updates the document section by section with explicit confirmation for each change, handles versioning, retires the risks the cycle closed in risk-register.md, and is the only skill that promotes the spec's status (draft → demolished → frozen).
disable-model-invocation: true
allowed-tools: Read, Write, Edit, Glob
---

# Skill: Integrate

## What this skill operates on

`project-spec.md` by default, **or any spec artifact passed as an argument** — a PRD, a UX brief. The `status`
frontmatter is a property of the artifact, not of one filename, and this skill is the only one that writes it.

Two of its phases are **`project-spec.md`-specific and are skipped for anything else**, because they encode that
document's shape and nothing else's:

| Phase | Applies to |
|---|---|
| **2 — Marketing cascades** | `project-spec.md` only: the mapping is between its 11 sections |
| **3 — Out-of-scope → §10** | `project-spec.md` only: other artifacts have their own place for a declared limitation; ask where, don't invent a §10 |

Everything else applies everywhere: folding findings one at a time with confirmation, versioning the frontmatter,
promoting the status, and retiring rows in the register. For a non-spec artifact, fold each change into **its own
structure** — never impose the 11 sections on a document that isn't built from them.

**Writing frontmatter into a document you didn't author** — a PRD from another team, a brief from Confluence — is
a real edit to someone else's file. Show the exact block and confirm before adding it, the same as any other
change here.

## Phase 0 — Prerequisites

**Read all 4 files in parallel (not sequentially):**

- **the target artifact** — `project-spec.md` (frontmatter + all 11 sections) or whatever was passed: needed to apply changes section by section
- `demolition-history.md` — **only the Cycle Log rows for the last cycle**: identifies issues with status `resolved` / `deferred` / `accepted`. If you need to determine the most recent cycle number, read only Summary Metrics first.
- `cdp-memory.md` — **only the Accepted Limitations section**: don't re-propose already out-of-scope issues
- `risk-register.md` — **the open rows whose `Artifact` is the target**, whatever produced them. Rows about other artifacts are not this pass's business. If the file doesn't exist, skip it throughout.

**This skill runs on either source, and needs only one of them.** `/cdp:demolish` and `/cdp:derisk` are
independent — run either, both, in any order, or neither — and integration works from whatever exists:

| What exists | What can be integrated |
|---|---|
| A completed demolition cycle | its `resolved` issues, and its `accepted` ones into §10 |
| Open `risk-register.md` rows, from **either** producer | any finding the user decides to act on now |
| Both | both, in one pass |
| Neither | nothing to integrate — say so and stop |

A finding from `/cdp:derisk` that the user agrees with is a change to make, and waiting for a demolition cycle to
make it would be ceremony. Nor is a cycle required to promote: the status moves on whichever method produced what
was absorbed (Phase 4).

Internally build the list of items to process:
- **to-integrate**: cycle issues with status `resolved` — a user response to translate into a change
- **out-of-scope**: cycle issues with status `accepted` — go into Declared Limitations
- **deferred**: cycle issues with status `deferred` — do not touch now
- **register findings**: open rows the user wants to act on. **Ask which**, showing them ACT NOW first — a row is
  a finding, not yet a decision, and a swept one is a finding nobody has even pushed back on.

## Phase 1 — One-by-One Integration

For each `to-integrate` issue, in order:

1. **Summarize the user's response**: "You said that [response summary]. Is that correct?"
   - Wait for confirmation before proceeding. If the user corrects, update the understanding.

2. **Identify the section**: indicate which section of `project-spec.md` needs updating.

3. **Present the minimal draft**:
   ```
   Section [N] — [Section name]

   ORIGINAL:
   [current text]

   PROPOSED:
   [modified text]

   Apply this change?
   ```

4. **Wait for explicit confirmation before applying.** If the user wants adjustments: modify the proposal and re-present. Never apply without confirmation.

> Non-negotiable rule: no changes without explicit user confirmation.

## Phase 2 — Marketing Cascades

After each applied change, internally verify:

| Change | What it may impact |
|--------|-------------------|
| Audience fit change (section 2) | Message hierarchy (section 5) |
| Repositioning / value proposition (section 4) | Tone of voice (section 6), Channels (section 7) |
| Message hierarchy / claim change (section 5) | Competitive positioning (section 8) |
| Redefined objective (section 3) | Value proposition (section 4), Objective-gap |

If you identify a cascading impact: flag it to the user before moving to the next issue.

```
This change also impacts [section X]. Do you want to update that now,
or leave it for a future cycle?
```

## Phase 3 — Out-of-Scope

For each `out-of-scope` issue (accepted as a limitation):

Propose the text to add to section **10. Declared Limitations**:

```
Adding this declared limitation:

"[Text describing the limit, its scope, and the reason it is out-of-scope]"

Confirm?
```

Wait for confirmation before writing. Adapt the text if the user requests it.

## Phase 4 — Versioning and status

### The version

After all confirmed changes have been applied, pick the increment:

- **`project-spec.md`** — **MINOR** (`v1.0 → v1.1`) for tactical changes: tone, claims, message hierarchy,
  channels, constraints. **MAJOR** (`v1.x → v2.0`) for strategic ones: objective (§3), primary audience (§2),
  value proposition (§4). Both kinds in one pass → MAJOR.
- **Any other artifact** — MAJOR if the change alters what the document is *for* (its objective, its scope, its
  primary user); MINOR otherwise. When that isn't obvious, ask in one line with your guess in it.

### The frontmatter — honest counters

Write only what actually happened. Two blocks, depending on the target:

**`project-spec.md`:**

```yaml
version: [new version]
status: [see "The status transition" below]
last_demolition_cycle: [today — ONLY if this pass integrated a demolition cycle; otherwise unchanged]
demolition_cycles_count: [+1 ONLY if this pass integrated a demolition cycle; otherwise unchanged]
version_history:
  - version: [new version]
    date: [today]
    hardening: cycle | sweep | both      # what this pass absorbed; omit if it absorbed no findings
    notes: "[one-line summary of main changes]"
  [previous entries...]
```

**Any other artifact** (a PRD, a brief) gets the **minimal block** — no demolition fields, ever:

```yaml
version: [new version]
status: [see below]
version_history:
  - version: [new version]
    date: [today]
    hardening: cycle | sweep | both
    notes: "[one-line summary]"
```

Two reasons the minimal block matters, and neither is tidiness. A counter that increments when no demolition
happened is a lie the next reader will believe. And `demolition_cycles_count` has historically been read as a
sign that a document *is* `project-spec.md` — the mode detection has since been moved to content, but a PRD
carrying that field would still read as something it isn't.

**The `hardening` field is the record of work.** It is what the freeze reads (check 2 below), and it is why the
freeze no longer has to infer anything from how many rows the register happens to contain.

### The status transition — who writes it

`status` moves `draft (unhardened)` → `hardened` → `frozen`. Two paths write it, and they are deliberately
different in kind:

| Path | Who | Checks | Recorded as |
|---|---|---|---|
| **Promotion** | this skill | the ones below | `hardening: cycle \| sweep \| both` |
| **Operator shortcut** | `spec-to-ux`, `spec-to-code`, `spec-to-design`, when the status is absent and the operator answers their question | none — it's a declaration | `hardening: declared`, naming the skill |

The shortcut exists on purpose: an operator who knows a document is ready shouldn't have to run a pass to say
so, and it can declare **either** `hardened` **or** `frozen` directly — a document with no status at all can go
straight to `frozen` (the S0→S3 path) without ever coming through this skill. What keeps it honest is that it is
**recorded as what it is**. A reader can always tell a status that was earned from one that was declared.

Check 2 below governs only **this skill's own promotion** from `hardened` to `frozen` — it says a declaration
alone doesn't satisfy *that* precondition. It does not reach the shortcut's S0→S3 path, which was never a
promotion this skill performed in the first place.

`/cdp:onboarding` writes the first value and never advances it. Neither `/cdp:demolish` nor `/cdp:derisk` writes
status: one attacks, the other sweeps, and **finding is not absorbing** — the absorbing happens here, with the
user confirming each change. The one exception belongs to them, not to this skill: a **new `ACT NOW` risk
confirmed against an already-`frozen` document** reopens it to `hardened` on the spot, written by whichever of
them found it — see "Reopening" below. A **proposed** ACT NOW that the operator hasn't confirmed yet does not
reopen anything — it only blocks a later freeze (check 3), which is a narrower thing than undoing one already
granted.

- **→ `hardened`**: automatic, once this pass's confirmed changes are applied — **whichever method produced
  them**. Write `hardening:` with what was absorbed. If the pass folded nothing, promote nothing and say so.

- **Reopening `frozen` → `hardened`**: if the document arrives at this pass already `frozen` and any change gets
  confirmed and applied to its text (Phase 1), that text is no longer what was frozen — set status back to
  `hardened` rather than leaving it `frozen`, and say so plainly in the final report. Write a `version_history`
  entry recording the reopening (cause: "text modified via /cdp:integrate", date) alongside the normal version
  bump for the change itself. A pass that touches a `frozen` document but confirms no change leaves it `frozen`.

- **→ `frozen`**: never automatic, and **never skipping a state**. All three must hold, in this order:

  1. **The current status is `hardened`** — evaluated *after* this pass's promotion, so a pass that absorbs
     findings may promote and then offer the freeze in one go. What it can't do is freeze a document still at
     `draft (unhardened)`, i.e. one this pass absorbed nothing for.
  2. **`version_history` records at least one integrated hardening pass** — an entry with `hardening: cycle`,
     `sweep` or `both`. A status reached only by `hardening: declared` does not satisfy this: the operator said
     it was ready, and this skill's job is to check, not to countersign. **This check applies only to promoting a
     `hardened` document to `frozen` through this skill.** It has no bearing on the operator shortcut reaching
     `frozen` directly from no status at all (S0→S3) — that is a declaration made and recorded elsewhere, and a
     deliberate exception, not a gap in this one.
  3. **No row in `risk-register.md` whose `Artifact` is this document is `open` with `Triage confirmed: ACT
     NOW`, and no row for this document is `open` with `Triage proposed: ACT NOW` and `Triage confirmed` still
     blank.** The second half matters as much as the first: a proposal nobody has confirmed or changed yet is
     **pending**, not settled, and blocks the freeze exactly like a confirmed ACT NOW. If you find one, don't
     offer the freeze — ask the operator to confirm, change, or downgrade it first; that's a different action
     from the override below, which is for a risk everyone agrees is still ACT NOW. Rows about other artifacts
     never block this one.

  > **Absence is still not cleanliness — but it is now read from the right place.** Check 2 used to infer the
  > work from the register's rows, which failed both ways: a register nobody wrote read as clean, and a perfect
  > cycle — every criticism resolved, so no rows written — read as nothing done. The work is now a recorded fact
  > in `version_history`. A register with zero rows for this document, after a recorded pass, genuinely means
  > nothing dangerous is left.

  With all three satisfied:

  ```
  Hardening integrated ([cycle | sweep | both]) and no ACT NOW risks open on this document.
  Freeze it at v[X.X]? A frozen spec is what spec-to-code and spec-to-design expect;
  it can be reopened by running another pass.
  ```

  **When a check fails, don't offer the freeze** — say which one, because they mean different things:

  ```
  # check 1
  This is `draft (unhardened)` — nothing has been surfaced and absorbed yet. It goes to
  `hardened` first, by integrating a sweep or a cycle; only a later pass can freeze it.

  # check 2
  The status was declared by the operator (via /cdp:[skill]), not reached through an
  integrated pass. Declaring it was your call and it stands for the downstream skills —
  but I don't freeze on a declaration. Run /cdp:derisk or /cdp:demolish, then integrate.

  # check 3 — confirmed
  [N] ACT NOW risk(s) confirmed and open on this document — R[n]: [risk, in one line]. It
  stays `hardened`. Freezing now means building on an unsettled risk; if you want that
  anyway, say so explicitly and I'll record the override.

  # check 3 — pending
  R[n]: [risk, in one line] was proposed ACT NOW by [/cdp:derisk | /cdp:demolish] and
  hasn't been confirmed, changed, or downgraded yet. It stays `hardened` until it is — run
  that skill again so it can record your answer against its own row. A pending proposal
  isn't something to override; it's something nobody has looked at yet.
  ```

  **This skill never writes `Triage confirmed` itself.** `risk-register.md`'s own rule is "never rewrite a row
  you didn't add" — a pending row belongs to whichever of `/cdp:derisk` or `/cdp:demolish` proposed it, and only
  that skill resolves it, the next time it runs against this document. This skill's part is only to ask, to
  block on the answer, and to re-read the row once it comes back confirmed.

  **Only a confirmed check-3 failure can be overridden here.** A pending proposal cannot — there is nothing to
  override, only a decision to make first; once the operator confirms, changes, or downgrades it, the pass
  re-reads check 3 as usual. Checks 1 and 2 say the work hasn't happened, and this skill doesn't pretend
  otherwise — an operator who wants to skip them has the shortcut, which records itself as exactly that.
  If the user overrides a confirmed check-3 failure, set `frozen` and write the override into the register's
  **Act now** section, naming the risks that were open at the freeze.

**Verdict.** Update this document's row in the register's **Verdict** table: `rework` if a severe ACT NOW is open,
`proceed-with-tests` if ACT NOW risks are open with tests named, `proceed` if none are. Other documents' verdicts
are theirs.

## Phase 5 — Memory Update

1. **`demolition-history.md`**: update issues from `resolved` to `integrated`. Update Summary Metrics (increment `Issues integrated`).

2. **`risk-register.md`** — retire what this pass closed, **on this document's rows only**. For every open row
   whose underlying issue or finding was integrated or accepted in this pass:
   - **Integrated** → status becomes `retired · [date]`, move the row to **Retired** with one line on what closed
     it. Never delete it: a risk that comes back matters more than one that never appeared, and this is the only
     place that would show it.
   - **Accepted as a declared limitation** → status becomes `accepted · [date]`, move it to **Track**. A limitation
     is a deliberate exposure, and deliberate is not harmless — its mitigation is the declaration itself.
   - **Untouched by this pass** → leave it exactly as it was. A risk carried across three passes should look like
     one.

   Then update this document's row in the **Verdict** table and re-sort **Act now** by severity × probability.

3. **`cdp-memory.md`**:
   - Add any redefined terms to the Defined Terms table
   - Mark as resolved any Open Promises satisfied by this cycle
   - **Route the durable facts back to § Brand Facts.** A demolition cycle sometimes settles something that isn't
     about this campaign at all — a claim the brand can never defend, a constraint that holds whatever the
     objective is, a competitor comparison that turned out to be structural. Apply both tests: it doesn't depend
     on this campaign, **and** another campaign on this brand would need it again. Propose the exact rows and
     **write only what the user confirms** — status `draft`, source `interview`. Where a fact contradicts an
     existing row, mark the old one `superseded (date)` naming what replaced it rather than adding a second.
     Keep the filter tight; most resolutions are campaign-bound and belong in the spec alone.
   - Add row to the Session Log:
     ```
     | [date] | Integrated N issues from cycle [N], spec updated to v[X.X] | [next step] |
     ```

At the end:

```
project-spec.md updated to v[X.X] — status: [unchanged | hardened | frozen]

Changes applied: [N]
Declared limitations added: [N]
Deferred issues still open: [N]
Risks retired: [N] · still open: [N] ([N] ACT NOW)
[if nothing was promoted] Status unchanged — this pass folded findings, which is not a demolition cycle.

Use /cdp:demolish for the next cycle or /cdp:resume to reload context.
```
