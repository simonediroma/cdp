# 07 — Doubt-Driven Review, Applied Retroactively

🎬 Video: [`video-prompts.md#07-doubt-driven-review-retroactively`](video-prompts.md#07-doubt-driven-review-retroactively)

---

Doubt-Driven Review, as your HIGH-risk macro prompts define it, is a pre-emptive tool: state a decision as a CLAIM, list ways it could be wrong (DOUBT), verify or adjust (RECONCILE), before you write the code. Nothing about that three-step shape requires you to be looking forward. Pointed backward at a decision that already shipped and already broke, it becomes a genuine root-cause technique.

## The three steps, run backward

1. **CLAIM** — state, explicitly, what the original code assumed to be true. Not what the bug report says is broken — what the *implementation* was implicitly claiming when it was written. ("This assumed the webhook payload always includes a user ID.")
2. **DOUBT** — list two or three concrete ways that claim could have been false, and check which one actually happened. This is where you stop guessing and start testing specific hypotheses against the real system.
3. **RECONCILE** — once you know which doubt was real, the fix follows directly from it — you're not patching a symptom, you're correcting the claim that was wrong.

## Why this differs from just "finding the bug"

Ordinary debugging often stops at the first plausible explanation — the fix that makes the symptom go away. CLAIM/DOUBT/RECONCILE forces you to state the *original assumption* explicitly before proposing a fix, which surfaces a specific, useful question: was this assumption reasonable when it was made, or was it always fragile? That distinction matters for Lesson 11's regression discipline — an assumption that was reasonable at the time but became false due to a change elsewhere is a different kind of problem than an assumption that was never sound.

## When this is worth the extra step

Not every bug needs a full CLAIM/DOUBT/RECONCILE pass — a typo or an off-by-one error rarely does. Reach for it when the bug lives in code that was originally HIGH risk (auth, RBAC, payments, unvalidated input — the same criteria from Course 2 Lesson 04's risk table), or when your first instinct at a fix doesn't fully explain why the bug happened in the first place. If you can't state the original CLAIM confidently, that's itself a signal you don't yet understand the bug well enough to trust a fix.

## Check your understanding

- What's the difference between "finding a fix that makes the symptom disappear" and actually running CLAIM/DOUBT/RECONCILE against the bug?
- Under what condition should you skip this technique, and under what condition does it become worth the extra step?

*Next: [08 — Tracking Iteration State](08-tracking-iteration-state.md).*
