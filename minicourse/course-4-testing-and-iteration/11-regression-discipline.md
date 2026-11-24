# 11 — Regression Discipline

🎬 Video: [`video-prompts.md#11-regression-discipline`](video-prompts.md#11-regression-discipline)

---

A fix that resolves today's bug and says nothing about tomorrow's recurrence isn't finished — it's paused. This lesson is about the last step every bugfix in this course owes: making sure the same class of bug can't come back silently.

## What "regression discipline" actually requires

1. **The reproduction test stays** — Lesson 06's RED test doesn't get deleted once it goes green. It becomes a permanent regression test, run every time this code path changes again. This is the concrete, durable artifact of the whole reproduce-isolate-fix-verify loop — not the fix itself, but proof the fix keeps working.
2. **The Pre-PR Gate gets re-run on the fix, not skipped because "it's just a bugfix."** Lesson 04 already made this point about urgency; regression discipline is what happens when you actually honor it every time, not just when you remember to.
3. **The root cause gets checked for siblings.** If Lesson 07's Doubt-Driven Review surfaced that a specific assumption was wrong, ask: does that same assumption appear anywhere else in the codebase? A clock-skew assumption fixed in the login flow but left untouched in a payment-confirmation flow is not actually resolved — it's resolved in one of its two locations.
4. **The decision gets recorded where the next person will actually see it** — Lesson 08's `CLAUDE_MEMORY.md` entry, and if the root cause traced back to a spec gap (Lesson 10), the updated spec itself. A fix that lives only in a merged PR's diff, with no trace in memory or spec, is invisible to anyone not specifically reading that PR's history.

## The severity-scaled version of this discipline

Not every bug needs the full four-point treatment. Reuse Lesson 03's severity triage: a Critical or Major bug earns all four steps without negotiation — the cost of it recurring is exactly why it was triaged that severity in the first place. A Minor bug might reasonably skip the "check for siblings" step if the code path is genuinely isolated — but the reproduction test and the Pre-PR Gate re-run are close to non-negotiable regardless of severity, because both are cheap relative to the cost of the same defect resurfacing.

## Why this is the actual point of the whole course

Every lesson before this one was about fixing *this* bug correctly. Regression discipline is what turns "we fixed a bug" into "we now have a system slightly more resistant to this entire class of bug than it was yesterday." That compounding effect — not any single fix — is what separates a project that gets more reliable over time from one that just accumulates patches.

## Check your understanding

- Why does the reproduction test need to stay in the codebase after the bug is fixed, rather than being deleted once it passes?
- Which of the four regression-discipline steps scales down for a Minor-severity bug, and which two stay close to mandatory regardless of severity?

*Next: [12 — Exercise: Triage, Fix, and Close a Real Bug](12-exercise.md).*
