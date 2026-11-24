---
course: 3
title: How to Ship the PoC to Production
audience: Developers extending a live PoC into a maintained product
depends_on: "Course 2 — How to Translate a Specification into a PoC (required — this course assumes a real, deployed PoC to extend)"
---

# Course 3 — How to Ship the PoC to Production

## What this course is

Course 2 ended with a PoC that actually runs, live, at a public URL. This course starts the moment you come back to it — not to rebuild it, but to add a real feature to a real codebase. Everything changes subtly once there's an existing product: the plugin calls this **FEATURE-ADDITION** mode, as opposed to Course 2's **GREENFIELD**, and the difference isn't cosmetic. There's now something to describe (an architecture), something to protect (invariants), and something that persists across many more sessions than a PoC ever needed (memory, spikes, long-running work).

## Learning objectives

By the end of this course you will be able to:

- Explain concretely what changes in the plugin's behavior between GREENFIELD and FEATURE-ADDITION mode
- Write (or generate) an `architecture-context.md` that actually lets `/cdp:spec-to-code` produce contextualized macros instead of generic placeholders
- Use `/cdp:arch-init` to derive that file from a real repo scan instead of writing it cold
- Run a full CDP cycle — onboarding through demolition — against a feature that touches an existing product, not a blank slate
- Run `/cdp:spec-to-code` in FEATURE-ADDITION mode and read its delta-macro output
- Handle a macro marked `⏳ SPIKE PENDING` from investigation through `/cdp:spike-integrate`
- Keep long-running implementation work coherent across many sessions with `/cdp:session-start` and `/cdp:resume`
- Keep a Claude Code track and a Cursor track in sync as the same product grows under both

## Lessons

| # | Lesson |
|---|--------|
| 01 | [GREENFIELD vs FEATURE-ADDITION](01-greenfield-vs-feature-addition.md) |
| 02 | [`architecture-context.md` in Depth](02-architecture-context-in-depth.md) |
| 03 | [`/cdp:arch-init`](03-arch-init.md) |
| 04 | [A New CDP Cycle Against an Existing Product](04-new-cycle-existing-product.md) |
| 05 | [`/cdp:spec-to-code` in FEATURE-ADDITION Mode](05-spec-to-code-feature-addition.md) |
| 06 | [SPIKE PENDING Macros](06-spike-pending-macros.md) |
| 07 | [`/cdp:spike-integrate`](07-spike-integrate.md) |
| 08 | [Long-Running Sessions — `/cdp:session-start`, `/cdp:resume`](08-long-running-sessions.md) |
| 09 | [Keeping Both Tracks in Sync](09-keeping-tracks-in-sync.md) |
| 10 | [Exercise — Add a Real Feature to Your PoC](10-exercise.md) |

## Source material

Grounded in `skills/arch-init/SKILL.md`, `skills/spike-integrate/SKILL.md`, `skills/session-start/SKILL.md`, `skills/resume/SKILL.md`, and the FEATURE-ADDITION sections of `skills/spec-to-code-update/SKILL.md` and its `references/`.

## Where it runs

Every lesson works on **Cowork**, **Claude Code** and **cloud sessions**. Install steps, where your files live and what has to be committed on a cloud session: [Where cdp Runs](../appendix/03-where-cdp-runs.md).

## Unfamiliar term?

Check [`../appendix/01-glossary.md`](../appendix/01-glossary.md) and [`../appendix/02-useful-resources.md`](../appendix/02-useful-resources.md).
