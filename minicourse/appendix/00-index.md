---
title: Appendix — CDP Protocol Deep Dive, Glossary & Useful Resources
depends_on: none — reference material for all 5 courses
---

# Appendix — CDP Protocol Deep Dive, Glossary & Useful Resources

The five courses assume some background you may or may not already have — terms like MCP, JWT, or PaaS get used in passing because a lesson had a more important point to make and couldn't stop to define every acronym. Course 1 also only introduces CDP briefly, as one of three paths to a hardened spec, before teaching it hands-on through the plugin — it doesn't stop to cover the full manifesto-level method. This appendix is where both kinds of gaps get closed.

Four things live here:

- [`cdp-protocol/`](cdp-protocol/00-index.md) — the complete, plugin-agnostic deep dive on the Constructive Demolition Protocol itself: the manifesto, its rationale, the five reference personas, severity, exit criteria, and how to bootstrap it by hand on any LLM with no plugin at all. Read it if you picked CDP as your hardening path in Course 1 and want the full mechanics, or if you want to apply CDP to something that isn't software.
- [`01-glossary.md`](01-glossary.md) — every term used across the five courses that a newcomer might not know, one to three sentences each, alphabetical, with a pointer to where it's used; plus two reference appendices, one listing every file name the plugin or the CDP protocol uses, the other every plugin command with a one-line description.
- [`03-where-cdp-runs.md`](03-where-cdp-runs.md) — the three surfaces the plugin runs on (Cowork, Claude Code, cloud sessions): install, where files live, how to hand Claude a document, what survives a session.
- [`02-useful-resources.md`](02-useful-resources.md) — external, official documentation for the tools and platforms the courses mention but don't teach from scratch: Claude's surfaces (Cowork, Claude Code CLI/IDE, cloud sessions), MCP, Cursor, git/PR basics, testing fundamentals, security basics, deploy platforms, and Jira/Confluence/Docker.

None of this replaces the five courses — it's reference material to dip into when a lesson uses a term you don't recognize or a method you want to go deeper on, not a sixth course to read start to finish.
