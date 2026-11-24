# From Vibe Coding to Loop Engineering — Course Overview

Five short courses, meant to be taken in order. Each builds on the one before it.

| Course | Title | What it covers |
|---|---|---|
| 1 | How to Create a Hardened Specification | From a rough idea or a not-organized draft to a spec that's survived structured adversarial review — the opening move of the vibe-coding-to-loop-engineering shift. CDP, taught hands-on through the `claude-cdp` plugin, is one of three legitimate paths this course covers — not the only one. |
| 2 | How to Translate a Specification into a PoC | Using the `claude-cdp` plugin's `/cdp:spec-to-code` to turn a frozen spec into a running, **deployed PoC**. |
| 3 | How to Ship the PoC to Production | Evolving a live PoC into a maintained product — adding real features to a real codebase. |
| 4 | Testing & Iteration | The method for triaging and fixing PoC bugs — reusing CDP's own severity and mediated-resolution discipline. |
| 5 | The Capstone — Hello World, Hands-On | Running the full onboarding → demolition → spec-to-code → deploy loop yourself, on a small self-contained app you pick (a Custom Scorecard) — every lesson tells you what to run next, so you build your own proof that the method shapes whatever's true about your project, not a fixed template. |

Course 1 doesn't require the plugin to get value from it — Lesson 02 covers two other legitimate paths to a hardened spec, and the [Appendix's CDP Protocol deep dive](appendix/cdp-protocol/00-index.md) teaches the full method by hand on any LLM, plugin or not. Courses 2–5 assume the plugin is installed (see the [cdp claude plugin](https://github.com/simonediroma/cdp)'s main `README.md` for installation).

A [`guides/`](guides/00-index.md) folder holds short standalone walkthroughs — e.g. onboarding a partially written book. Every course and guide runs on **Cowork**, **Claude Code** and **cloud sessions**: see [Where cdp Runs](appendix/03-where-cdp-runs.md).

The [`appendix/`](appendix/00-index.md) folder isn't a course — it's reference material: the complete, plugin-agnostic deep dive on the CDP protocol itself (for readers who pick CDP in Course 1 and want the full manifesto-level mechanics), a glossary of the terms used across all five courses (MCP, JWT, PaaS, and the like), and a curated list of official external documentation for the tools the courses mention but don't teach from scratch (Claude Code's own surfaces, Cursor, git/PR basics, deploy platforms, and more).

---

## Format

Each course is a folder of one markdown file per lesson, plus `00-index.md` — table of contents, learning objectives, how the course connects to the others.
