# 05 — When a Bug Is Really a Missed Spike

🎬 Video: [`video-prompts.md#05-bug-or-missed-spike`](video-prompts.md#05-bug-or-missed-spike)

---

Course 3 Lesson 06 defined a spike: a macro marked `⏳ SPIKE PENDING` because there genuinely wasn't enough information to write a real implementation prompt. Some bugs aren't really implementation mistakes — they're spikes that should have been flagged and weren't, and the missing investigation surfaced later as a defect instead of earlier as an open question.

## The tell

Ask, before you start debugging as if this were an ordinary implementation mistake:

- Was there an assumption baked into the fix — about an API's behavior, a library's edge case, an external system's contract — that was never actually verified against the real thing?
- Does the bug trace back to a macro that, in hindsight, should have triggered one of the spike conditions from Course 3 Lesson 06 (unknown contract, undecided pattern, dependency on an undocumented behavior) but didn't get flagged at the time?
- Is the "fix" you're about to write actually a guess dressed up as a patch — the same shape as writing an implementation prompt against an assumption, just after the fact instead of before?

If any of these are true, you're not looking at a normal bug. You're looking at a spike that happened silently, and treating it as a five-minute patch will very likely produce another bug in the same place later.

## What to do instead

Treat it exactly like Course 3's spike process, just triggered retroactively:

1. Write the actual open question down — what specifically was assumed and never verified
2. Investigate for real — read the actual external contract, test the actual edge case, confirm the actual current behavior
3. Record the decision and the discarded alternative, the same shape as a `docs/spike-M<N>.md` stub, even if you don't formally run `/cdp:spike-integrate` for a bug that isn't tied to a still-open macro
4. Only then write the fix — now grounded in a verified fact instead of the same unverified assumption that caused the bug in the first place

## Why this distinction matters

A genuine implementation bug (Lesson 06's reproduce-isolate-fix-verify loop) and a missed spike (this lesson) look identical at first glance — both present as "the code doesn't do what it should." They demand different responses. Fixing a missed spike with an ordinary bugfix loop just produces a differently-shaped version of the same unverified guess. The fix isn't wrong because the code is bad; it's wrong because the premise underneath it was never checked.

## Check your understanding

- What's the concrete difference between a genuine implementation bug and a missed spike, even though both present the same way at first?
- Why would applying an ordinary bugfix loop to a missed spike likely fail to actually resolve it?

*Next: [06 — The Reproduce → Isolate → Fix → Verify Loop](06-reproduce-isolate-fix-verify.md).*
