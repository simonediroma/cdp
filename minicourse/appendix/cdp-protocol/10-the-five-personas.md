# 10 — The Five Reference Personas

Each persona represents a real stakeholder that a spec author systematically underweights. One persona per round; one angle of attack per round.

| # | Persona | Angle of Attack | Key Question |
|---|---------|------------------|----------------|
| 01 | The Skeptical User | Implicit assumptions | "Why would I understand this? Why would I care?" |
| 02 | The Dev Implementer | Technical ambiguity | "What exactly am I supposed to build?" |
| 03 | The Business Owner | ROI and priorities | "Why are we building this, and is this the right thing?" |
| 04 | The Future Maintainer | Sustainability | "Will I understand and extend this in 18 months?" |
| 05 | The End User | Real-world usability | "Does this fit into how I actually work?" |

**The Skeptical User** reads as someone unbriefed, uninvested, free to walk away if the document doesn't earn their attention. They surface undefined terms, unevidenced claims, and inferential leaps that feel natural to you and like gaps to everyone else.

**The Dev Implementer** reads as the engineer who'll turn this into running code. They surface ambiguous terminology admitting multiple implementations, missing inputs/outputs, unstated dependencies, and places where the spec contradicts itself if executed literally.

**The Business Owner** reads as someone accountable for outcomes, not for the artifact's elegance. They surface a missing business case, scope exceeding value, and any place the spec explains WHAT without justifying WHY.

**The Future Maintainer** reads as whoever inherits this long after you've moved on. They surface undocumented design rationale, decisions whose reasons vanished, and procedures that only work because you're still in the room.

**The End User** reads as the person who lives with this day to day. They surface friction you didn't anticipate, prerequisites assumed but not stated, and language addressing an idealized user who isn't the real one.

## Why five

Five is the point of diminishing returns observed in practice. Fewer than four and stakeholder coverage leaves systematic gaps. More than six and personas start producing redundant critiques with marginal distinctions between them. Five keeps the set diverse without inflating past the point where adjacent profiles attack the same surface.

## These are a reference, not a canon

Renaming two personas to fit a project's context, or adding a sixth for a domain-specific angle, is expected use — not a deviation. Any adaptation gets documented in the demolition history, same as everything else. Custom personas are first-class citizens; to add one:

1. Choose an angle the five references systematically underweight — not a redundant shading of an existing one.
2. Write the system prompt with the same template: role, angle, characteristic questions, mindset, what it surfaces, explicit reference to R1 + R2.
3. Declare severity priorities if the persona has strong opinions on what counts as Critical/Major/Minor for its angle.
4. Append it to the manifesto's `§02` or maintain it in a project `personas.md` — either is fine, but it can't stay implicit.
5. Custom personas inherit R1 + R2 automatically. They don't get to override the rules of engagement.

One distinction worth holding onto: **a persona is not a facilitator.** A persona attacks the spec; a facilitator orchestrates the round (Lesson 09). The two are separate functions even when one LLM session plays both.

## Check your understanding

- Which of the five personas would most likely catch a gap the other four all miss, for a spec you're currently thinking about?
- Design one custom persona for a domain not covered by the five (e.g. compliance, security, support). What's its angle, and what would make it redundant with an existing one instead of genuinely new?

*Next: [11 — Vulnerability Severity](11-vulnerability-severity.md).*
