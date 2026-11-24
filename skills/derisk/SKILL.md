---
name: derisk
description: "Sweeps an artifact mechanically across every risk lens and writes what it finds into risk-register.md — breadth, in one pass, without interrogating anyone. The complement of /cdp:demolish, not a replacement: derisk finds what nobody thought to raise, demolish makes you defend what was raised. Runs on project-spec.md, a PRD, a UX brief or a roadmap. Use when the user asks to 'find the risks', 'what could go wrong', 'stress-test this', or before a demolition cycle to decide what is worth attacking."
argument-hint: "[path to the artifact — omit to use project-spec.md]"
disable-model-invocation: true
allowed-tools: Read, Write, Edit, Glob, Grep
---

# Skill: Derisk

Find what is dangerous, in one pass, across every lens — **including the lenses nobody thought to look through**.

## Why this exists beside `/cdp:demolish`

They answer different questions and fail in opposite ways.

| | `demolish` | `derisk` |
|---|---|---|
| Mode | conversational, one criticism per turn | mechanical sweep, one pass |
| Your role | you defend every criticism | you read the output |
| Strength | **depth** — a claim that survived a defense is genuinely stronger | **breadth** — it reaches categories no persona would have picked |
| Blind spot | whatever the conversation never reached, and whatever cdp has no category for | nobody pushed back on any of it |
| Cost | long | cheap |

**Neither subsumes the other.** A mechanically listed risk is not the same as one a person failed to argue away; and no amount of arguing finds a risk in a category you don't have.

**Neither requires the other, and there is no required order.** This skill runs standalone on any artifact, whether or not a demolition cycle has ever happened. Sweeping before attacking is often cheapest — it tells you what is worth the conversation — but it is a habit, not a prerequisite. Run this alone on a PRD and stop there if that is all you need.

## What it does not do

- **It does not promote the spec's status.** `/cdp:integrate` remains the only promoter. Sweeping is not absorbing — it is further from it than attacking is. Its findings reach the status only through `/cdp:integrate`, which records the pass as `hardening: sweep` — that record, not this skill, is what the freeze later reads. **One deliberate exception:** a new ACT NOW risk **confirmed** against a document that is already `frozen` reopens it to `hardened` on the spot (Phase 2) — waiting for a separate pass to notice would let building continue on a document no longer actually settled. A row still `in sospeso` — proposed ACT NOW, not yet confirmed — does **not** reopen anything on its own; it only blocks a future freeze, the same as any other pending ACT NOW. That is a demotion in response to a confirmed new danger, not an absorption of a finding, and it's the only status write this skill ever makes.
- **It does not interrogate.** No questions, no defending. That is `demolish`'s job and the reason it exists.
- **It does not edit the artifact.** It reports; folding a finding into the spec is `/cdp:integrate`'s work, after you decide.

## Output

Rows in `risk-register.md`, the same file `demolish` writes and `integrate` retires from.
→ Template: `${CLAUDE_PLUGIN_ROOT}/skills/demolish/references/risk-register-template.md`. Create the file from it if it doesn't exist.

**Two producers, one register.** Never start a second file, and never rewrite rows you didn't add.

## Cardinal rules

- **Be adversarial, not polite.** Assume the artifact is wrong until it survives. The job is to find the weakness now, while it is cheap.
- **Every row carries a test.** The cheapest thing that would prove the risk real or dead. A line with no test is a comment, not a risk — cut it.
- **Never invent a risk to fill a lens.** A lens that surfaces nothing gets no row. Say in the report which lenses came back empty; a mechanically complete table of plausible-sounding risks is worse than a short true one, because it buries the real ones.
- **Give each risk a basis, not a bibliography.** The fact it rests on: a datum, a constraint, the absence of evidence. `[ASSUMPTION]` where none exists. And where the *missing* thing is what makes it risky — no research, no data, no named owner — **that absence is the risk**, written as one, not as a disclaimer about the register.
- **Don't re-raise what is settled.** Read `cdp-memory.md` § Accepted Limitations and the register's `retired` rows first: a limitation deliberately declared, or a risk a cycle closed, is not a finding. If you believe a retired risk has come back, say so explicitly as a new row citing the old one — never silently re-open it.
- **Ten real risks beat thirty plausible ones.**
- Ask for **today's date**; never fabricate one.

## Phase 0 — Read, and orient

Identify the artifact: the argument, or `project-spec.md` by default. It can also be a PRD, a `ux-brief.md`, or a roadmap — this skill is composable and does not require cdp's own spec.

Read it fully, plus:

- `risk-register.md` if it exists — **the rows for this artifact**: the open ones (don't duplicate them) and the retired ones (don't re-raise them). **Any row `in sospeso`** — `Triage proposed` filled, `Triage confirmed` blank, from an earlier pass of this skill — is this skill's own unfinished business: surface it again in Phase 2 alongside this pass's new proposals, and write the operator's answer into that same row rather than adding a new one.
- `cdp-memory.md` § **Accepted Limitations** — deliberately out of scope, never a finding
- `demolition-history.md` § Open Deferred Issues, if present — these are already risks; reconcile rather than duplicate

**Mode**, same two words as the rest of the plugin, detected not asked:

- **BRAND** (`project-spec.md`, 11 sections) → the marketing lenses lead.
- **PRODUCT** (a PRD, a brief, functional requirements) → the product lenses lead.

Both sets get swept in either mode; the mode decides which leads and where you spend the effort.

## Phase 1 — Sweep every lens

Work each one and record what it surfaces. A lens that surfaces nothing is fine — note it for the report.

**Marketing lenses** — the same seven `demolish` maps, so the two skills speak one vocabulary:
`audience-fit` · `claim` · `differentiation` · `hierarchy` · `channel` · `tone` · `objective-gap`

**Product lenses** — Cagan's four risks, which cdp had no categories for at all:

| Lens | The question |
|---|---|
| `desirability` | Do the people we mean actually want this? What is the evidence, as opposed to a stakeholder's conviction? |
| `usability` | Can they figure out how to get the value? Where do they get stuck? |
| `feasibility` | Can it be built with what exists? What changes technically, and what breaks backwards? |
| `viability` | Does it work for the business — cost, operational load, and does it stay inside the declared constraints? |

**External forces** — PESTEL: `political` · `economic` · `social` · `technological` · `environmental` · `legal`. Concrete or omitted: "regulation might change" is not a risk, "this claim needs substantiation we don't have" is.

**Compliance** — personal data and lawful basis, data minimisation, consent where the flow captures it, substantiation for any comparative or superlative claim, and transparency where something automated is user-facing. Concrete, never ritual, and **never a row for a regime that doesn't touch this artifact**.

For each risk found: severity, likelihood, basis, triage, and the cheapest test.

## Phase 2 — Triage and test

Three tiers. **ACT NOW** — must be retired before building; these block the freeze, so the bar is real damage,
not discomfort. **MONITOR** — stays open, doesn't block, and carries **the signal or threshold that would move
it to ACT NOW**; without that signal it isn't being monitored, it's being ignored. **ACCEPT** — the risk is
accepted and closed on the spot, with a **mandatory reason** for why it's acceptable as-is.

**You propose the tier, the operator confirms or changes it** — this is a judgement call about what the project
can tolerate, not a mechanical fact this skill can settle alone. Show your proposed triage for every risk found
in this pass before writing rows in Phase 3. **Don't hold the register back waiting for a response to every
one.** Write `Triage proposed` for each row as you go; write `Triage confirmed` too wherever the operator has
actually responded in this pass. Where they haven't — a long sweep reviewed in batches, a session that ends
before reaching every row — write the row anyway with `Triage confirmed` left blank: that row is **in sospeso**
(pending), and it stays that way until a later confirmation, not until this skill guesses. A pending ACT NOW
blocks the freeze exactly like a confirmed one (`/cdp:integrate` check 3), but it does not reopen a `frozen`
document on its own — see below. Any row where the confirmed tier is a **downgrade from your proposed ACT NOW**,
record the reason and today's date next to it — this is a distinct trace from the freeze-time override in
`/cdp:integrate` (check 3), which happens later and to a different decision: here you're saying the risk doesn't
rise to ACT NOW at all; there, someone is choosing to freeze anyway despite an open one.

For every ACT NOW risk, name the **cheapest test**: the least expensive thing that gets the harsh truth without
building production software. A probe, not a plan.

**If this artifact's current `status` is `frozen` and this sweep confirms a *new* ACT NOW risk against it** —
one that wasn't already an open row — that document is no longer actually settled. Reopen it: set `status:
hardened` in its frontmatter and add a `version_history` entry recording the reopening (cause: the new risk's
row number, date) without bumping the version, since the text itself didn't change. Say this plainly in the
Phase 4 report. A sweep that finds nothing new, or that only confirms already-open rows, does not reopen
anything — see "What it does not do" below.

## Phase 3 — Write

Add your rows to `risk-register.md`, each with **`Artifact` set to the document you swept** — the freeze and every verdict filter on it, so a row without it would block or colour the wrong document. Status is `open · sweep [N]` — distinct from `demolish`'s `open · cycle [N]`, and the distinction is content, not bookkeeping: **a swept row is one nobody has pushed back on yet**, while a deferred one survived somebody trying. A reader deciding what to worry about needs to know which they're looking at.

Then rewrite **The principal risk** if this sweep changed what it is, re-sort **Act now** by severity × probability, and set **this artifact's row** in the **Verdict** table with today's date: `proceed` · `proceed-with-tests` (naming the 1–3 gating tests) · `rework`. Other artifacts' verdicts are not yours to touch. For a given artifact the verdict is last-writer-wins between this skill and `integrate`; the date says which is current.

## Phase 4 — Report, and hand off

Say: the principal risk in one sentence; how many rows you added and how many were already there; **which lenses came back empty**, because that is the part the register cannot show and the reader needs it to judge coverage; and the verdict.

Then point at what comes next, honestly:

- **`/cdp:demolish`** — *if the findings deserve an argument.* The sweep produced candidates; demolish is where the author defends the ones that matter and you find out which hold. Name the two or three worth the conversation, by row number. It is a suggestion, not a next step: a register is a legitimate place to stop.
- **`/cdp:integrate`** — folds a finding into the artifact, and is the only skill that writes `status`. It acts on what you just found without needing a demolition cycle, and promotes on either method. **If the artifact carries no `status` frontmatter** — a PRD from elsewhere, usually — say so: integrating there also declares it `hardened`, which is what stops every downstream skill from asking whether it's ready. Nothing here has changed the artifact.

And state the limit of what you just did: **nobody defended any of this.** Every row is a finding waiting for an argument, which is exactly what `demolish` supplies and this skill deliberately does not.

## Confidentiality

Synthetic examples only — no real customer PII or production data in the register.
