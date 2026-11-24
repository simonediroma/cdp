# 10 — Exercise: Add a Real Feature to Your PoC

🎬 Video: [`video-prompts.md#10-exercise`](video-prompts.md#10-exercise)

---

Go back to the PoC you shipped at the end of Course 2. Pick one real feature it's genuinely missing — something a real user of that PoC would actually ask for, not a toy addition invented just to have something to build.

## The checklist

- [ ] **Generate the architecture context** — `/cdp:arch-init` against your live repo; don't skip the "What NOT to touch" question even if everything else auto-detects cleanly (Lesson 03)
- [ ] **Onboard the feature** — a fresh `/cdp:onboarding` scoped to this one feature, not a rewrite of the whole product's spec (Lesson 04)
- [ ] **Demolish with technical feasibility in scope** — at least one round where the persona's claims get checked against what `architecture-context.md` actually says exists (Lesson 04)
- [ ] **Integrate and harden** — same discipline as Course 1: repeat demolish → integrate until new rounds surface mostly Minor issues
- [ ] **Spec-to-code, FEATURE-ADDITION mode** — confirm the delta macro table; verify there's no `M0` in it and that any macro touching shared code got its risk level bumped (Lesson 05)
- [ ] **Let at least one macro land on `⏳ SPIKE PENDING`** — if decomposition doesn't naturally produce one, pick the macro you're least certain about and treat it as a spike deliberately; investigate for real, fill in the stub, mark it `RESOLVED` (Lesson 06)
- [ ] **Run `/cdp:spike-integrate`** — confirm the macro's risk level and prompt actually changed based on what the investigation found, not just that the status flipped (Lesson 07)
- [ ] **Work across at least two sessions** — close the work mid-macro on purpose, then open a new session with `/cdp:resume` and confirm its four-line answer actually matches where you left off (Lesson 08)
- [ ] **Verify the shared docs, not just the track-specific ones** — confirm `docs/architecture.md` and `docs/context.md` read correctly regardless of which track (Claude Code or Cursor) you're actually using (Lesson 09)
- [ ] **Ship it** — the feature merged, deployed alongside the existing PoC, verified live

## What "done" looks like here

Not just working code — a feature that went through a real demolition round, survived a real spike investigation, and can be picked up by someone (including you, a week later) who has never seen this specific feature's spec, because `docs/context.md`, `CLAUDE_MEMORY.md`, and the spike stub all say what happened and why.

## Before you move to Course 4

You will hit a bug during this exercise — in the feature itself, in a spike's hypothesis that turned out wrong, somewhere. Don't fully debug it ad hoc. Note what broke and how you noticed it; Course 4 is built around exactly that moment, and having a real bug in hand will make it concrete instead of abstract.
