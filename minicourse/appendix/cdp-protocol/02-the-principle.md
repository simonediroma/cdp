# 02 — The Principle

🎬 Video: [`video-prompts.md#02-the-principle`](video-prompts.md#02-the-principle)

---

The CDP's answer to the blind-spot problem is one sentence: **controlled stress-testing through structured adversarial review.**

Unpack that phrase and you get the whole method:

- **Controlled** — not chaos. A round has a defined persona, a soft cap on how many issues it can raise, and a fixed shape for each attack.
- **Stress-testing** — the goal isn't to destroy the spec, it's to find out what's fragile *before* it matters. A spec that survives is not just reviewed, it's hardened — its vulnerabilities are documented, classified, and either resolved or consciously accepted.
- **Structured** — every round follows the same rules of engagement (you'll meet these as R1 and R2 in Lesson 09), regardless of which persona is attacking.
- **Adversarial** — the reviewer's job is to attack, not to help. This is the part people resist, and it's also the part that does the work.

## The enabling condition

None of this is new in spirit — premortems and structured critique have existed for a long time. What makes the CDP practicable without turning into a bureaucratic sign-off process is a single substrate: **an AI layer capable of simulating each persona with enough fidelity to sustain a genuine adversarial round.**

In practice, that means a model roughly at or above Claude Haiku 4.5's capability class. This is a calibration point, not a permanent line in the sand — it will need revisiting as models improve. Without a capable-enough AI substrate, the protocol collapses back into the cost of a human premortem, and loses its reason to exist:

> CDP without AI-personas is agile without a scrum master: possible in theory, unlikely to return value in practice.

## Augmentation, not automation

This AI layer operates in *augmentation* mode, not automation. The human stays in the loop at every decision point that affects the spec. An AI substrate technically capable of running personas but that starts making the author's decisions for them would meet the technical bar above and still violate the protocol. Lesson 04 goes deeper on this distinction — it's the CDP's central design commitment, not a footnote.

## What this principle rules out

If you take "controlled adversarial stress-testing" seriously, a few things follow immediately:

- A single friendly read-through is not a CDP round — no adversarial pressure.
- An AI that rewrites your spec for you is not doing CDP — no human authorship.
- An unstructured "just tell me everything wrong with this" prompt is not R1/R2-compliant — no control.

The rest of this course fills in the procedural detail. This lesson is the principle everything else has to trace back to.

## Check your understanding

- Why does the CDP need a capable AI substrate specifically, rather than just a diligent human reviewer?
- What's the difference between "the AI surfaces problems" and "the AI fixes problems," and why does the protocol insist on the first?

*Next: [03 — Origin and the Meta-Principle](03-origin-and-meta-principle.md).*
