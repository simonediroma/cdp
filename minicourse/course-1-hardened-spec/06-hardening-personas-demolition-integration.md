# 06 — Hardening the Draft: Personas, Demolition, Integration

🎬 Video: [`video-prompts.md#06-hardening-personas-demolition-integration`](video-prompts.md#06-hardening-personas-demolition-integration)

---

Lesson 05 got you a v1.0 draft. A draft is not a hardened spec — nothing has attacked it yet. This lesson walks the three commands that do: `/cdp:persona` (who attacks), `/cdp:demolish` (the attack itself), `/cdp:integrate` (what changes because of it) — plus `/cdp:export`, for the moment the spec needs to leave Claude entirely. This is the plugin's automation of the "adversarial, structured demolition" path named in Lesson 02; the [Appendix's CDP Protocol deep dive](../appendix/cdp-protocol/00-index.md) has the full manifesto-level mechanics behind every rule mentioned here.

## `/cdp:persona` — who does the attacking

The plugin ships with six predefined personas (The Target Customer, The Competitor, The Journalist, The Creative Director, The CFO, Legal & Compliance) — all marketing personas, tuned to attack a campaign spec. For a software PoC, you'll almost always want personas closer to the Appendix's five generic ones instead: the Skeptical User, the Dev Implementer, the Business Owner, the Future Maintainer, the End User.

`/cdp:persona` supports building exactly those: create a new custom persona through a guided interview, modify one you already saved, or clone a predefined one as a starting point (never overwrites the original) and rewrite it. Each persona is six fields — Name/ID, Role, Tone, Key question, Priority (7 categories, marketing-flavored — order them by rough analogy and don't overthink it, severity beats category order every time a round runs), and Freecontext. Fastest route to a software-flavored persona: clone a predefined one for its structure, then rewrite Role, Tone, Key question, and Freecontext using the Appendix's persona descriptions.

## `/cdp:demolish` — the attack

One round, one persona. The skill reads `project-spec.md`, the relevant slice of `demolition-history.md`, and your accepted limitations from `cdp-memory.md`, then attacks one issue at a time in a fixed three-beat shape: quote the exact claim from the spec, state the defect in 1-3 sentences, close with *"How do you respond to this?"* — no proposed fixes, ever. A strong response (one that narrows scope, adds evidence, or declares an explicit limitation) resolves the issue; a weak one gets rephrased, then escalated, ending in one of three exits if you're stuck: modify the claim, narrow the scope, or accept it as a declared limitation.

One gap worth knowing: the manifesto's R1 soft cap (stop and ask before firing a sixth vulnerability in one round) isn't enforced by the installed skill — it runs until vulnerabilities are exhausted or you say stop. If you want that discipline, enforce it yourself.

## `/cdp:integrate` — what actually changes the spec

Nothing from a `/cdp:demolish` round touches `project-spec.md` on its own — demolish only surfaces problems and records your responses. Integrate is the deliberate, separate step that applies them: for every resolved issue, it restates your response, identifies the section it touches, shows original vs. proposed text side by side, and waits for explicit confirmation before applying anything. It also checks cascades (a redefined objective might ripple into your value proposition) and flags them instead of silently leaving the spec inconsistent. Once changes are applied, the version bumps — MINOR for tactical changes, MAJOR for anything strategic, MAJOR winning if a cycle had both.

## `/cdp:export` — optional, for when the spec needs to leave Claude

`/cdp:export` turns `project-spec.md` into a shareable `.docx` — useful the moment someone who isn't running Claude needs to read it: a stakeholder, a client, a teammate. It asks three quick things (a primary color proposed from your spec's tone, a logo path or "none," a document name), then generates and runs a script that produces `exports/<name>-v<version>.docx`. Skip it entirely if a markdown file is all anyone downstream needs — it isn't required to move on to Course 2.

## The loop that actually matters

```
/cdp:persona → (/cdp:demolish → /cdp:integrate) × N → /cdp:export (optional)
```

Repeat the demolish-integrate cycle across personas until the exit criteria in the Appendix's Lesson 13 are met: enough rounds, zero open Criticals, every Major explicitly accepted with a written rationale, and a demolition history that proves it. Only then is the spec frozen and ready for Course 2's `/cdp:spec-to-code`.

## Check your understanding

- Why does `/cdp:persona` ship with marketing-flavored personas, and what do you do about it for a software PoC?
- Why is integrate a separate command from demolish, instead of resolving issues immediately during the round?
- What's the minimum requirement `/cdp:spec-to-code` actually has for its input, and why does that give you an escape hatch if none of the plugin's default vocabulary fits your project?

*Next: [07 — Exercise: Harden a Real Spec, Your Way](07-exercise.md).*
