# 10 — When a Bug Reveals a Spec Gap

Lesson 05 covered bugs that are actually missed spikes — an implementation-level gap that should have been investigated before it was built. This lesson covers a different case, one level up: bugs that trace back not to an implementation assumption, but to the **spec itself** being wrong, ambiguous, or silent on the case that just broke.

## The tell, this time

- The fix you're about to write isn't "correct the code to match the spec" — it's "the spec didn't actually say what should happen here, so any fix is a new decision, not a correction"
- Two people implementing this macro's prompt independently could reasonably have built two different, both-defensible behaviors — and the bug is just which one got built
- The bug exposes a case a demolition round should have surfaced (the [Appendix's CDP Protocol deep dive](../appendix/cdp-protocol/00-index.md), Lesson 09's Dev Implementer angle: "what edge cases is the author silent on?") but didn't, because that round never happened or missed this specific angle

If any of these are true, patching the code alone leaves the actual defect in place: an underspecified decision, not a coding mistake.

## Two routes back, and how to choose

- **`/cdp:integrate`, directly** — if you and whoever owns the spec can agree on the missing decision right now, treat it exactly like an already-resolved demolition finding: propose the spec change, get explicit confirmation, apply it, bump the version (Course 1 Lesson 06's MINOR/MAJOR logic still applies — a genuinely new behavior decision is often MAJOR, not MINOR, even if it looks like "just a bugfix").
- **A fresh demolition cycle** — if the gap is bigger than one clear decision, or if fixing it might have ripple effects you're not confident you've fully thought through, run `/cdp:demolish` against the relevant section with a persona suited to the angle that was missed (often the Dev Implementer, sometimes the End User if the gap is about real-world usability). Let the round surface what else might be hiding nearby before you integrate a fix for just the one symptom you already know about.

## Why patching the code without touching the spec is a false economy

If the spec stays silent, the next person implementing anything adjacent to this behavior inherits the exact same ambiguity — and may resolve it differently than you just did, reintroducing an inconsistency that looks like a regression but is actually the same unspecified decision made twice. Updating the spec, even for what feels like "just a bug," is what makes the fix durable rather than local.

## Check your understanding

- What's the tell that distinguishes a spec-gap bug from an ordinary implementation bug (Lesson 06) or a missed spike (Lesson 05)?
- Under what condition should you reach for a fresh demolition cycle instead of going straight to `/cdp:integrate`?

*Next: [11 — Regression Discipline](11-regression-discipline.md).*
