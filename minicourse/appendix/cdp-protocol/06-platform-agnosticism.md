# 06 — Platform Agnosticism

The CDP is platform-agnostic by design, and that's a deliberate value commitment — not an accident of how it happened to get built.

Tying a method to one vendor (Claude, OpenAI, Google) or one product (a specific plugin, a specific chat app) creates two dependencies the protocol doesn't need: **vendor lock-in** (the method dies if the vendor changes terms) and **stack drift** (the method becomes unrunnable as the product evolves). The CDP is built to outlive both. It runs on any LLM that satisfies one operational fork: folder read/write access, OR a context window large enough to hold everything in one session — regardless of vendor.

## The plugin is a shortcut, not a dependency

This matters directly for you as a user of `claude-cdp`: **removing the plugin removes convenience, not capability.** Removing one LLM and substituting another removes a vendor, not the protocol. The manifesto (`document/cdp-manifesto.md`) is the actual source of truth; everything an LLM needs to execute the protocol is written into it.

## The manifesto as "punch card"

The metaphor that motivated this design: a self-contained instruction set that, fed to any sufficiently capable LLM, instantiates the protocol on that LLM — the way a punch card ran the same program on any compatible machine. For that metaphor to hold, the manifesto has to pass two tests:

- **Self-explanatory** — anything not written in the manifesto cannot be assumed by the LLM running it.
- **Bootstrap from zero** — a fresh LLM session, the manifesto, and an empty folder must be able to start a CDP project end to end, with no other setup.

Lesson 14 gives you exactly this: the actual kickoff prompt and phase-decision logic you'd use to run the CDP on any LLM, with no plugin at all.

## Model selection — you don't need the biggest model

The CDP's value comes from its *structure* — the personas, the rules of engagement, the mediated state transitions — not from raw inference power. A capable mid-tier model (comparable to Claude Sonnet-class, or equivalent Gemini/GPT tiers) is the recommended baseline: lower token cost means more rounds within budget and faster iteration. Flagship models are acceptable and may help on highly ambiguous specs, but they're overkill for routine cycles. This is consistent with Lesson 04's augmentation framing — the AI's mechanical/analytical work doesn't require the largest model; the human's intuitive judgment is the part no model size unlocks anyway.

## Cost is a property of the embodiment, not of the protocol

Because the CDP is platform-agnostic, cost varies with what you run it on: a self-hosted open-weight model can drive marginal cost to near zero; a commercial mid-tier model scales with that vendor's pricing; a flagship model costs more and is usually unnecessary. The CDP itself does not quantify per-round cost — quantifying it would quietly bind the protocol to one pricing regime, which is exactly the lock-in this lesson opened with.

## Check your understanding

- What breaks first if a protocol is tied to one specific product rather than to a portable manifesto — and does the `claude-cdp` plugin avoid that failure mode?
- Why does the CDP recommend a mid-tier model as the default rather than always reaching for the most capable one available?

*Next: [07 — Phase 0: Setup](07-phase-0-setup.md).*
