---
course: 5
title: "The Capstone — Hello World, Hands-On"
audience: Anyone who finished Courses 1-4 and is ready to run the whole loop themselves, on an app small enough to build in an afternoon
depends_on: "Course 2 (required) — Course 1 recommended for onboarding/persona/demolition mechanics; Course 3 and 4 not required, referenced only in passing"
---

# Course 5 — The Capstone: Hello World, Hands-On

## What this course is

Courses 1-4 taught four separate moments of the same method: hardening a spec, shipping a PoC, extending a live product, fixing what breaks. Each course taught its mechanics by walking you through an example someone else built, then closed with an Exercise lesson pointing you back at your own idea — but compressed into a single checklist covering ground the course had already explained in detail. This course inverts the ratio: it hands you the app category — a **Custom Scorecard** — and then, lesson by lesson, tells you exactly what to run, what to expect, and what decision to make, on the idea *you* bring, with the whole loop built end to end in one continuous sitting instead of spread across four separate Exercises. You do the onboarding interview. You pick the persona. You run the demolition cycle. You watch your own macro table come out of `/cdp:spec-to-code`. Each lesson ends the same way: do this now, then come back here for the next step.

The app category is deliberately small: something you rate repeatedly against criteria you define yourself, with a weighted score that produces a ranking. No external services, no paid APIs, no AI at runtime — buildable in an afternoon once the spec is frozen. That smallness matters for a reason beyond convenience: if your own build still ends up with real, specific content — vulnerabilities that actually mattered, a version bump that actually reflects what changed, a macro table shaped by things you actually said — that content can't be coming from the app being complicated. It's coming from your answers. This course exists to let you see that directly, across the whole loop in one sitting, rather than pieced together from four separate checklists.

## Learning objectives

By the end of this course you will be able to:

- Describe the Custom Scorecard app shape well enough to onboard your own version of it
- Run `/cdp:onboarding` on your own idea and get a v1.0 draft shaped by your actual answers, not a generic template
- Choose a persona whose priorities match your domain's actual risk, not just the first one on the list
- Run a `/cdp:demolish` → `/cdp:integrate` cycle and point to a specific claim in your spec that changed because of it
- Run `/cdp:spec-to-code` in GREENFIELD mode and read the resulting macro table and Deploy Discovery decision as direct consequences of your own onboarding and demolition answers
- Trace, in your own build, at least four concrete places where a different answer would have produced a different outcome
- Ship your own Custom Scorecard PoC to a public URL

## Lessons

| # | Lesson |
|---|--------|
| 01 | [Why This Course Has You Build, Not Watch](01-why-this-course-has-you-build.md) |
| 02 | [Meet Custom Scorecard — the App Category](02-meet-custom-scorecard.md) |
| 03 | [Run Your Own Onboarding](03-run-your-own-onboarding.md) |
| 04 | [Pick a Persona for Your Domain](04-pick-a-persona-for-your-domain.md) |
| 05 | [Run Your Demolition Cycle](05-run-your-demolition-cycle.md) |
| 06 | [Integrate and Freeze Your Spec](06-integrate-and-freeze-your-spec.md) |
| 07 | [Spec-to-Code: Read Your Own Macro Table](07-spec-to-code-your-macro-table.md) |
| 08 | [Ship Your PoC](08-ship-your-poc.md) |
| 09 | [Trace Your Own Divergence](09-trace-your-own-divergence.md) |
| 10 | [Closing the Loop](10-closing-the-loop.md) |

## Source material

Same source as Courses 1-2 for the mechanics reused here: `skills/onboarding/SKILL.md`, `skills/persona/SKILL.md`, `skills/demolish/SKILL.md`, `skills/integrate/SKILL.md`, and `skills/spec-to-code-update/SKILL.md`. This course invents no new plugin behavior — it's the same commands from Course 1 and Course 2, pointed at whatever you're building, with each lesson telling you exactly when to run the next one.

## A note on the marketing template

Course 1 Lesson 05 already flagged this, and it applies here too: the onboarding interview itself now asks its seven questions in generic wording, with a marketing-example-versus-product-example callout under each one — so answering as a builder is already the intended path, not a workaround. What's still marketing-shaped is downstream: `project-spec.md`'s ten section names (audience, channels, message hierarchy, and the rest) and the vulnerability categories `/cdp:persona` and `/cdp:demolish` use. This course uses the "translate loosely" path from that lesson for those downstream parts. If you'd rather write a plain PRD and skip straight to `/cdp:spec-to-code`, that path is still open — see Course 1 Lesson 05 for both options.

## Videos

See [`video-prompts.md`](video-prompts.md). Visual identity: Course 1-2's blueprint/terminal-style template, addressed directly to camera — this course talks to you, not about a case study — green accent marking each "now do this" instruction.

## Unfamiliar term?

Check [`../appendix/01-glossary.md`](../appendix/01-glossary.md) and [`../appendix/02-useful-resources.md`](../appendix/02-useful-resources.md).
