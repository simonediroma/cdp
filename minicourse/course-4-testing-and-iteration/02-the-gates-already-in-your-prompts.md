# 02 — The Gates Already in Your Prompts

Before this course teaches anything new, it's worth being precise about what you already have. Every macro `/cdp:spec-to-code` generated (Course 2 Lesson 03) carries a Pre-PR Gate scaled to its risk level. These are the same four behaviors, ready to be reused the moment something breaks — Course 2 Lesson 04 covers how completely each is actually implemented in what you were handed, which is worth knowing before you lean on one of them mid-fix.

## The four gates, recapped

| Gate | Applies to | What it actually checks |
|---|---|---|
| **5-axis code review** | Every macro, every risk level | Correctness, security, readability, performance, surgical scope |
| **TDD** | MEDIUM and HIGH risk | Write the failing test first, then the fix — never the reverse |
| **Doubt-Driven Review** | HIGH risk (auth, RBAC, payments, unvalidated input) | CLAIM → DOUBT → RECONCILE, for every non-trivial decision |
| **Security checklist** | HIGH risk | Secrets, input validation, rate limiting, OWASP Top 10 |

(A fifth gate — the **Shipping checklist** — exists specifically for the `M_deploy` macro, Course 2 Lesson 06. It doesn't apply to ordinary bugs; it applies when the bug is in the deploy config itself.)

## Why this matters for a bug, not just for new code

These gates were written into your macro prompts assuming forward motion — building something that doesn't exist yet. Nothing about their logic requires that direction. TDD's discipline ("write the failing test first, then the fix") is *literally* the bug-fixing version of RED-GREEN-REFACTOR — Lesson 06 spells this out. Doubt-Driven Review's CLAIM/DOUBT/RECONCILE cycle works exactly as well pointed backward at a decision that already shipped as it does pointed forward at one you're about to make — Lesson 07 covers that directly. The 5-axis review doesn't care whether the code it's reviewing is new or a fix to something broken.

## What this means practically, right now

Before you write a single new process for handling this bug: check what risk level the affected macro was assigned. If it was HIGH, you already have a security checklist and Doubt-Driven Review waiting to be re-applied to your fix — not because the bug is necessarily security-related, but because the code around it was already judged risky enough to warrant that scrutiny once. Don't relitigate the risk level from scratch; inherit it, unless the bug itself gives you a specific reason to reassess.

## Check your understanding

- Which of the four gates would you reach for first if the bug is in a HIGH-risk macro touching authentication, and why?
- Why does inheriting the original macro's risk level make sense as a default, rather than reassessing risk from zero every time a bug surfaces?

*Next: [03 — Triage Severity for Bugs](03-triage-severity-for-bugs.md).*
