# 17 — Exercise: Bootstrap a Mini Cycle

🎬 Video: [`video-prompts.md#17-exercise`](video-prompts.md#17-exercise)

---

This is a hands-on close to this deep dive — no plugin, just you, any capable LLM, and the manifesto. The goal is to feel the mechanics in your hands, whether or not you also run them through Course 1's `claude-cdp` plugin.

## What you'll need

- Any LLM session capable of holding a few thousand words of context (single-session mode from Lesson 07 — no folder access required for this exercise).
- The text of `document/cdp-manifesto.md` §01, §02, and §05 (paste the relevant sections into the chat).
- A small, real artifact you actually care about hardening — a one-page project pitch, a blog post outline, a short policy proposal. Check it against Lesson 05's scope test first: big enough for five distinct angles, early enough to still change.

## Steps

1. **Run Phase 0.** State your operating mode (single-session, per Lesson 07), confirm the five prerequisites, and name yourself as the single accountable author.
2. **Run Phase 1 by hand.** Paste your draft artifact (or notes toward one) into the chat and ask the LLM to run the five-move pattern from Lesson 08: Scan → Inventory → Interview → Synthesis → Confirmation. Answer the seven questions honestly — don't let the LLM answer for you. Insist on `[TO BE DEFINED]` markers for anything genuinely unresolved.
3. **Pick one persona.** From the five in Lesson 10, choose whichever angle feels most likely to find something real in your artifact. Paste its system prompt into the same session.
4. **Run one demolition round.** Ask the persona to attack, applying R1 (stop before a sixth vulnerability, ask before continuing) and R2 (short critique, one sharp question at a time) from Lesson 09. Answer each question in full — don't let a vulnerability resolve on silence.
5. **Integrate by hand.** For each vulnerability you resolved, write out the original text and your proposed replacement side by side (Lesson 12), and decide MINOR vs. MAJOR for the version bump.
6. **Write the three memory files**, even in miniature: a session note (what happened this round), a one-paragraph demolition history entry, and a `next_action` line for your own future reference.

## What "done" looks like

You should end this exercise with: one demolition round actually run, at least one vulnerability actually resolved and integrated into your text, and three small memory artifacts you wrote yourself. You don't need to hit the full exit criteria from Lesson 13 — one honest round is enough to feel the mechanics.

## Reflection

- Where did R1's soft cap or R2's "one sharp question" actually change how the critique landed, compared to an unstructured "what's wrong with this" prompt?
- What did writing the memory files by hand teach you about what the plugin in Course 1 will be doing for you automatically?

---

**This deep dive is complete.** You now know the protocol itself — independent of any tool. If you haven't already, Course 1 picks up from here with the `claude-cdp` plugin: the same mechanics, automated. Course 2 carries it further still, from a frozen spec to a deployed proof of concept.
