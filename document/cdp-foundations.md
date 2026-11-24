---
title: CDP — Foundations Companion
subtitle: "v3.1 — Origin, Meta-Principle, Augmented Humans, References"
version: "3.1"
created: 2026-04-25
last_updated: 2026-07-02
version_history:
  - version: "3.1"
    date: 2026-07-02
    notes: "Integrate cycle 1 (persona: The Skeptical User) — qualified F2's 'without fail' claim with its real evidence base (single-author, three domains); anchored F4's 'sufficient fidelity' to a Claude Haiku 4.5-or-superior calibration reference, cross-referenced to §F6."
  - version: "3.0"
    date: 2026-04-30
    notes: "Prior hardened version, converted from CDP-foundations-v3.0-desktop.pdf."
type: foundations
companion: project-spec.md (CDP v10.1+)
---

# CDP — Foundations Companion

## v3.1 — Origin, Meta-Principle, Augmented Humans, References

Companion to project-spec.md — the CDP Manifesto (CDP v10.1+)
2026-04-25

## Constructive Demolition Protocol — Foundations Companion

Companion to the operational manifesto. The manifesto — hereafter the **CDP Manifesto** (`project-spec.md`) — tells the LLM and the author how to run the CDP. This document tells the human reader why — origin, recursive meta-principle, philosophical problem-statement, augmented humans positioning, the principle the protocol enacts, scope of application, platform-agnosticism rationale, methodological positions, explainability framing, self-demolition case study, and academic anchoring. The two are read together but executed separately: an LLM running the CDP needs only the manifesto; an author wanting to understand what they are operating on benefits from reading this.

---

## F0 — Origin

The CDP emerged from practice, not theory.

The protocol was distilled from work already underway on artifacts of different kinds:

- A **philosophical essay** was the first target. Applying an ad-hoc version of the method improved it materially. That round was the informal prototype from which the CDP was later distilled.
- A **book-writing plugin** was then assembled to codify the approach that had worked on the essay.
- A **first long-form book** was completed using that plugin — the first time the method was run end to end on a non-meta artifact.
- The **CDP itself** was formalized once the pattern held across those three domains.

Each of these artifacts was drafted in isolation by its author. Each exhibited blind spots that only surfaced under structured adversarial pressure. The method now presented as the CDP is the compressed form of what was done in those rounds — not a hypothesis about how specifications should be reviewed, but a report of what reliably happened when they were.

---

## F1 — Meta-Principle: the CDP Validates Itself

The CDP is validated by applying the CDP to itself.

This is not a metaphor. Before this protocol is used on any specification, it must survive its own demolition. Every assumption in the manifesto has been stress-tested by the personas it defines. Every exit criterion has been challenged by the perspectives it canonizes.

If the CDP cannot withstand its own method, it does not deserve to exist.

This is the only recursion that matters.

The self-demolition case study is described in §F9 below; the live demolition history of the CDP self-application lives in demolition-history.md.

---

## F2 — The Problem

Across domains, specifications drafted in isolation reliably exhibit blind spots.

The pattern is documented across the artifacts referenced in §F0: a philosophical essay, a long-form book, and the CDP itself all looked complete to their author and all missed systematically in ways the author could not see. The failure is not random — it has a predictable shape, which is the object of the method.

What an author intended often becomes visible only under adversarial pressure. A specification written in one sitting reads complete to the person who wrote it — yet the moment a structured attack forces articulation, gaps, ambiguities, and unexamined commitments surface without fail. This pattern has held, so far, across three domains applied by the same author — a philosophical essay, a long-form book, and the CDP itself (§F0) — not yet across independent authors. Third-party validation remains open future work (§F9). The CDP is the mechanism that forces that articulation. It is not a theory of why authors miss things; it is a procedure for making the missing parts visible. The soul of the method is not diagnosing cognition — it is running the process, responding to each challenge by reasoning and integrating what was written, until the text becomes progressively more intelligible to readers who do not share the author's head.

Peer review works — when it is someone's specific job. Scientific journals, regulated industries, and paid editorial pipelines give reviewers the time and attention an artifact deserves. Outside those substrates, the typical author — of an essay, a book, a product specification written solo — asks friends and colleagues for review and rarely obtains one of the required depth. Favors are not the right currency for sustained adversarial attention.

The CDP does not replace institutional review. It fills the gap where no institution exists, and in that gap it catches what informal review reliably misses: not only errors of commission — things that are wrong — but errors of omission — things that were never written because they were never considered.

By the time these blind spots surface, the cost is high: wasted development cycles, misaligned expectations, products that solve the wrong problem.

> "Demolish your specification before reality does. What survives the demolition is worth building."

---

## F3 — Positioning: Augmented Humans, not Agentic Replacement

The CDP is built for augmented humans, not for autonomous agents with humans in the loop.

> "The combination of humans and AI can yield more effective results compared to the separate performance of each component alone." — Loske & Klumpp, 2021

The augmented humans paradigm holds that hardware and software should be grafted onto human capacity to enhance lived and working experience — extending what a person can do without removing them from the doing. It contrasts deliberately with the full-agentic-with-human-in-the-loop drift, where systems act and humans supervise, approve, or correct at the margins.

The CDP sits squarely in the augmented humans frame. The author writes the spec. The AI personas surface what the author missed. The author responds, decides, and integrates. The protocol does not attempt to author specs autonomously, nor does it relegate the author to a verification role. Authorship and judgment remain with the human; the AI provides the structured adversarial pressure that informal review reliably fails to deliver.

**Proximity level — Interdependency.** In Sowa et al.'s typology (2021) — Competition → Supplementation → Interdependency → Hybrid — the CDP operates squarely at the Interdependency level: human and AI are mutually dependent. The persona has nothing to attack without the author's spec; the author cannot see their own blind spots without the persona's structured pressure. Neither side produces the hardened spec alone. The protocol is not a step toward Hybrid (a fused intelligence with no separable authorship) — it deliberately holds at Interdependency to preserve human authorial responsibility.

**Role distribution.** In Siemon's typology of AI team roles (2022), the CDP assigns:

- The **persona-as-AI** plays Creator — generating critiques, surfacing what the author did not see.
- The **facilitator-as-AI** plays Coordinator + Perfectionist — orchestrating rounds, enforcing R1/R2, mediating state transitions, writing the demolition history.
- The **human author** plays none of these. The author judges — answers each question, accepts or rejects each finding, declares the spec hardened.

Mapped to Huang & Rust's intelligence types (2018): the AI handles Mechanical work (counting, scanning, logging) and Analytical work (pattern detection in attacks, structured drafting); the human handles Intuitive judgment — context, claim, differentiation, final approval. The CDP does not invert this division; protocols that do invert it have crossed from augmentation into automation-with-supervision, which is a different system with different risks.

Two operational outcomes follow:

- **Reduced elaboration time.** What would take weeks of asynchronous peer review compresses into hours of structured demolition.
- **Increased accuracy.** Blind spots that would surface only at execution time are forced into visibility at spec time, raising the quality of what gets built and the precision with which it is executed.

Better specs, faster, without surrendering authorship — that is the value the CDP returns to the augmented human who runs it.

The empirical and conceptual grounding is summarized in Nguyen & Elbanna (2025); see §F10 for full references.

---

## F4 — The Principle

Controlled stress-testing through structured adversarial review.

The CDP applies deliberate, structured pressure to a specification through a sequence of demolition rounds. Each round attacks the spec from a different perspective — a persona drawn from the reference set, with a defined angle of critique. The goal is not to destroy the specification. It is to reveal what is fragile so it can be made robust before a single line of code is written. A spec that survives the CDP is not just reviewed — it is hardened. Its vulnerabilities are documented, classified, and either resolved or consciously accepted.

**The enabling condition.** The CDP is bureaucracy-free by design — no institutional roles, no sign-off meetings, no approval chains. Its practicability rests on a single substrate: an AI layer capable of simulating each persona with fidelity sufficient to sustain an adversarial round. In practice, "sufficient fidelity" is approximated by models comparable to or exceeding Claude Haiku 4.5 — the same reference class used in §F6 for model selection. This is a calibration point, not a permanent threshold: it will need revisiting as models improve. Without that substrate the protocol collapses to the cost of a human premortem and loses its reason to exist.

> CDP without AI-personas is agile without a scrum master: possible in theory, unlikely to return value in practice.

This AI layer operates in augmentation mode, not automation — the human remains in the loop at every decision point that affects the spec, consistent with §F3. An AI substrate that replaces the author's authorial decisions would meet the technical condition stated above and still violate the protocol.

The operational consequences of this principle — the procedural steps, the rules of engagement, the role distinctions, the sequencing — live in the CDP Manifesto (project-spec.md §01).

---

## F5 — Scope

Where the CDP applies, and where it does not.

The CDP targets textual artifacts that aim to describe or prescribe something coherently — product specifications, philosophical or argumentative essays, long-form books, policy and procedural documents, methodological manifestos. The common property is simple: the artifact is a text that an external reader — human or simulated — can read end to end and attack on its own terms.

The CDP does not apply to problems whose bottleneck lies in physical action or material-world execution rather than in the quality of a text. Repairing a washing machine, performing a surgical procedure, or running a one-shot operational maneuver is not a CDP target — there is no specification to harden, only an action to perform. Applying the CDP outside its domain produces ceremony without value.

### The two frontiers of non-applicability

Two frontiers bound the operational scope of the CDP, and on both sides applying the protocol produces ceremony rather than hardening:

- **Too late to harden.** A specification finalized externally — regulated, signed, deployed, frozen by mandate — has no remaining generative window. The protocol can technically run, but only retroactively as a next-time lesson; no current-artifact hardening follows. The value moment has passed. The CDP is a preventive protocol, not a corrective one — it captures value during the generative life of a specification, while the artifact is still being shaped.
- **Too small to harden.** An artifact below a minimum substrate of complexity does not give the five reference personas distinct surfaces to attack. The author's intuitive example: an epic can be hardened; a single 1-story-point task cannot. Below the threshold, the protocol's structural diversity collapses into redundancy: five personas attacking the same surface produce variations on the same critique rather than five distinct angles.

In both cases the operational test is the same: if the proposed run produces ceremony rather than hardening, decline. The thresholds — what counts as "finalized", what counts as "below substrate" — are not legislated by the protocol; they are the author's call, sized to the artifact and the stakes. The asymmetric example (epic vs. 1-story-point) gives a useful intuition for the lower frontier; the finalized-externally test (regulated, signed, deployed) gives one for the upper frontier.

Some cases sit at the edge of the textual domain — trivial bugfixes, pre-MVP exploratory drafts, real-time incident response — where the CDP may be excessive, premature, or simply too late. These edge cases are subsumed by one of the two frontiers above: too small, or too late.

---

## F6 — Platform Agnosticism: Rationale

The CDP is platform-agnostic by design — and that is a deliberate value commitment, not a technical accident.

Tying a method to a specific vendor (Claude, OpenAI, Google) or a specific product (Cowork, Projects, custom GPTs) creates two dependencies the protocol does not need: vendor lock-in (the method dies if the vendor changes terms) and stack drift (the method becomes unrunnable as the underlying product evolves). The CDP is structured to outlive both. It runs on any LLM that satisfies the operational capability fork declared in the CDP Manifesto (project-spec.md) §01 Phase 0 — folder R/W access OR sufficient context window — regardless of vendor.

**The plugin as shortcut.** The plugin cdp automates the standard workflow but is not a prerequisite. Removing the plugin removes convenience, not capability; removing one LLM and substituting another removes a vendor, not the protocol. The manifesto itself is the source-of-truth instruction set; everything the LLM needs to execute the protocol is in it.

**The manifesto as punch card.** The metaphor that motivated the platform-agnosticism declaration: a self-contained instruction set that, when fed to a sufficiently capable LLM, instantiates the protocol on that LLM. The manifesto must therefore satisfy two operational tests, declared in the CDP Manifesto (project-spec.md) §01 Phase 0:

- **Self-explanatory** — anything not in the manifesto cannot be assumed by the LLM.
- **Bootstrap from zero** — a fresh LLM session + the manifesto + an empty folder must be able to start a CDP project end to end.

**Model selection — rationale.** The CDP does not require the largest or most expensive model. The protocol's value comes from its structure — the personas, the rules of engagement, the mediated state transitions — not from raw inference power. A capable mid-tier model (Claude Sonnet 4.6, comparable Gemini and GPT tiers) is the recommended baseline: lower token cost translates directly into more rounds within budget, faster iterations, and a more sustainable adoption curve. Flagship models (Claude Opus 4.7) are acceptable and may help on highly ambiguous specs, but they are overkill for routine cycles. This is consistent with the augmentation positioning of §F3 — the AI handles mechanical and analytical work, which mid-tier models perform well; the human handles intuitive judgment, which no model size unlocks.

**Cost as a property of the embodiment.** Because the protocol is platform-agnostic, cost is a property of the embodiment chosen — local self-hosted models can drive marginal cost to zero, commercial vendors scale with their pricing tiers. The CDP itself does not quantify per-round cost; the rationale is articulated alongside the other non-prescribed dimensions in §F7 — On cost.

The CDP is the manifesto, executed on any LLM, by any human.

---

## F7 — Methodological Positions

The manifesto declares procedures; this section declares the methodological positions that explain why certain procedures are not prescribed in detail. These positions matter because they protect the CDP from over-fitting to a single domain and from inflating into prescriptions it cannot honor across artifacts.

**Five non-prescribed dimensions.** The CDP deliberately refuses to legislate five dimensions of its own operation. Each is declared by the author or the organization, sized to the artifact and the context, and where a protocol-level signal exists it is observational, not prescriptive. The five are:

- (a) the substantive rubric of hardened;
- (b) the duration of a single round;
- (c) the cost per round;
- (d) the number of rounds required;
- (e) the total time-to-value of the project.

Across all five, the CDP refuses to legislate cross-domain because doing so would distort at least one domain. The blocks below describe each.

### On the hardened-state rubric

The four exit criteria of the CDP Manifesto (project-spec.md) §04 are procedural — they confirm that the method has been executed end to end. They do not prescribe what "hardened" looks like substantively for a given artifact, because the standard of robustness required for a software specification, a policy document, a philosophical essay, or a long-form book differs in kind, not only in degree. A universal rubric would either dilute to meaninglessness or distort at least one domain.

The author therefore declares, at exit, the context-specific criteria that make the spec hardened for its intended use. Those criteria are logged in the demolition history alongside the resolutions. This is not an omission: the CDP explicitly refuses to legislate what it cannot legislate well.

### On the convergence signal — duration and time-to-value

The time a round takes is a diagnostic output, not a prescribed input. A round that concludes quickly indicates a spec already robust on the angle being attacked; a round that runs long indicates a persona finding substantive material. The same logic extends to the total time-to-value of a project — the elapsed time from first onboarding to declared hardened.

The protocol does not prescribe a calendar duration at either scale. It offers an observational signal: vulnerabilities-per-round trending to zero AND vulnerabilities-per-persona trending to zero. When both metrics saturate near zero across the persona set in scope, the spec is approaching hardened — without budgeting calendar time. Budgeting the CDP in calendar time therefore misstates the primitive: the CDP is scoped by the set of attacks planned and by the convergence of vulnerability rates, not by the clock.

### On cost

The CDP does not quantify per-round cost. The choice of platform makes cost a property of the embodiment, not of the protocol:

- With a **self-hosted local model** (e.g. the Gemma family, Llama, or any open-weight model run on local hardware) the marginal cost of running the protocol approaches zero — no per-token charges, only the amortized cost of hardware and energy.
- With a **commercial mid-tier model** (Sonnet 4.6, comparable Gemini and GPT tiers) cost is a function of the vendor's pricing tier, scaled by token consumption per round.
- With a **flagship model** (Opus 4.7) cost scales linearly with vendor pricing and is typically overkill for routine cycles (see also §F6 — Model selection).

Quantification at the protocol level would bind the CDP to a specific pricing regime and contradict the platform-agnosticism declared in §F6. Cost is therefore a property of the chosen embodiment, not of the protocol.

### On the round count

The number of demolition rounds is not legislated by the protocol. The default of 3 in the CDP Manifesto (project-spec.md) §04 is a starting convention, not an empirically distilled minimum — it is the lower bound the protocol's authors chose for a project running without external policy constraints.

Organizations adopting the CDP at scale can layer their own governance on top of the default — minimum round counts (≥5, ≥7, …), mandatory persona-coverage (specific senior roles such as CEO/CFO/CTO must run a round on the spec), audit attestation requirements, peer-review checkpoints. The CDP welcomes this customization: it is the operational point where corporate philosophy and operational context legitimately interface with the protocol. The same applies to a single-author adopting the CDP without organizational governance — they are free to set their own N, sized to the stakes of their artifact.

---

## F8 — Explainability by Construction

In augmentation terms (§F3), the demolition history is the explainability artifact: every challenge the spec survived is traceable to the persona that issued it, the response that resolved it, and the integrate that applied it. Augmentation requires explainability — opaque AI decisions break the trust calibration that makes augmentation viable. The CDP delivers explainability as a side-effect of running the protocol — not as a separate audit overhead grafted on top.

The canonical artifacts that constitute the audit trail are listed operationally in the CDP Manifesto (project-spec.md) §05.4 Memorization protocol. This section asserts the property that running the manifesto produces explainability without an additional layer; the manifesto operationalizes that property by prescribing the writing of session files, history, and project memory at every round close.

---

## F9 — Self-Demolition Case Study

The first worked example is this project itself.

In accordance with the meta-principle declared in §F1, the CDP has been applied to its own specification. The canonical artifacts of that self-demolition are:

- `project-spec.md` — the hardened operational manifesto, updated at each `/integrate` and versioned alongside its demolition history.
- `cdp-foundations.md` — this document; companion to the manifesto.
- `demolition-history.md` — every round, every persona, every vulnerability, and every resolution that has shaped the spec.
- `sessions/session-*.md` — one file per round, preserving the dialogue verbatim.
- `project-memory.md` — operational memory: bindings, decisions, terminology, current state, next action.

These files are not a sanitized summary written after the fact. They are the live record of the method working on itself.

**An external case study is open future work.** An external worked example — the CDP exercised on a product specification outside this meta-loop — strengthens external validity without blocking current adoption. The method is demonstrable on its own text first; demonstrating it on a third-party spec is the next horizon.

**What the self-demolition has surfaced — recurring patterns.** Across cycles, the CDP applied to itself has produced a small number of patterns that may generalize:

- **"The manifesto describes less than the author knows."** Every Critical and Major vulnerability surfaced practice that already existed operationally but was absent from the text. The protocol pushed implicit knowledge into declarative form.
- **"Architectural promises are diagnostic tests."** Each new top-level commitment (Augmented Humans, Platform Agnosticism, manifesto-as-punch-card) immediately surfaced gaps the previous version had been able to hide. Promises raise the bar against which the rest of the spec is measured.
- **"Stack-agnostic by design."** The CDP describes invariant roles and procedures, with embodiments parametric to the available stack (human-as-scrum-master OR AI-with-plugin; folder-mode OR single-session). This was discovered through demolition, not designed in advance.
- **"Operational over philosophical."** The v7.0 → v8.0 split that produced this companion document, and the v8.0 → v9.0 compression that further reduced the manifesto, were both self-demolition outcomes: the manifesto had inflated past its own punch-card promise. The fix was to separate the how from the why. This document is the why; the manifesto is the how.

---

## F10 — References

The augmented humans positioning of §F3, the role distribution and the explainability framing, are anchored on contemporary IS-research scholarship on human-AI aug