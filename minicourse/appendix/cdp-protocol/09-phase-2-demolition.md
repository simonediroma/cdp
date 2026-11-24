# 09 — Phase 2: Demolition — R1, R2, the Facilitator

Phase 2 is where the spec gets attacked. Two rules govern *every* round, no matter which persona is firing.

## R1 — Soft cap of about five vulnerabilities per cycle

Quality over quantity. A persona that surfaces five sharp issues does more demolition than one that surfaces ten diluted ones. If a persona's internal read of the spec produces more than five candidates, it stops before firing the sixth and asks you: explore the extras in this same cycle, or defer them to a follow-up cycle with the same persona on the next spec version?

The default behavior is to **ask, not assume**. Five is not empirically derived — like the round-count default in Lesson 13, it's a starting convention chosen to keep iterations lean and to prioritize breadth across personas over exhausting one angle. Nothing is lost to the cap; issues over five are only resequenced, never dropped.

## R2 — Short critique, sharp question

The center of gravity of every attack is the question — that's what forces you to actually think, rather than skim and nod. Long monologues bury the question, and a buried question is a lost one. Each attack has one shape:

- One or two sentences stating the issue
- At most one short paragraph of context, evidence, or consequence (three to five sentences)
- A single direct question naming exactly what you must defend, justify, or rewrite

The question is the payload. Everything around it is the wrapper — and the wrapper should be thin.

## The facilitator role

R1 and R2 are enforced by a **facilitator**, a role distinct from the persona doing the attacking. The facilitator is the custodian of round state: it counts vulnerabilities, applies the R1 soft cap, enforces R2's form, mediates state transitions, and writes the round to history. This role can be a human acting like a scrum master, or an AI orchestrator (the `claude-cdp` plugin's `/cdp:demolish` skill plays this role). The responsibility is invariant; who embodies it is not. A persona attacks; a facilitator orchestrates — two separate functions, even when the same LLM session plays both.

## The five steps of a round

- **00 — Open the round.** Create the session file before selecting a persona. This is the round's verbatim, incrementally-updated record.
- **01 — Select the persona(s)** attacking this round.
- **02 — Run the round.** One round = one persona. Each round is followed by `/integrate` *before* the next persona loads — rounds are never batched, so you stay in continuous authorship instead of supervising a pile of accumulated findings.
- **03 — Triage and resolve.** Critical vulnerabilities block progress. Major vulnerabilities require a written acceptance decision. Minor ones go to the backlog. Every state transition — open to resolved — is mediated: the persona attacks, you respond, the facilitator assesses whether the response is exhaustive, and you confirm. **Silence does not resolve a vulnerability. An unconfirmed assessment doesn't either.**
- **04 — Declare demolition-complete**, when Lesson 13's exit criteria are met (or earlier, if you choose to close on your own authority).

## Check your understanding

- Why does R1 ask "explore now or defer?" instead of just silently dropping the sixth vulnerability?
- What's the practical difference between a persona's "attack" and a facilitator's "mediation" in step 03 — and why can't the persona resolve its own attack?

*Next: [10 — The Five Reference Personas](10-the-five-personas.md).*
