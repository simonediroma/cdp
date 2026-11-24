---
title: "Appendix — The CDP Protocol In Depth"
audience: Anyone hardening a spec — product, essay, book, policy — with any LLM, plugin or not — who wants the full mechanics behind Course 1's brief introduction
depends_on: "Course 1, Lesson 02 (introduces CDP as one of three paths to a hardened spec) — read this if you picked that path and want the complete method"
---

# Appendix — The CDP Protocol In Depth

## What this is

The Constructive Demolition Protocol (CDP) is a method for finding the blind spots in a specification before reality does. Course 1, Lesson 02 introduces it briefly as one of three legitimate paths to a hardened spec, then teaches it hands-on through the `claude-cdp` plugin. This appendix is the full protocol underneath that brief introduction — the manifesto and its rationale, independent of any tool. Everything here works whether you run it by hand in a plain chat with any capable LLM, or with the plugin Courses 1–4 teach.

**The CDP is domain-agnostic by design.** It targets any textual artifact meant to describe or prescribe something coherently — a software PRD, a marketing campaign brief, a philosophical essay, a long-form book, a policy document, a methodological manifesto (this one, in fact — see Lesson 03). It is not a software tool that happens to also work elsewhere; it has no privileged domain at all. Course 1 happens to apply it to software specs, and the plugin's own `project-spec.md` structure and `persona`/`demolish`/`integrate` skills happen to still be shaped like a marketing template today (the onboarding interview itself is generic; what it produces isn't yet — a known, documented gap, Course 1 Lesson 05 covers it) — neither of those facts narrows what the *protocol itself*, taught in this deep dive, actually applies to. Lesson 05 spells out the two real boundaries (too small to harden, too late to harden) — and notice that neither of them is "wrong kind of project."

If you only ever use the plugin, you don't need this deep dive — Course 1 teaches everything the plugin's commands require. Read this when you want to understand *why* those commands behave the way they do, run CDP by hand with no plugin at all, or apply it to something that isn't software.

## What you'll be able to do

By the end of this deep dive you will be able to:

- Explain why specs drafted in isolation reliably have blind spots, and why the CDP's answer is structural rather than a checklist
- Run the two phases of the protocol — generative onboarding, then adversarial demolition — on any artifact, with or without a plugin
- Use the five reference personas (and know when to write a sixth)
- Apply the two rules of engagement (R1 soft cap, R2 short-critique-sharp-question) and tell persona work from facilitator work
- Triage vulnerabilities by severity and know what each severity obligates you to do
- Recognize the four exit criteria and declare a spec hardened
- Bootstrap the entire protocol from scratch on any LLM, using only the manifesto text

## Lessons

| # | Lesson | Manifesto anchor |
|---|--------|-------------------|
| 01 | [The Problem](01-the-problem.md) | F2 |
| 02 | [The Principle](02-the-principle.md) | F4 |
| 03 | [Origin and the Meta-Principle](03-origin-and-meta-principle.md) | F0, F1 |
| 04 | [Augmented Humans, Not Agentic Replacement](04-augmented-humans.md) | F3 |
| 05 | [Scope — When to Use It, When Not To](05-scope.md) | F5 |
| 06 | [Platform Agnosticism](06-platform-agnosticism.md) | F6 |
| 07 | [Phase 0 — Setup](07-phase-0-setup.md) | §01 Phase 0 |
| 08 | [Phase 1 — Generative Onboarding](08-phase-1-onboarding.md) | §01 Phase 1 |
| 09 | [Phase 2 — Demolition: R1, R2, the Facilitator](09-phase-2-demolition.md) | §01 Phase 2 |
| 10 | [The Five Reference Personas](10-the-five-personas.md) | §02 |
| 11 | [Vulnerability Severity](11-vulnerability-severity.md) | §03 |
| 12 | [Integrating Resolutions](12-integrating.md) | §01 Phase 2 step 04, §05.6 |
| 13 | [Exit Criteria and the Convergence Signal](13-exit-criteria.md) | §04 |
| 14 | [Manual Bootstrap on Any LLM](14-manual-bootstrap.md) | §05 |
| 15 | [The Five Non-Prescribed Dimensions](15-non-prescribed-dimensions.md) | F7 |
| 16 | [Explainability and the Self-Demolition Case Study](16-explainability-and-case-study.md) | F8, F9 |
| 17 | [Exercise — Bootstrap a Mini Cycle](17-exercise.md) | — |

## Source material

This deep dive is a teaching layer over two primary documents in the [cdp claude plugin](https://github.com/simonediroma/cdp) repo — it doesn't replace them:

- `document/cdp-manifesto.md` — the operational manifesto (the "how")
- `document/cdp-foundations.md` — the foundations companion (the "why")

Where a lesson makes a claim, it cites the section (`§` for the manifesto, `F` for foundations) so you can go read the source directly.

## Unfamiliar term?

Check [`../01-glossary.md`](../01-glossary.md) and [`../02-useful-resources.md`](../02-useful-resources.md).
