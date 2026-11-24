# 04 — A New CDP Cycle Against an Existing Product

Adding a feature to a live product still starts with `/cdp:onboarding → /cdp:persona → (/cdp:demolish → /cdp:integrate) × N`, exactly as Course 1 Lessons 05-06 described. Nothing about those commands' mechanics changes. What changes is the *context* the cycle runs in — and one genuinely new use for `architecture-context.md` that Course 1 never needed.

## Feasibility becomes a live question

In GREENFIELD, "is this feasible?" is mostly a stack question — Course 2's spec-to-code chooses a stack and flags it as an assumption. In FEATURE-ADDITION, feasibility is a *codebase* question: does the existing auth module already support what this feature needs, or does it require a rewrite disguised as an addition? This is exactly where `architecture-context.md` earns a second job beyond feeding `/cdp:spec-to-code` — during demolition, a persona attacking from a technical angle (your Dev Implementer custom persona, Course 1 Lesson 06) can check claims in the new feature's spec against what the architecture context says actually exists. A claim like "this integrates with the existing notification system" is either true or false, and the architecture context is what makes it checkable instead of aspirational.

## Scoping the spec to the feature, not the product

Practically: you write a new spec for the feature, not a revision of some master spec covering the whole product — the plugin's onboarding/demolish/integrate loop operates on one `project-spec.md` at a time, and neither the manifesto nor the plugin currently prescribes how to manage several feature specs living alongside a shared architecture context. A workable convention, since none is enforced for you: keep the feature's spec and its own `demolition-history.md`/`cdp-memory.md` in a scoped location (a feature branch's working folder, or a clearly named session), and treat `architecture-context.md` as the one file that's genuinely shared across every feature cycle you run against this product.

## What doesn't need to change

Persona selection, the demolition round's mechanics, integrate's cascade-checking and versioning — all identical to Course 1. If you built custom personas modeled on the manifesto's five generic ones, reuse them here unchanged; a Dev Implementer persona doesn't need a new definition to attack a feature spec instead of a greenfield one; it needs `architecture-context.md` in its reading material to attack it *well*.

## Check your understanding

- What new kind of claim can a demolition persona check once `architecture-context.md` exists, that it couldn't check in Course 1?
- Why is scoping each feature to its own spec (rather than one evolving master spec) the practical default here, even though the plugin doesn't enforce it?

*Next: [05 — `/cdp:spec-to-code` in FEATURE-ADDITION Mode](05-spec-to-code-feature-addition.md).*
