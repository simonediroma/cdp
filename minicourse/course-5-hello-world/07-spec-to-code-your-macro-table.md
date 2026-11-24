# 07 — Spec-to-Code: Read Your Own Macro Table

🎬 Video: [`video-prompts.md#07-spec-to-code-your-macro-table`](video-prompts.md#07-spec-to-code-your-macro-table)

---

Your frozen spec from Lesson 06 goes into `/cdp:spec-to-code`. It passes the Gate — Spec Frozen check from Course 2 Lesson 01 because there's nothing left `[TO BE DEFINED]`. Since this is a brand-new project with no existing codebase, it runs in GREENFIELD mode: Step 1 analyzes your PRD, Step 1b runs Deploy Discovery, and Step 2 decomposes it into a macro table — exactly the mechanics Course 2 already taught. What's different here is that you're about to read a table shaped entirely by your own answers, not someone else's.

## Deploy Discovery, answered for real

Course 2 Lesson 02 covered the mechanics: propose a concrete setup, then refine against budget, provider, region, and a custom domain, then confirm one sentence before proceeding. Answer these for what's actually true of your project — if you're the only user, say so; if a handful of named people need to reach the same URL, say that instead. Your Question 2 answer from Lesson 03 (primary reader/user) is exactly what decides which of these you're actually looking at.

## Reading your macro table as a readout, not a checklist

Once your macro table comes out — a list of macros with a title, a risk level, and a dependency — don't just skim it as a to-do list. For each macro, ask: **which specific thing I said produced this?**

- If your spec said more than one person needs access, expect a macro that handles that — and if your spec said "just me," expect no such macro at all. Its absence is correct, not a gap.
- If a demolition round in Lesson 05 forced a specific constraint into your spec — a retention rule, a fairness check, anything with a number or a policy attached — expect a macro (or an explicit step inside one) that implements exactly that, tied to nothing in your spec but that one resolved vulnerability.
- If a macro's risk level is HIGH or MEDIUM rather than LOW, ask what in your frozen spec actually justifies that — a business rule with a real correctness cost, a change to how more than one person's data is handled, anything Course 2's agent-skills rules would flag as worth slowing down for.

If you can't answer "which specific thing I said produced this macro" for every row in your own table, that's worth pausing on before you proceed — it usually means either the spec left something implicit that should have been explicit, or the decomposition assumed something you didn't actually say.

## Now do it

Run `/cdp:spec-to-code` in GREENFIELD mode. Walk through Deploy Discovery honestly. When your macro table appears, go through it row by row and trace each one back to a specific line in your own spec before confirming it. Then come back here for Lesson 08.

## Check your understanding

- Pick the macro in your own table with the highest risk level. Which specific answer, from onboarding or demolition, is responsible for that risk level being what it is?
- If you changed your Question 2 answer from Lesson 03 right now — from "just me" to "me and two others," or the reverse — which macro in your table would you expect to appear or disappear?

*Next: [08 — Ship Your PoC](08-ship-your-poc.md).*
