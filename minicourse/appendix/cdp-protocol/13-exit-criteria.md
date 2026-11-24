# 13 — Exit Criteria and the Convergence Signal

A spec is demolition-complete when all four of these are true:

- [ ] It has completed at least **N** demolition rounds, where one round = one persona-cycle followed by its integrate. N defaults to **3**, fully configurable at project or organization level.
- [ ] It has **zero open Critical vulnerabilities**.
- [ ] All open **Major** vulnerabilities have been explicitly accepted by the spec owner, with written rationale.
- [ ] A **demolition history** document exists, recording every round, every finding, and every decision.

## The default of 3 is a floor, not a target

N=3 is not empirically derived — it's the lower bound the protocol's authors chose for a project running without external policy constraints. Organizations adopting the CDP at scale can layer their own governance on top: minimum round counts (≥5, ≥7…), mandatory persona coverage (a named senior role must run a round), audit attestation requirements. A single author without organizational governance is equally free to set their own N, sized to the stakes of what they're writing. The CDP welcomes this customization — it's the point where organizational policy legitimately meets the protocol, rather than a corner the protocol left unfinished.

## Two paths to closure — both routed through the author

- **Author-initiated (anytime).** You can declare demolition-complete at any point — even before all four criteria are met — by writing the sign-off and updating the spec's frontmatter (`status: hardened`, `hardened_by`, `hardened_trigger: author-initiated`).
- **AI-proposed (when the threshold is reached).** When the facilitator detects all four criteria are satisfied, it *proposes* closure — you confirm or extend with more cycles. On confirm, the same frontmatter is written with `hardened_trigger: ai-proposed`.

In both paths, **the author is the only signatory.** The AI never closes unilaterally. This carries real weight: declaring closure is an authorial act, and the protocol does not — by design cannot — stop you from declaring it without having actually earned it. Human judgment is the final arbiter throughout the CDP, for better or worse.

## The convergence signal (a heuristic, not a fifth criterion)

Beyond the four procedural criteria, there's an observational signal for *approaching* hardened: **vulnerabilities-per-round trending to zero AND vulnerabilities-per-persona trending to zero.** When both saturate near zero across your persona set, the spec is converging — without needing to budget calendar time to get there. A round that concludes fast tells you the spec is already robust on that angle; a round that runs long tells you the persona found something substantive.

## Check your understanding

- Why does the protocol let an author declare closure *before* all four criteria are met, instead of hard-blocking on them?
- What would it mean, practically, if your vulnerabilities-per-round count was still high after 5 rounds with different personas — what does that tell you about the spec, versus about the round count?

*Next: [14 — Manual Bootstrap on Any LLM](14-manual-bootstrap.md).*
