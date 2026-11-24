# 06 — SPIKE PENDING Macros

Course 2 mentioned spikes in passing — a macro gets marked `⏳ SPIKE PENDING` instead of getting a full implementation prompt when there's genuinely not enough information to write one. In FEATURE-ADDITION work, spikes stop being an edge case and start being routine: you're touching a system someone else's decisions already shaped, and some of those decisions were never written down.

## What actually triggers a spike

From the decomposition rules, a macro gets marked pending when any of these are true:

- The contract of an API or system to integrate is genuinely unknown
- A technological choice (library, pattern, schema) hasn't been made yet
- The macro depends on a decision from another team that hasn't happened
- The PRD explicitly says "TBD" on something that blocks the macro
- **FEATURE-ADDITION specific:** the macro needs to touch a module `architecture-context.md` doesn't describe, or depends on undocumented current system behavior

The instinct to resist here is guessing. A spike exists precisely so nobody writes a plausible-sounding implementation prompt against an assumption that turns out to be wrong three macros later.

## The stub file

Every spike produces `docs/spike-M<N>.md`, pre-filled with everything already known:

```markdown
# Spike M<N> — <Macro Title>

**Status:** OPEN
**Macro blocked:** M<N> — <macro title>

## Open question
<exactly what's unknown and why it blocks the prompt>

## Why it blocks M<N>
<the specific part that can't be written without this>

## Hypotheses to verify
- <hypothesis #1>
- <hypothesis #2>

## Expected output (fill in after investigation)
**Status:** OPEN → RESOLVED when complete
**Decision made:** [TO BE FILLED BY INVESTIGATOR]
**Discarded alternative:** [TO BE FILLED BY INVESTIGATOR]
**Technical constraints discovered:** [TO BE FILLED BY INVESTIGATOR]
**Files and patterns found:** [TO BE FILLED BY INVESTIGATOR]
**New acceptance criteria (if emerged):** [TO BE FILLED BY INVESTIGATOR]
**Impact on other macros:** [TO BE FILLED BY INVESTIGATOR]
```

## What "resolving" a spike actually means

Doing the investigation — reading the real code, testing the real API, confirming the real constraint — and filling in the "Expected output" section with a single clear decision, what was discarded and why, what was actually discovered, and what it changes elsewhere. `Status` flips from `OPEN` to `RESOLVED` only once that's genuinely filled in, not just touched.

## Where Jira fits, if you use it

If a Jira MCP connection is available, `/cdp:spec-to-code` offers to create a Spike ticket alongside the stub file — timeboxed, linked to the epic, carrying the same open question and hypotheses. The stub file is the primary artifact either way; Jira is optional tracking on top of it, never a replacement for it.

## Check your understanding

- What's the difference between a spike triggered by an unknown API contract and one triggered by the FEATURE-ADDITION-specific condition?
- What has to be true of the "Expected output" section before a spike is actually considered resolved, not just started?

*Next: [07 — `/cdp:spike-integrate`](07-spike-integrate.md).*
