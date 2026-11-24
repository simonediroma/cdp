# 01 — Why Bugs Need a Method Too

🎬 Video: [`video-prompts.md#01-why-bugs-need-a-method`](video-prompts.md#01-why-bugs-need-a-method)

---

Something breaks in your PoC. The fast instinct is to open the file, stare at it, change something that looks wrong, and move on if it seems to work now. That instinct isn't wrong to have — it's just not sufficient on its own, for exactly the reason Course 1 Lesson 01 gave for vibe coding: **improvisation has no memory and no gates.**

## The symptoms of ad-hoc bug fixing

- The same class of bug comes back in a different file three weeks later, because nothing recorded *why* the first one happened
- A "fix" that was never verified against the actual failure — it compiles, it looks plausible, nobody reproduced the original break first
- No record of how bad the bug actually was, so a cosmetic issue and a data-loss bug get the same fifteen minutes of attention
- A fix applied under time pressure that quietly reintroduces the exact problem a security checklist would have caught, because nobody re-ran the checklist for a "small" change

None of this is a skill problem. It's the same structural gap Course 1 opened with: a single person, working from inside their own head, reliably misses things a structured, adversarial process would have caught.

## What this course reuses, not invents

There is no `/cdp:debug` command. This course doesn't wait for one — it takes three things you already have from Courses 1-3 and points them at bugs instead of spec vulnerabilities:

1. **Severity** — the Appendix's CDP Protocol deep dive's Critical/Major/Minor scale (Lesson 03 here)
2. **Gates** — the 5-axis review, TDD, Doubt-Driven Review, and security checklist already embedded in every macro prompt you generated (Lesson 02)
3. **Mediated resolution** — the Appendix's CDP Protocol deep dive's principle that nothing gets marked resolved without explicit confirmation it actually addressed the problem, not just that it was attempted (running throughout this course)

## What "the CDP way" means for a bug

Applied concretely: don't fix silently. State what broke, how severe it is, what you believe the root cause is, and verify the fix against a reproduction of the original failure before calling it done. That's not more process for its own sake — it's the minimum discipline that turns "I think this is fixed" into "this is verifiably fixed, and here's the record of why."

## Check your understanding

- What's the structural similarity between ad-hoc bug fixing and vibe coding, as Course 1 described it?
- Name the three things this course reuses from Courses 1-3, rather than inventing new mechanics for.

*Next: [02 — The Gates Already in Your Prompts](02-the-gates-already-in-your-prompts.md).*
