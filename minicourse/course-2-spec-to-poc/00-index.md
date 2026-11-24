---
course: 2
title: How to Translate a Specification into a PoC
audience: Developers and builders using the claude-cdp plugin to go from a frozen spec to a live PoC
depends_on: "Course 1 — How to Create a Hardened Specification (a frozen PRD, from CDP or any other method)"
---

# Course 2 — How to Translate a Specification into a PoC

## What this course is

Course 1 got you a frozen spec — whether you produced it through CDP demolition cycles, a structured template, or your own solo checklist. This course doesn't care which: `/cdp:spec-to-code` only requires a PRD file, `.md`/`.txt`/`.pdf`/`.docx`, hardened by whatever means. What it does from there is the part the bare CDP manifesto never covers at all — turning that document into an actual implementation plan, and carrying it all the way to a **running, deployed PoC**.

If you worked through Course 1 with the `claude-cdp` plugin, you already know the commands that got you here. If you brought a PRD from somewhere else entirely, you can start this course cold — every command from this point on is explained as it's introduced.

## Learning objectives

By the end of this course you will be able to:

- Run `/cdp:spec-to-code` in GREENFIELD mode and make an informed infrastructure decision through the Deploy Discovery interview
- Read the generated boilerplate for either Claude Code or Cursor and know what each file is for
- Name the five agent-skills-derived behaviors embedded in every macro, the loops they define, and how completely each is actually implemented — not just that they exist
- Execute the macro plan in your tool of choice, through to a working `M_deploy` macro
- Ship a PoC — from a frozen spec to a publicly reachable URL — end to end

## Lessons

| # | Lesson |
|---|--------|
| 01 | [From PRD to Boilerplate — `/cdp:spec-to-code`](01-prd-to-boilerplate.md) |
| 02 | [Deploy Discovery — Deciding Infrastructure Before You Build](02-deploy-discovery.md) |
| 03 | [Anatomy of the Output — Two Tracks](03-anatomy-of-the-output.md) |
| 04 | [The agent-skills Rules — Completeness and the Coding Loops They Define](04-the-agent-skills-rules.md) |
| 05 | [Executing the Plan in Your Tool of Choice](05-executing-the-plan.md) |
| 06 | [Shipping the `M_deploy` Macro](06-shipping-m-deploy.md) |
| 07 | [Exercise — Idea to Deployed PoC](07-exercise.md) |

## Source material

This course teaches the `claude-cdp` plugin as it currently behaves. Where a lesson describes a skill's mechanics in detail, it's grounded in the corresponding `skills/*/SKILL.md` file in the [cdp claude plugin](https://github.com/simonediroma/cdp) repo — read those directly if you want the exact operational text an LLM executes.

## Unfamiliar term?

Check [`../appendix/01-glossary.md`](../appendix/01-glossary.md) and [`../appendix/02-useful-resources.md`](../appendix/02-useful-resources.md) — MCP, Jira, deploy platforms, and more are covered there, not re-explained per lesson.
