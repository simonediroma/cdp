# 08 — Ship Your PoC

🎬 Video: [`video-prompts.md#08-ship-your-poc`](video-prompts.md#08-ship-your-poc)

---

No new mechanics here — executing a macro plan through to a shipped `M_deploy` is Course 2 Lessons 05 and 06 in full, and nothing about how you *run* a macro changes because the app is small. What's worth doing deliberately is watching your own plan finish, and noticing whether the amount of care each macro asks for actually matches its risk level.

## Now do it

Execute your macro table from Lesson 07 in order, respecting each macro's own dependency and its own Pre-PR Gate — a LOW-risk macro gets a lighter gate, a HIGH-risk one gets the fuller version Course 2 Lesson 04 described, and that's expected, not something to shortcut because "it's just a small app." If a macro's gate feels heavier than the macro seems to deserve, that's worth checking against Lesson 07's question again — trace it back to what in your spec actually justified that risk level.

Run through to `M_deploy`. When it's done, you should have a real, working, self-contained Custom Scorecard at a public URL — nothing scraped, nothing calling a paid API, nothing calling a model at runtime, exactly as Lesson 02 set out.

## Check your understanding

- Which macro took the most deliberate care to get right, and does that match the risk level `/cdp:spec-to-code` assigned it in Lesson 07?
- Now that it's live: is there anything about the deployed app that surprises you, given what you specified back in Lesson 03? If so, where in the loop did that surprise actually get decided — onboarding, demolition, or the macro decomposition itself?

*Next: [09 — Trace Your Own Divergence](09-trace-your-own-divergence.md).*
