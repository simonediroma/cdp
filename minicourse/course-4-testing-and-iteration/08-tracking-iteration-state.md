# 08 — Tracking Iteration State

🎬 Video: [`video-prompts.md#08-tracking-iteration-state`](video-prompts.md#08-tracking-iteration-state)

---

A bugfix that spans more than one sitting has the same memory problem Course 3 Lesson 08 described for feature work — except worse, because a half-finished bug investigation is easy to forget the specifics of precisely when it matters most. `CLAUDE_MEMORY.md` (or `.cursor/rules/02-memory.mdc`) is where this gets tracked, using the same file you already have, not a new one.

## What to actually write down

For each bug in progress, the memory file's existing sections carry everything you need:

- **Decisions made** — the CLAIM you settled on (Lesson 07), the severity you triaged (Lesson 03), whether this turned out to be a missed spike (Lesson 05) rather than an ordinary bug
- **Blockers** — the specific doubt you haven't yet been able to confirm or rule out; a reproduction you can't yet trigger reliably
- **Next session — start here** — not "keep debugging X," but the exact next concrete step: which hypothesis to test next, which file to re-read, which command to re-run

## Why "not just fixed, why it broke" belongs in the record

The [Appendix's CDP Protocol deep dive](../appendix/cdp-protocol/00-index.md), Lesson 16, covered explainability by construction — the demolition history is an audit trail specifically because every challenge is traceable to what surfaced it and how it was resolved. The same logic applies here: a bugfix that only records "fixed M3's login bug" loses the CLAIM/DOUBT/RECONCILE reasoning the moment the session ends. A future you (or a teammate) hitting a similar symptom six weeks later has no way to know whether this is the same root cause resurfacing or a genuinely new problem, unless the *reasoning*, not just the outcome, is on record.

## A concrete entry shape

```
## Decisions made
- Bug: users occasionally logged out mid-session
- CLAIM tested: session token refresh assumed the client clock and server clock
  were always within 5 seconds of each other
- DOUBT confirmed: clients on cellular networks drift further than that under
  poor connectivity
- RECONCILE: widened the acceptable clock-skew window from 5s to 30s,
  added a metric to catch it if the skew ever exceeds that again

## Blockers
_none — resolved, see Decisions made_
```

This is a couple of extra lines beyond what you were already writing — the difference between "fixed the logout bug" and a record someone could actually learn from.

## Check your understanding

- What's missing from a memory entry that only says "fixed the login bug," and why does that gap matter later?
- Which existing section of `CLAUDE_MEMORY.md` should hold a doubt you haven't yet confirmed or ruled out?

*Next: [09 — `/cdp:session-start` and `/cdp:resume` for Bugfixing](09-session-commands-for-bugfixing.md).*
