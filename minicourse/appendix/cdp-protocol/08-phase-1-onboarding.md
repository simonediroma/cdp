# 08 — Phase 1: Generative Onboarding

The CDP is generative before it's adversarial. Phase 1's job is to onboard raw material to a **first-complete-draft** — a spec coherent enough to actually be attacked. Skip this phase and the demolition has no stable target; run it properly and the question "is my spec mature enough to demolish?" mostly disappears on its own.

The CDP is format-agnostic here — it produces and operates on PRDs, user stories, technical designs, essays, policy documents, or plain prose. The five-move pattern below works on any of them.

## The five moves

1. **Scan.** The AI reads everything already in the project folder.
2. **Inventory.** It internally maps the spec's sections as covered / partial / empty.
3. **Interview.** It asks you one question at a time — only on the gaps, never on what's already known. After each answer, it restates its understanding and asks "Correct?" before moving on.
4. **Synthesis.** It composes a complete draft, marking residual gaps explicitly as `[TO BE DEFINED]`. Inventing content to fill a gap is forbidden — declared emptiness beats fabricated substance, every time.
5. **Confirmation.** It presents the draft and waits for your explicit approval before saving anything.

## The seven questions

The interview is anchored on seven questions, adaptable to whatever kind of artifact you're building:

1. **Objective** — what must the spec produce, enable, or regulate concretely?
2. **Primary reader/user** — who must be able to apply, follow, or execute it?
3. **Secondary reader (conditional)** — is there a relevant secondary reader? If not, say so.
4. **Central claim** — if the reader remembered one thing, what should it be?
5. **Differentiation** — what's demonstrable today that sets this apart from adjacent alternatives — not what you wish were true?
6. **Operational context** — what environment or domain will this run in?
7. **Constraints** — legal, technical, budget, timing, form. If none, say so.

Domain-specific versions of these seven exist (marketing, engineering, policy), but they adapt the seven — they don't replace them.

## The `[TO BE DEFINED]` policy

A first-complete-draft is "complete" the moment every required section is either filled in or explicitly marked `[TO BE DEFINED]`. Hidden gaps are forbidden. Declared gaps are required. The signal that Phase 1 is done is the *absence of unmarked emptiness* — never the presence of full content. A spec with three sections marked `[TO BE DEFINED]` and nothing hidden is more "complete," in the CDP's sense, than one that looks full but quietly glossed over something the author didn't actually know.

## Augmentation, again

The AI does the mechanical/analytical moves here — scanning, inventorying, drafting. You do the intuitive moves — answering the seven questions, making the differentiation claim, giving final approval. An AI that answers its own questions isn't onboarding you; it's fabricating a spec on behalf of an absent author, which the `[TO BE DEFINED]` policy exists specifically to forbid.

## Check your understanding

- Why is a spec with declared gaps considered more "complete" than one with none visible?
- If the AI proposes wording for your differentiation claim because you hesitated, what part of the protocol does that violate, and why?

*Next: [09 — Phase 2: Demolition — R1, R2, the Facilitator](09-phase-2-demolition.md).*
