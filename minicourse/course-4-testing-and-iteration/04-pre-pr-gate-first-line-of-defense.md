# 04 — The Pre-PR Gate as First Line of Defense

🎬 Video: [`video-prompts.md#04-pre-pr-gate-first-line-of-defense`](video-prompts.md#04-pre-pr-gate-first-line-of-defense)

---

The best bug to deal with is the one that never merges in the first place. This lesson is about treating the Pre-PR Gate — the same one from Lesson 02 — as an actual line of defense, not a checklist you tick through on autopilot on your way to merging.

## What "actually running the gate" looks like

Each item on the 5-axis review is a real question, not a formality:

- **Correctness** — does the code do what it says, or does it do what you *assumed* it says?
- **Security** — specifically for this change, not security in the abstract
- **Readability** — would a successor understand this in five minutes, or does it depend on context only you currently hold?
- **Performance** — any regression, even a small one you're tempted to wave off as "probably fine"?
- **Surgical** — does every changed line actually trace back to the requirement, or did something extra sneak in?

The last one — surgical — is where most latent bugs hide. A change that touches more than it needed to is a change that introduced a side effect nobody was looking for, because nobody expected that file to be part of this PR at all.

## Where HIGH-risk gates catch what the 5-axis review alone won't

If the macro is HIGH risk, TDD, Doubt-Driven Review, and the security checklist all apply before the 5-axis review even runs. This ordering isn't arbitrary: TDD forces you to prove the failure mode exists (a failing test) before you're allowed to claim it's fixed; Doubt-Driven Review forces you to state the risky decision explicitly and try to break it yourself before someone else does; the security checklist catches the class of bug that's invisible in a casual read (a secret logged, an unvalidated input path) precisely because it's a checklist, not a vibe.

## The gate you're most likely to skip under pressure

Every one of these gates is easiest to skip exactly when a bug is urgent — "it's a one-line fix, I don't need the full gate for this." That instinct is precisely backward: a one-line fix under time pressure, unreviewed, is a plausible origin story for the next bug this course would need to cover. The gate doesn't scale down for urgency; if anything, urgency is the condition it exists for.

## Check your understanding

- Which axis of the 5-axis review is most likely to catch a bug that "looks fine" on a casual read, and why?
- Why does skipping the gate under time pressure work against the exact goal the gate is meant to serve?

*Next: [05 — When a Bug Is Really a Missed Spike](05-bug-or-missed-spike.md).*
