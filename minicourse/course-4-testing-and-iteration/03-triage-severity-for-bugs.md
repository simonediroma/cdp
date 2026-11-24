# 03 — Triage Severity for Bugs

🎬 Video: [`video-prompts.md#03-triage-severity-for-bugs`](video-prompts.md#03-triage-severity-for-bugs)

---

The [Appendix's CDP Protocol deep dive](../appendix/cdp-protocol/00-index.md), Lesson 11, gave you three severities for spec vulnerabilities. The same three words, the same obligations, apply cleanly to a bug — you're just triaging a defect instead of a claim in a document.

## The scale, reused

| Severity | For a spec (Appendix) | For a bug (this course) |
|---|---|---|
| **Critical** | Blocks progress — a core assumption is invalidated | Blocks release — data loss, security exposure, the core flow doesn't work at all |
| **Major** | Requires an explicit accepted decision, with rationale | Requires a conscious call: fix now, or ship with a documented, time-boxed workaround |
| **Minor** | Backlog item — doesn't affect the core design | Backlog item — a real defect, but not one that changes whether you ship |

The obligation that carries over unchanged: **silence is not acceptance.** The Appendix's CDP Protocol deep dive was explicit that a Major vulnerability needs a written rationale if you're not fixing it — the same rule applies here. "I'll get to it later" is not a triage decision; "I'm accepting this as a known limitation until X, because Y" is.

## Triage questions, in order

1. **Does this block the core flow, or corrupt/expose data?** If yes, it's Critical — nothing else ships until it's resolved or the release is held.
2. **Does this affect a real user path, but the system is still usable around it?** Major — decide explicitly, and write the decision down (Lesson 08 covers where).
3. **Is this a rough edge, a cosmetic issue, an edge case nobody's likely to hit soon?** Minor — logged, not ignored, revisited later.

## The trap this scale exists to prevent

Without an explicit severity call, two failure modes compete for your attention: over-fixing (spending an afternoon polishing a Minor issue while a Critical one waits) and under-fixing (shipping past a Major issue because it "seemed fine" without anyone actually deciding that). Both come from the same root cause — no explicit triage step — and the fix is the same three-question pass every time, not a judgment call you re-invent per bug.

## Check your understanding

- What does "silence is not acceptance" mean concretely for a Major-severity bug you've decided not to fix immediately?
- Which of the three triage questions determines whether a bug can block a release outright?

*Next: [04 — The Pre-PR Gate as First Line of Defense](04-pre-pr-gate-first-line-of-defense.md).*
