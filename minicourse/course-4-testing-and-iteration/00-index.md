---
course: 4
title: "Testing & Iteration: Fixing PoC Bugs, the CDP Way"
audience: Anyone triaging and fixing bugs in a PoC or product built with the claude-cdp loop
depends_on: "Course 2 (required) — Course 3 (recommended, for the FEATURE-ADDITION-specific lessons)"
---

# Course 4 — Testing & Iteration: Fixing PoC Bugs, the CDP Way

## What this course is

Courses 1-3 hardened a spec and then built from it. This course is about what happens when the thing you built doesn't quite work — a bug in the PoC from Course 2, or in a feature added in Course 3. There's no dedicated `/cdp:*` bugfix command; this course isn't about a skill you haven't met yet. It's about reusing the discipline you already have — severity triage, mediated resolution, the gates already embedded in every macro prompt — and pointing it at defects instead of spec vulnerabilities.

## Why this isn't just "go fix it"

Course 1 Lesson 01 named the failure mode this course exists to prevent: vibe coding has no memory and no gates. Ad-hoc bug fixing has the same shape — a fix applied by feel, with no record of severity, no verification it actually addressed the root cause, and no defense against the same class of bug recurring next week. The method here isn't new machinery. It's the Appendix's CDP Protocol deep dive's severity scale and mediated-resolution principle, and Course 2's Pre-PR Gate mechanics, applied to the moment something breaks instead of only to the moment something gets specified.

## Learning objectives

By the end of this course you will be able to:

- Explain why ad-hoc bug fixing fails for the same structural reason vibe coding does
- Recognize the gates already embedded in your generated prompts (5-axis review, TDD, Doubt-Driven Review, security checklist) and use them as your first line of defense
- Triage a bug's severity using the Appendix's CDP Protocol Critical/Major/Minor scale, and know what each severity obligates you to do before shipping a fix
- Tell a genuine implementation bug apart from a missed spike that leaked into production
- Run the reproduce → isolate → fix → verify loop as a disciplined mapping onto TDD's RED-GREEN-REFACTOR
- Apply Doubt-Driven Review retroactively — CLAIM/DOUBT/RECONCILE as a root-cause tool, not just a pre-emptive one
- Keep session memory current across a multi-session bugfix, using `/cdp:session-start` and `/cdp:resume`
- Recognize when a bug is actually a spec gap, and route it back to `/cdp:integrate` or a fresh demolition cycle instead of only patching code
- Close the loop with regression discipline, so the same class of bug doesn't recur silently

## Lessons

| # | Lesson |
|---|--------|
| 01 | [Why Bugs Need a Method Too](01-why-bugs-need-a-method.md) |
| 02 | [The Gates Already in Your Prompts](02-the-gates-already-in-your-prompts.md) |
| 03 | [Triage Severity for Bugs](03-triage-severity-for-bugs.md) |
| 04 | [The Pre-PR Gate as First Line of Defense](04-pre-pr-gate-first-line-of-defense.md) |
| 05 | [When a Bug Is Really a Missed Spike](05-bug-or-missed-spike.md) |
| 06 | [The Reproduce → Isolate → Fix → Verify Loop](06-reproduce-isolate-fix-verify.md) |
| 07 | [Doubt-Driven Review, Applied Retroactively](07-doubt-driven-review-retroactively.md) |
| 08 | [Tracking Iteration State](08-tracking-iteration-state.md) |
| 09 | [`/cdp:session-start` and `/cdp:resume` for Bugfixing](09-session-commands-for-bugfixing.md) |
| 10 | [When a Bug Reveals a Spec Gap](10-bug-reveals-spec-gap.md) |
| 11 | [Regression Discipline](11-regression-discipline.md) |
| 12 | [Exercise — Triage, Fix, and Close a Real Bug](12-exercise.md) |

## Source material

Grounded in the [Appendix's CDP Protocol deep dive](../appendix/cdp-protocol/00-index.md)'s severity scale (§03) and mediated-resolution principle (§01 Phase 2 step 03), and in `skills/spec-to-code-update/references/osmani-skill-map.md` and `boilerplate-formats.md` for the gates already embedded in generated prompts — this course doesn't invent new plugin behavior, it reuses what Courses 1-3 already established.

## Unfamiliar term?

Check [`../appendix/01-glossary.md`](../appendix/01-glossary.md) and [`../appendix/02-useful-resources.md`](../appendix/02-useful-resources.md).
