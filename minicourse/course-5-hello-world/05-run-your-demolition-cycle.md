# 05 — Run Your Demolition Cycle

🎬 Video: [`video-prompts.md#05-run-your-demolition-cycle`](video-prompts.md#05-run-your-demolition-cycle)

---

`/cdp:demolish` attacks one claim at a time, always in the same three-part shape: quote the exact claim from your spec, name the vulnerability category in bold brackets, state the defect in one to three sentences, close with *"How do you respond to this?"* No solutions are ever offered — that part is yours.

## What a strong versus weak response looks like

Say your differentiation answer from Lesson 03 was something like "no one else does the exact combination of criteria I care about." A persona might quote that straight back and ask why that's not just describable in a spreadsheet in five minutes.

A **weak** response repeats the claim in different words — "well, it's still my own criteria" — without addressing why that alone justifies an app. That gets gently flagged as not addressing the point, and the criticism gets rephrased, isolating the single contested claim more precisely.

A **strong** response narrows the claim into something concrete a spreadsheet genuinely doesn't do — "it remembers my criteria across sessions and the ranking updates live as I add entries, with zero setup each time." That's recorded as `resolved`.

If you get stuck rather than landing on either, the escalation path gives you room: the criticism gets rephrased in simpler terms, then the single contested claim gets isolated, then you're asked what your first instinct is even if it's not fully formed, and finally you're offered three structured exits — modify the claim, narrow the scope, or accept it as a declared limitation you write down explicitly. None of these are a failure; "I accept this as a declared limitation" is a completely legitimate outcome for a real, unresolved tension you'd rather flag than pretend to solve.

## Severity, and why it matters what you write down

Every vulnerability gets classified Critical, Major, or Minor as it's raised. Critical blocks the spec from proceeding at all. Major doesn't block, but needs an explicit, written decision — silence isn't acceptance. Minor is a real issue, just not urgent enough to hold up this cycle. The classification isn't a formality: it's what Lesson 06 uses to figure out how your spec's version number should move, and it's worth recording honestly rather than downgrading something uncomfortable to Minor just to move faster.

## Now do it

Run `/cdp:demolish`. Select the persona you settled on in Lesson 04. Work through the attack loop for real — one criticism at a time, answered honestly, escalated if you genuinely don't have a good answer yet rather than talked around. Let the cycle run until it's exhausted or you deliberately pause it. When it closes, you'll have a summary: issues raised, resolved, deferred, accepted as limitations. Come back here for Lesson 06 once you have that summary in hand.

## Check your understanding

- Which of your resolved issues came from a strong response on the first try, and which needed the escalation path? What made the difference?
- If you accepted anything as a declared limitation rather than resolving it, what would it take for a future cycle to actually resolve it instead?

*Next: [06 — Integrate and Freeze Your Spec](06-integrate-and-freeze-your-spec.md).*
