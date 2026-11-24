# 05 — Drafting v1.0 with `/cdp:onboarding`

`/cdp:onboarding` is the plugin's concrete answer to "how do I get a first draft down": a guided interview that scans whatever documents already exist in your project folder, works out what's covered versus what's a gap, and asks you about the gaps only — one question at a time, confirming its understanding after each answer before moving on. This is the plugin's version of what Path C in Lesson 02 needs before it can attack anything — you can't demolish a spec that doesn't exist yet.

"Your project folder" means the folder Cowork works in, the directory you started Claude Code in, or — on a cloud session — the repo clone, so commit your documents before starting there. See [Where cdp Runs](../appendix/03-where-cdp-runs.md).

## What it actually asks

The interview itself asks seven questions in generic form — the same wording regardless of whether you're running a marketing campaign, a product feature, or anything else. Right after each question, the plugin shows a "how to read this" insight with a marketing-campaign example and a product-feature example, so you can translate it to your own project before answering:

1. **Objective** — what must this concretely produce, enable, or regulate?
2. **Primary reader/user** — who must be able to apply, follow, act on, or execute it?
3. **Secondary reader/user** (conditional) — is there a relevant one?
4. **Central claim** — if the reader remembered one thing, what should it be?
5. **Differentiation** — what's demonstrable today that sets this apart — not what you wish were true?
6. **Operational context** — what environment, domain, or platform will this run in?
7. **Constraints** — legal, technical, budget, timing, required form

Anything not covered by documents or answers is written as `[TO BE DEFINED]` — never invented. Once you confirm the draft, it's saved as `project-spec.md` v1.0, and `cdp-memory.md` gets a session-log row.

## A narrower gap than it used to be

The seven questions above used to be asked in marketing-only vocabulary ("campaign objective," "target audience," "channels"). That's fixed now — the interview matches the CDP Protocol's generalized wording (Appendix, Lesson 08) and reads the same whether you're describing a campaign or a feature. But the gap isn't fully closed: once you confirm your answers, Phase 2 still synthesizes them into `project-spec.md`'s ten fixed section names — Brand Identity, Target Audience, Campaign/Project Objective, Value Proposition, Message Hierarchy, Tone of Voice, Channels & Touchpoints, Competitive Positioning, Constraints, Declared Limitations — and the `persona` and `demolish` skills still classify every vulnerability using marketing-flavored categories (`audience-fit`, `channel`, `hierarchy`, `tone`...). The manifesto describes the CDP as format-agnostic; the plugin, as shipped, is generic at the interview but still marketing-shaped everywhere downstream of it. The [cdp claude plugin](https://github.com/simonediroma/cdp)'s repo documents the remaining gap in `document/plugin-alignment-review-v10.1.md` — worth reading once so you're not surprised by it mid-project.

For a software PoC, you have two honest paths:

- **Translate loosely.** Answer the seven questions plainly as a builder — the "how to read this" callouts already do most of the translation for you. When you get to the saved `project-spec.md`, read its section headers as their software equivalents: "Target Audience" → your primary user, "Channels & Touchpoints" → the platforms/interfaces it runs on, "Message Hierarchy" → the core claim and what supports it. Same when a demolition persona flags an `audience-fit` or `channel` vulnerability — read it as "does this actually reach the user" or "does it work in the environment it runs in." This is the fast path and works fine for a PoC.
- **Write your own PRD and skip straight to spec-to-code.** `/cdp:spec-to-code` (Course 2, Lesson 01) only requires *a PRD* — `.md`, `.txt`, `.pdf`, or `.docx` — it does not require that PRD to have come from `/cdp:onboarding` or to use the ten marketing section names. If you'd rather write a plain PRD by hand (objective, primary user, critical flows, constraints — see the [Appendix's CDP Protocol deep dive](../appendix/cdp-protocol/00-index.md), Lesson 08, for the seven generic questions) and demolish it using the five generic personas from the manifesto instead of the plugin's six marketing ones, that's fully supported — you just run Lesson 06 manually instead of through the marketing-shaped commands.

This course uses the first path (translate loosely) because it's faster to teach and matches how the plugin behaves out of the box. If your PoC's shape doesn't bend to the marketing vocabulary at all — even just at the section-header and vulnerability-category level — use the second path. Nothing downstream breaks either way, since `/cdp:spec-to-code`'s actual requirement is just "a hardened PRD," not a specific template.

## Check your understanding

- The onboarding interview no longer asks about "channels" or "audience" by name — so where does marketing vocabulary still show up in the pipeline, and why does that mean the gap is narrower rather than gone?
- What's the minimum requirement `/cdp:spec-to-code` actually has for its input — and why does that requirement give you an escape hatch from the marketing template?

*Next: [06 — Hardening the Draft: Personas, Demolition, Integration](06-hardening-personas-demolition-integration.md).*
