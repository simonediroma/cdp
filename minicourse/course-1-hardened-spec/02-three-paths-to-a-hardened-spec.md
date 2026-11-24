# 02 — Three Paths to a Hardened Spec

🎬 Video: [`video-prompts.md#02-three-paths-to-a-hardened-spec`](video-prompts.md#02-three-paths-to-a-hardened-spec)

---

Lesson 01 named the problem: a spec nobody attacked has blind spots, and a not-organized draft is the fastest way to produce exactly that kind of spec. This lesson is about the fix — and there's more than one legitimate way to apply it. Nothing here says you must use the tool this course goes on to teach hands-on; it says you must do *something* structural instead of trusting a single draft.

## Path A — Solo iteration against a checklist

The lightest version: you write the draft, then deliberately re-read it against a fixed list of questions you didn't think of while writing — "what happens if this input is empty," "who is the actual first user, not the ideal one," "what did I assume without saying so." This costs nothing but discipline, and it catches real gaps. Its ceiling is structural: you're still the only perspective in the room, so it can't catch what you personally can't imagine being wrong about. Good for something small enough that a second contributor or a long lifespan were never on the table (Lesson 07 of this course's exercise is exactly this kind of project, done properly instead of skipped).

## Path B — Structured templates and frameworks

Borrow a shape someone else already stress-tested by using it many times: a PRD one-pager (objective, users, non-goals, success metric), an Amazon-style six-pager, or a Shape Up-style pitch (problem, appetite, solution, rabbit holes, no-gos). These frameworks don't attack your spec — they force you to fill in sections that are easy to skip when writing free-form, which surfaces some gaps by omission alone. They're fast, well-documented elsewhere, and worth using even as a first pass before either of the other two paths. Their limit: filling in a section doesn't mean what you wrote there is actually correct or complete — a template guarantees coverage of topics, not adversarial pressure on the content.

## Path C — Adversarial, structured demolition

The heaviest and most thorough path: don't just check your own draft, attack it — deliberately, from more than one angle, following fixed rules so the attack stays productive instead of becoming either a rubber stamp or an unfocused pile-on. This is **controlled stress-testing through structured adversarial review**, and it's the principle behind the Constructive Demolition Protocol (CDP), the method this course teaches hands-on from here forward:

- **Controlled** — a round has a defined persona, a soft cap on how many issues it raises, and a fixed shape for each attack
- **Stress-testing** — the goal isn't to destroy the spec, it's to find what's fragile before it matters
- **Structured** — every round follows the same rules of engagement, regardless of which angle is attacking
- **Adversarial** — the reviewer's job is to attack, not to help — this is the part people resist, and the part that does the work

CDP needs one enabling condition the other two paths don't: an AI layer capable of simulating an attacking persona with enough fidelity to sustain a genuine adversarial round — roughly Claude Haiku 4.5's capability class or above. Without that substrate the protocol collapses back into the cost of a human premortem and loses its reason to exist. With it, CDP runs in *augmentation* mode, not automation: the AI attacks, you decide. An AI that rewrites your spec for you instead of attacking it isn't doing CDP.

## Why this course teaches CDP specifically

All three paths produce a legitimate hardened spec. This course picks CDP for the rest of Chapters 1-4 because it's the one the `claude-cdp` plugin automates end to end — the mechanical bookkeeping (tracking which persona attacked what, logging resolutions, bumping versions) is exactly the kind of thing worth automating, and Lesson 03 onward shows you that automation concretely, starting with the plugin's own onboarding skill.

Nothing downstream requires it, though. `/cdp:spec-to-code` (Chapter 2) only needs a frozen PRD — it doesn't check whether that PRD survived CDP rounds, a checklist pass, or a Shape Up pitch review. If Path A or B already gets you a spec you trust, skip straight to Chapter 2 with it. If you want the full mechanics of CDP — the five reference personas, the severity scale, the exit criteria, how to run it by hand with no plugin at all — the [Appendix's CDP Protocol deep dive](../appendix/cdp-protocol/00-index.md) is the complete reference; this course only teaches what you need to run it through the plugin.

## Check your understanding

- What does a structured template guarantee, and what does it *not* guarantee, about the spec you fill it into?
- Why does CDP specifically require a capable AI substrate, while Paths A and B don't?

*Next: [03 — Installing the Plugin](03-installing-the-plugin.md).*
