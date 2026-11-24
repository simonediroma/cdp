# 16 — Explainability and the Self-Demolition Case Study

## Explainability by construction

In the augmentation framing from Lesson 04, the demolition history is the explainability artifact: every challenge the spec survived traces back to the persona that raised it, the response that resolved it, and the integrate that applied it. Augmentation requires this — opaque AI decisions break the trust calibration that makes augmentation viable in the first place. The CDP delivers explainability as a *side-effect* of running the protocol, not as a separate audit layer bolted on afterward. Run the manifesto as written, and the audit trail exists automatically: session files, history, and memory get written at every round close because the procedure requires it, not because someone remembered to document things later.

## The self-demolition case study

Lesson 03 introduced the meta-principle: the CDP validates itself. The [constructive demolition protocol plugin](https://github.com/simonediroma/cdp)'s repo *is* the worked example. The canonical artifacts:

- `document/cdp-manifesto.md` — the hardened manifesto, updated at each integrate, versioned alongside its history.
- `document/cdp-foundations.md` — this course's companion source, the "why" to the manifesto's "how."
- `demolition-history.md` — every round, every persona, every vulnerability, every resolution.
- `sessions/session-*.md` — one file per round, the dialogue preserved verbatim.
- `project-memory.md` — the operational memory: bindings, decisions, terminology, current state, next action.

These aren't a sanitized summary written after the fact. They're the live record of the method working on itself — you can open `demolition-history.md` right now and read exactly what a real cycle looked like.

**An external case study remains open work.** The self-demolition proves the method holds on its own text; an independent third-party spec demolished by a different author is the next horizon for external validity. That's a genuine, acknowledged limit of the evidence — not a hidden one.

## What the self-demolition has surfaced

A few patterns recur across cycles, and they may generalize to your own use of the protocol:

- **"The manifesto describes less than the author knows."** Every Critical and Major vulnerability surfaced practice that already existed operationally but was absent from the written text. The protocol pushed implicit knowledge into declarative form — this is often *the* value delivered, not a side benefit.
- **"Architectural promises are diagnostic tests."** Every new top-level commitment immediately surfaced gaps the previous version had been hiding. Making a promise explicit raises the bar the rest of the spec gets measured against.
- **"Stack-agnostic by design."** The CDP describes invariant roles with embodiments parametric to the available stack — this was *discovered* through demolition, not designed in advance.
- **"Operational over philosophical."** The eventual split between the manifesto (how) and this foundations companion (why) was itself a self-demolition outcome: the manifesto had inflated past its own punch-card promise, and the fix was separating the two.

## Check your understanding

- Why does running the manifesto as written produce an audit trail "for free," instead of needing a separate documentation step?
- Pick one of the four recurring patterns above. Where might it show up if you ran the CDP on a spec of your own?

*Next: [17 — Exercise: Bootstrap a Mini Cycle](17-exercise.md).*
