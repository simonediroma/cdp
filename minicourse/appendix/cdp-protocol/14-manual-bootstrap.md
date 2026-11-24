# 14 — Manual Bootstrap on Any LLM

This lesson is the practical payoff of Lesson 06's platform-agnosticism claim: you don't need the `claude-cdp` plugin, or even Claude, to run this protocol. You need the manifesto and a capable LLM.

## The kickoff prompt

To start the CDP on a fresh LLM session, paste the manifesto into context (or give the LLM folder access to it), then send:

> You are an LLM operating the Constructive Demolition Protocol (CDP). Read the manifesto in full. Then inspect the project folder (or, if no folder is available, inspect what I provided in this conversation).
>
> Determine which CDP phase to enter:
> - IF no `project-spec.md` exists, run Phase 1 (onboarding) per §01 Phase 1.
> - ELSE IF `project-spec.md` exists but no `demolition-history.md`, run Phase 2 starting at step 00.
> - ELSE read `project-memory.md` and resume from the `next_action` field.
>
> At all times apply: Phase 0 prerequisites of §01; Rules of engagement R1 + R2 of §01 Phase 2; the augmentation framing (you handle mechanical and analytical work; I handle intuitive judgment and final approval).
>
> Confirm which phase you are entering and what your first step is, before acting.

A shorter variant is fine for context-constrained models, as long as it preserves the phase-decision logic and the R1/R2 references.

## The phase decision logic

```
IF project-spec.md is absent:
  THEN execute Phase 1 (Generative onboarding) per §01 Phase 1.
ELSE IF project-spec.md exists AND demolition-history.md is absent:
  THEN execute Phase 2 step 00 (Open the round) per §01 Phase 2.
ELSE IF project-memory.md exists AND has a non-empty next_action:
  THEN follow next_action literally.
ELSE IF project-memory.md is absent OR next_action is empty:
  THEN ask the author which phase to resume.
```

The LLM never auto-progresses past a phase boundary without your confirmation — that's the same mediated-transition principle from Lessons 09 and 12, applied at the level of *phases* instead of individual vulnerabilities or edits.

## What you write by hand, without the plugin

- **`sessions/session-YYYYMMDD-N.md`** — one file per round, the verbatim record, updated incrementally as it happens (schema in `§05.4` of the manifesto).
- **`demolition-history.md`** — the cumulative record across all rounds: a metrics summary, recurring patterns, and a chronological log.
- **`project-memory.md`** — bindings, key decisions, terminology, current state, and the crucial `next_action` field that lets you resume cold.

These three files, plus the spec itself, are the complete canonical set. Writing them by hand is more work than the plugin automating it for you — but it's the same work, not different work. If you ever wonder what the plugin is "really" doing under the hood, this lesson is the answer.

## Check your understanding

- Why does the phase-decision logic check for `demolition-history.md`'s absence specifically, rather than just checking whether `project-spec.md` exists?
- If you were running this by hand and forgot to write `project-memory.md`'s `next_action` field at the end of a session, what would the next session have to do instead of resuming cleanly?

*Next: [15 — The Five Non-Prescribed Dimensions](15-non-prescribed-dimensions.md).*
