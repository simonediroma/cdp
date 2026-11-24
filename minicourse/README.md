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

A sixth folder, [`appendix/`](appendix/00-index.md), isn't a course — it's reference material: the complete, plugin-agnostic deep dive on the CDP protocol itself (for readers who pick CDP in Course 1 and want the full manifesto-level mechanics), a glossary of the terms used across all five courses (MCP, JWT, PaaS, and the like), and a curated list of official external documentation for the tools the courses mention but don't teach from scratch (Claude Code's own surfaces, Cursor, git/PR basics, deploy platforms, and more).

---

## Format

Each course is a folder of one markdown file per lesson, plus:

- `00-index.md` — table of contents, learning objectives, how the course connects to the others
- `video-prompts.md` — one entry per lesson: where the video sits in the lesson, its target length, and a ready-to-paste prompt for an AI video-generation tool (Sora, Runway, Pika, etc.)

Every lesson file carries a one-line pointer to its video entry (`🎬 Video: video-prompts.md#0N-...`) — nothing is written without a place to check where its video goes.

## Video approach

Videos are built for **HeyGen** (AI presenter avatar + scene/background templates) — not abstract text-to-video motion graphics. Each `video-prompts.md` entry gives you the three inputs HeyGen actually takes:

1. **Script** — the exact narration for the avatar to speak (~150 words/minute spoken pace; duration is derived from script length, not fixed upfront)
2. **On-screen text** — the slide bullets/callouts to place beside the avatar, synced to what it's saying at that moment
3. **Scene/background** — a consistent per-course template so all five courses read as one series with the same instructor

| Course | Avatar & tone | Background / slide template | Accent color |
|---|---|---|---|
| 1 | Same avatar throughout — calm, instructional register | Blueprint/terminal-style slide background | Blue — flags command/file names; red for vulnerability/attack callouts in Lesson 06 |
| 2 | Same avatar, slightly higher energy ("let's build") | Course 1's blueprint/terminal-style slide background | Blue — flags command/file names |
| 3 | Same avatar | Course 2 template plus a visibly "existing" layer already on the slide | Amber — flags "existing / do-not-touch" |
| 4 | Same avatar | Course 2 template plus a magnifying-glass/trace icon | Red, narrowing from broad symptom to root cause |
| 5 | Same avatar, more direct register — talks to the viewer building along, not about a case study | Course 1-2's blueprint/terminal-style slide background | Green — flags each "now do this" instruction |

Using one avatar across all five courses is deliberate — it reads as a single instructor teaching a five-part series, not five disconnected videos. The [Appendix's CDP Protocol deep dive](appendix/cdp-protocol/00-index.md) uses its own, separate template — a neutral professional background with a course-title watermark — since it's reference material, not part of the five-course sequence proper.
