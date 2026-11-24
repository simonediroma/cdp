# 09 — Trace Your Own Divergence

🎬 Video: [`video-prompts.md#09-trace-your-own-divergence`](video-prompts.md#09-trace-your-own-divergence)

---

Lesson 01 made a claim before you'd written a single word of your spec: that whatever ended up in your build would be a function of your own answers, not a fixed template the plugin was always going to produce. You've now been through the whole loop once. This lesson asks you to make that claim concrete instead of taking it on faith.

## The trace

Go back through your own trail — your onboarding transcript, your demolition cycle, your integration diffs, your macro table — and write down at least four specific pairs of the form *"I said X, and because of that, Y happened downstream."* A few places worth checking, based on what earlier lessons flagged as consequential:

- **Persona choice.** Which line in your v1.0 spec (Lesson 03) made the persona you picked in Lesson 04 the obvious one, over the other five?
- **Headline severity.** The vulnerability your chosen persona attacked hardest in Lesson 05 — what made it Critical, Major, or Minor specifically, rather than some other severity?
- **Version bump.** The section your headline fix landed in during Lesson 06 — does the MAJOR/MINOR rule match what you'd have guessed from the severity alone, or did it surprise you the way the rule itself predicted it might?
- **Macro shape.** At least one macro from Lesson 07 that exists specifically because of something you said — your audience answer, a constraint a demolition round forced into the open — and what your table would look like without that one answer.

## If you did this with someone else

If you worked through this course alongside someone building a different Custom Scorecard domain, compare your trace against theirs now. You should be able to point at a specific answer of theirs that explains a specific difference between your two builds — not just "their app is about something else," but "they picked Legal & Compliance because of a constraint they flagged in Question 7 that has no equivalent in my spec at all," or "their highest-risk macro exists because more than one person needs access to theirs, and only one person needs it in mine." If you can't get that specific, the comparison isn't finished yet.

This isn't required to finish the course. But it's the fastest way to see the same point from two directions at once instead of one.

## What this lesson is actually checking

Not whether your app works — Lesson 08 already confirmed that. This lesson checks whether you can point to the mechanism, not just the outcome: not "my app turned out differently," but "this specific answer, at this specific step, is why."

## Check your understanding

- Of your four traced pairs, which one surprised you most — where the downstream effect wasn't what you expected when you gave the original answer?
- If you went back and changed just one early answer — Question 2 of onboarding, say, or which persona you picked — which of your four traced pairs would break first?

*Next: [10 — Closing the Loop](10-closing-the-loop.md).*
