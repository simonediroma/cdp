# 07 — Phase 0: Setup

🎬 Video: [`video-prompts.md#07-phase-0-setup`](video-prompts.md#07-phase-0-setup)

---

Before any generative or adversarial work happens, the CDP has a one-time setup phase. Two decisions and a set of prerequisites — get these wrong and everything downstream gets shakier.

## Declare your operating mode

- **Persistent mode (default, recommended for any real project).** The LLM has read/write access to a project folder. Sessions, history, and memory persist as files across sessions. This is what the `claude-cdp` plugin gives you.
- **Single-session mode (fallback).** No folder access. The entire cycle — manifesto, spec, persona, accumulating history — lives inside one chat's context. You export the conversation at the end to preserve state.

Protocol behavior is identical either way; only *where the state lives* differs.

## The five prerequisites

1. A project folder (persistent mode) or one chat with enough context window (single-session mode).
2. An LLM with folder read/write, or an LLM session that can hold manifesto + spec + persona + history in context at once.
3. The spec target — an existing `project-spec.md`, or a draft to be produced during onboarding.
4. A persona reference — the five reference personas from `§02` of the manifesto (Lesson 10 covers these in depth), ready to instantiate as system prompts.
5. Memorization instructions — how the LLM writes session files, updates the demolition history, updates memory. With the plugin, this is automated; without it, the manifesto itself encodes the memorization protocol (`§05.4`).

## The single-owner assumption

One assumption is easy to miss and important to internalize: **the CDP assumes exactly one accountable author per project.** That person gathers input from whatever stakeholders the artifact touches (legal, finance, creative, engineering) and synthesizes it *before* Phase 1 begins. The protocol does not model multi-stakeholder governance, sign-off chains, or disagreement resolution between contributors — those get resolved upstream, before the spec ever enters the CDP cycle.

Whoever holds that synthesis role is "the author" throughout the rest of this course. This isn't a limitation to route around — a single owner is *why* demolition sessions stay short and hardening stays fast. Committee-style acceptance would fight against the same-day pace the protocol is built for.

## What "done" looks like for Phase 0

By the end of setup you should be able to state, in one sentence each: which operating mode you're in, whether all five prerequisites are satisfied, and who the single accountable author is. If you can't answer all three, you're not ready for Phase 1 yet — go back and settle them first.

## Check your understanding

- Why does folder access change *where* state lives but not *what* the protocol does?
- If a project genuinely has three co-equal decision-makers with no one able to synthesize their input, what does the single-owner assumption imply you need to fix before starting?

*Next: [08 — Phase 1: Generative Onboarding](08-phase-1-onboarding.md).*
