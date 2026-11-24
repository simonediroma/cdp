# 01 — Why First Drafts Have Blind Spots

Specifications drafted in isolation reliably have blind spots. Not occasionally — reliably. This is true regardless of what kind of project the spec belongs to, and regardless of whether you wrote it slowly with a coffee or asked an LLM to draft it for you in thirty seconds. A spec that looked complete to the person (or the prompt) that produced it still misses things systematically, in ways the author couldn't see from inside their own head. That isn't a claim about carelessness — a careful author still misses, because the failure mode is perspective, not attention. You cannot see your own blind spot by trying harder to look at it.

## Vibe coding vs. loop engineering

This course, and the four after it, are built around one shift: moving from **vibe coding** to **loop engineering**. Everything else in this minicourse is a detail under that one heading.

"Vibe coding" — open a chat, describe roughly what you want, iterate by feel until something works — is a real, useful way to build software. It's fast for a prototype, a script, a one-off. "Loop engineering" is the alternative: not one improvised conversation, but a fixed sequence of stages, each with a defined input, a defined output, and a defined gate before you move to the next one.

| | Vibe coding | Loop engineering |
|---|---|---|
| **How it runs** | One improvised conversation, iterated by feel | A fixed sequence of stages, each with a defined input, a defined output, and a defined gate before you move to the next one |
| **Memory** | Lives in your head, or nowhere — re-derived every session | Persists in a written record (`cdp-memory.md`, `CLAUDE_MEMORY.md`) that the next session reads before doing anything else |
| **Risk** | Untracked — a config tweak and an auth rewrite get the same scrutiny | Tracked per stage and gated by level (LOW/MEDIUM/HIGH/DEPLOY) |
| **"Done"** | Idiosyncratic — whatever the author's own gut says is enough | A claim checked against written criteria, with a record of who checked it and how |

That table describes how you build software overall, start to finish — it's not about specs specifically. But the shift has to start somewhere, and it starts before a single line of code gets written: the first stage of loop engineering is turning whatever spec you're starting from into a **hardened** one.

## The not-organized spec is the fastest way to open blind spots

A spec written in a single improvised pass — a paragraph of intent, maybe a bullet list, with no adversarial pressure applied to it at all — is a **not-organized spec**. That label describes the spec itself, independent of whether vibe coding or loop engineering is how you plan to build from it. A not-organized spec is fine for something that dies in one session. It stops being fine the moment a project outlives that session, gets a second contributor, or needs someone else to build from it — because now the blind spots aren't yours to quietly patch as you go. They're gaps someone else discovers mid-build, at the most expensive possible time to discover them.

The symptoms are familiar to anyone who's tried to scale a not-organized spec past day one:

- The plan re-derives context every time it's picked up, because nothing about *why* a decision was made got written down
- Ambiguities that felt obvious to the author ("of course it means that") read as genuinely unclear to anyone else
- Risk isn't tracked — a one-line config change and a rewrite of the auth flow got the same amount of scrutiny (none, or all of it, inconsistently)
- "Done" is idiosyncratic, not a checklist — nobody can say with confidence the thing that got built actually matches what was meant

None of this is a model-capability problem. A better LLM writing the first draft doesn't fix it, because the defect isn't in the writing — it's in the fact that nothing pushed back on the draft before someone started building from it. This is a *process* problem: improvisation has no memory and no gates.

## Why informal review doesn't fix this either

The obvious answer — "just have someone read it over" — works when review is someone's actual job: journals, regulated industries, paid editorial pipelines give reviewers the time an artifact deserves. Outside those settings, the typical author asks a friend or colleague for a quick look and rarely gets the depth of scrutiny the spec actually needs. Favors aren't the right currency for sustained adversarial attention — your friend has fifteen minutes and doesn't want to be the person who tears your work apart.

What's missing in both cases — the solo, not-organized draft and the friendly read-through — is the same thing: structured, adversarial pressure applied *before* anyone starts building. Not another pass of writing. An attack.

## From a not-organized spec to a hardened one

Not because vibe coding is bad at what it does — it's genuinely the fastest way to get a first draft or a one-off script out. The case for hardening the spec is what happens *after* that first pass, once a project outlives a single sitting:

- **It closes the exact gaps a not-organized spec opens.** Every symptom listed above — context re-derived from scratch, decisions quietly contradicted later, risk applied inconsistently, "done" nobody can verify — has a direct structural answer once the spec is hardened: a memory file, a gate keyed to risk, a written exit criterion.
- **It doesn't slow down the actual moment of writing.** Loop engineering constrains what comes before a stage (a hardened spec) and after it (an updated memory file), not the improvisation happening inside it — you can still draft at vibe-coding speed.
- **It leaves an audit trail.** A hardened spec plus a demolition history is something you can hand to someone else — a collaborator, a future version of you — and have them understand not just *what* was decided but *why*, without re-deriving it from a conversation nobody wrote down.

A spec doesn't get called "hardened" because it feels done — it gets called hardened because it survived rounds of adversarial pressure, its vulnerabilities were triaged and either fixed or consciously accepted, and that history is written down somewhere you can point to. That's the engineered loop this course teaches, starting with the spec:

```
onboarding → persona → demolish → integrate → (repeat) → export
                                                              ↓
                                              spec-to-code (spec frozen)
                                                              ↓
                                    execute macros (risk-gated: LOW/MEDIUM/HIGH/DEPLOY)
                                                              ↓
                                                          M_deploy
```

Every arrow in that diagram is a checkpoint, not a suggestion — this course's remaining lessons and Course 2 are the mechanics of each stage. Lesson 02 lays out three concrete ways to run the first stage, hardening the spec — this course teaches one of them, `claude-cdp`'s Constructive Demolition Protocol, hands-on, because it's the one the [constructive demolition protocol plugin](https://github.com/simonediroma/cdp) automates end to end. Nothing about the shift itself requires that specific tool.

> "Demolish your specification before reality does. What survives the demolition is worth building."

## Check your understanding

- What specifically breaks when a not-organized spec outlives a single session, and why is that a process failure rather than a model-capability failure?
- Where does the line sit between "vibe coding vs. loop engineering" and "not-organized spec vs. hardened spec" — what does each pair describe, and which one is this course's first stage?
- What's missing from a friendly colleague's read-through that a structured adversarial round supplies?
- Name one thing loop engineering changes and one thing it deliberately leaves untouched inside a single macro.

*Next: [02 — Three Paths to a Hardened Spec](02-three-paths-to-a-hardened-spec.md).*
