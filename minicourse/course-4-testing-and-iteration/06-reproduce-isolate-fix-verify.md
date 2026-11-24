# 06 — The Reproduce → Isolate → Fix → Verify Loop

Once Lesson 05 has ruled out "this is actually a missed spike," you're looking at a genuine implementation bug — and the loop for fixing it is a direct mapping onto TDD's RED-GREEN-REFACTOR, which is already in every MEDIUM and HIGH-risk macro prompt you generated.

## The mapping

| TDD | Bugfix equivalent |
|---|---|
| **RED** — write a failing test | **Reproduce** — write a test that fails *because of the actual bug*, not a plausible-sounding stand-in |
| — | **Isolate** — narrow the failing test until it points at the smallest unit of code responsible, not the whole feature |
| **GREEN** — implement the minimum to pass | **Fix** — the minimum change that makes the reproduction test pass |
| **REFACTOR** — clean up without changing behavior | **Verify** — confirm the fix actually addresses the root cause, not just this one reproduction path |

Course 2's development rules state the TDD discipline directly: *"Bug fix: write the test that reproduces the bug first (must fail), then the fix. A test written after the fix is not TDD."* This isn't a suggestion specific to new features — it's already written as a bug-fixing rule in every `CLAUDE.md` / `01-operative.mdc` you have.

## Why "reproduce" comes before "isolate," and why both come before "fix"

A fix written before the bug is reliably reproduced is a fix aimed at a guess, not at the actual defect — you might genuinely improve something adjacent to the bug while leaving the real cause untouched. Isolating narrows the reproduction to the smallest failing unit, which does two things: it makes the eventual fix surgical (Lesson 04's 5-axis review, "surgical" axis) instead of sprawling, and it often reveals that the bug's real cause is one layer removed from where the symptom first appeared.

## What "verify" actually checks

Not just "does the reproduction test now pass" — that's necessary but not sufficient. Verify also asks: does this fix address the *root cause*, or does it just paper over this one specific reproduction path while leaving the underlying issue reachable through a slightly different route? A fix that only makes the specific failing test green, without addressing why the code allowed that state in the first place, will very likely resurface as a different-looking bug later.

## Check your understanding

- Why does writing the reproduction test before the fix matter more than it might seem, compared to just fixing what looks wrong and testing afterward?
- What's the difference between a fix that makes the reproduction test pass and a fix that addresses the root cause — and why isn't the first one automatically the second?

*Next: [07 — Doubt-Driven Review, Applied Retroactively](07-doubt-driven-review-retroactively.md).*
