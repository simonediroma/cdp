# 01 — GREENFIELD vs FEATURE-ADDITION

🎬 Video: [`video-prompts.md#01-greenfield-vs-feature-addition`](video-prompts.md#01-greenfield-vs-feature-addition)

---

Course 2 ran entirely in GREENFIELD mode: no existing code, no existing conventions, a clean folder and a scaffold macro (`M0`) to start it. Everything from here on runs in **FEATURE-ADDITION** mode: there's a real repo, real modules, real conventions someone (possibly a past version of you) already committed to. The plugin treats these as genuinely different modes, not the same process with extra steps.

## What's actually different

| | GREENFIELD | FEATURE-ADDITION |
|---|---|---|
| `architecture-context.md` | Optional — proceeds without it, flags stack choices as assumptions | **Required** — `/cdp:spec-to-code` stops and asks for it if missing |
| Scaffold macro (`M0`) | Always present, fixed template | Never present — the repo already exists |
| Macro decomposition | Extracts *every* flow in the PRD | Extracts only the flows *this feature* introduces |
| Risk assignment | Standard LOW/MEDIUM/HIGH sizing | Same sizing, **plus**: touching existing shared code (middleware, base models, auth) automatically raises risk one level |
| Spike triggers | Undocumented external system, undecided library, blocking TBD | Same, **plus**: existing modules not described in the architecture context that the macro should touch |
| Generated docs | `docs/lessons.md` — consolidated patterns as you go | `docs/context.md` — what's involved, what to follow, what not to touch, specific to this feature |
| `CLAUDE.md` / `01-operative.mdc` | Generated fresh | **Not overwritten** if it already exists — only flagged if invariant files need updating |
| Deploy | Deploy Discovery interview runs (Course 2 Lesson 02) | Not regenerated — infrastructure already exists; a new-infra need becomes a spike, not a silent extension |

## Why the distinction matters more than it looks

The risk-escalation rule is the one worth internalizing before you write a single macro: **a macro that touches existing shared code is automatically riskier than the same change would be in a vacuum**, because the regression surface is larger — you're not just adding new code, you're proving old code still works the way its other callers expect. This is the FEATURE-ADDITION analogue of Chesterton's Fence from `CLAUDE.md`'s development rules: before you touch something that already works, understand why it's built that way.

## The gate that doesn't change

Both modes share the same non-negotiable gate: the spec has to be frozen — demolished, hardened, no open decisions — before `/cdp:spec-to-code` decomposes it into macros. FEATURE-ADDITION doesn't relax this. If anything, it matters more here, because a moving spec against a *live* product risks destabilizing something that currently works, not just producing rework on an empty repo.

## Check your understanding

- Why does modifying existing shared code automatically raise a macro's risk level, rather than being assessed the same as new code?
- What's the one gate that GREENFIELD and FEATURE-ADDITION both enforce identically, and why doesn't FEATURE-ADDITION get to skip it?

*Next: [02 — `architecture-context.md` in Depth](02-architecture-context-in-depth.md).*
