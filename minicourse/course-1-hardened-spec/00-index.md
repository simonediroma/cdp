---
course: 1
title: How to Create a Hardened Specification
audience: Anyone starting from a rough idea or a not-organized draft, on any LLM, any tool
depends_on: none
---

# Course 1 — How to Create a Hardened Specification

## What this course is

Every project starts with a draft — often a rough one, often written in a single sitting, often produced by asking an LLM for a PRD and taking the first answer. That draft has blind spots you can't see from inside your own head, and this course is about closing them before anyone starts building. It isn't a course about one specific tool. It's about the general move from an improvised, **not-organized** spec to a **hardened** one: a spec that's been deliberately attacked, whose vulnerabilities were triaged and either fixed or consciously accepted, with a record proving it. That spec-level shift is the opening move of a bigger one this whole minicourse is built around — vibe coding to loop engineering — which Lesson 01 covers first.

Lesson 02 lays out three legitimate ways to do that. This course picks one — the Constructive Demolition Protocol (CDP) — and teaches it hands-on through the `claude-cdp` plugin, because it's the method the [cdp claude plugin](https://github.com/simonediroma/cdp) automates end to end, onboarding skill included. Nothing about the other two paths is a lesser option; they're just not what the rest of this course walks through mechanically. If you want the complete, tool-agnostic treatment of CDP itself — the manifesto, the five reference personas, severity, exit criteria, how to bootstrap it by hand with no plugin at all — that's the [Appendix's CDP Protocol deep dive](../appendix/cdp-protocol/00-index.md).

## Learning objectives

By the end of this course you will be able to:

- Explain the difference between "vibe coding vs. loop engineering" and "not-organized spec vs. hardened spec," and why a spec drafted in isolation reliably has blind spots as a process failure, not a model-capability one
- Name three legitimate paths to a hardened spec, and explain what each one does and doesn't guarantee
- Install the `claude-cdp` plugin and verify it's active
- Run the full command sequence — `onboarding → persona → demolish → integrate → export` — to produce a hardened spec
- Explain what changes concretely once a spec has survived structured adversarial review, versus one that's just been read over
- Produce a frozen spec — by whichever path fits — ready to hand to Course 2

## Lessons

| # | Lesson |
|---|--------|
| 01 | [Why First Drafts Have Blind Spots](01-why-first-drafts-have-blind-spots.md) |
| 02 | [Three Paths to a Hardened Spec](02-three-paths-to-a-hardened-spec.md) |
| 03 | [Installing the Plugin](03-installing-the-plugin.md) |
| 04 | [Command Overview](04-command-overview.md) |
| 05 | [Drafting v1.0 with `/cdp:onboarding`](05-drafting-v1-with-onboarding.md) |
| 06 | [Hardening the Draft: Personas, Demolition, Integration](06-hardening-personas-demolition-integration.md) |
| 07 | [Exercise — Harden a Real Spec, Your Way](07-exercise.md) |

## Source material

Where a lesson describes the `claude-cdp` plugin's mechanics in detail, it's grounded in the corresponding `skills/*/SKILL.md` file in the [cdp claude plugin](https://github.com/simonediroma/cdp) repo — read those directly if you want the exact operational text an LLM executes. Where a lesson describes CDP's underlying method rather than the plugin's automation of it, it's grounded in `document/cdp-manifesto.md` and `document/cdp-foundations.md`, and taught in full in the [Appendix's CDP Protocol deep dive](../appendix/cdp-protocol/00-index.md).

## Videos

See [`video-prompts.md`](video-prompts.md) for one HeyGen script + on-screen text per lesson. Visual identity: blueprint/terminal-style slide background, blue accent on command and file names, red accent for vulnerability/attack callouts in Lesson 06 (see the [cdp claude plugin](https://github.com/simonediroma/cdp)'s `minicourse/README.md`).

## Unfamiliar term?

Check [`../appendix/01-glossary.md`](../appendix/01-glossary.md) and [`../appendix/02-useful-resources.md`](../appendix/02-useful-resources.md) — MCP, Jira, deploy platforms, and more are covered there, not re-explained per lesson.
