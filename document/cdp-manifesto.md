---
title: Constructive Demolition Protocol
subtitle: CDP v10.1 — Operational Manifesto
version: "10.1"
created: 2026-04-25
last_demolition_cycle: 2026-07-02
demolition_cycles_count: 1
version_history:
  - version: "10.1"
    date: 2026-07-02
    notes: "Integrate cycle 1 (persona: The Skeptical User) — added single-owner assumption (§01 Phase 0), F7-style disclaimer to R1's soft cap, and authorial-responsibility sentence to §04 closure. Tactical edits, no structural change."
  - version: "10.0"
    date: 2026-04-25
    notes: "Prior hardened version, converted from CDP-manifesto-v10.0-desktop.pdf."
type: manifesto
companion: cdp-foundations.md (v3.1)
---

# Constructive Demolition Protocol

## CDP v10.1 — Operational Manifesto

Self-demolition project — operational + foundations companion
2026-04-25

Note: This file tells the LLM and the author how to run the CDP. The why — origin, recursive self-validation, philosophical positioning, scope, methodological rationale, references — lives in cdp-foundations.md v3.0. The manifesto is operational; the foundations are conceptual. Read both for full understanding; load only this manifesto into the LLM at runtime.

*Every specification has blind spots. The CDP finds them before reality does.*

## Incipit

This manifesto is the operational specification of the Constructive Demolition Protocol. It contains the procedure (§01), the personas (§02), the vulnerability severity scale (§03), the exit criteria (§04), and the bootstrap rules for any LLM that will execute it (§05). Why the protocol is structured this way, and what it draws on conceptually, lives in cdp-foundations.md. Proceed to §01.

---

## 01 — The Process

Two phases preceded by a one-time setup. Repeatable by anyone.

The CDP is generative before it is adversarial. After a one-time setup (Phase 0), the method has two phases: an AI-assisted onboarding to first-complete-draft (Phase 1), followed by the demolition proper (Phase 2).

### Phase 0 — Setup (one-time)

**Operating mode (declare at start).**

- **Persistent mode (default).** The LLM has read/write access to a project folder. Sessions, history, and project memory persist as files across LLM sessions. Recommended for any real project.
- **Single-session mode (fallback).** No folder access. The entire CDP cycle runs inside one chat — manifesto, spec, persona, accumulating history live in conversation context. The author exports the conversation at end of session to preserve state.

Protocol behavior is identical in both modes; the difference is only where state is held.

**Prerequisites.**

1. A project folder (persistent mode) or one chat with sufficient context window (single-session mode).
2. An LLM with read/write access to the folder, OR an LLM session capable of holding manifesto + spec + persona + history in context. Cowork is canonical for persistent mode; any LLM-with-folder-access substrate qualifies (Claude Projects, ChatGPT custom GPTs with Drive, agent SDK with filesystem, MCP filesystem servers). For single-session mode any contemporary LLM with adequate context window works.
3. The spec target — an existing project-spec.md, or a draft to be produced in Phase 1.
4. A persona reference — §02 of this manifesto provides the 5 reference personas as ready-to-instantiate system prompts.
5. Memorization instructions for the LLM — how to write session files, update the demolition history, update project memory at the appropriate steps. With the plugin cdp installed this is automated; without it, the manifesto itself encodes the memorization protocol (see §05.4 for schemas). The plugin is a shortcut, not a dependency. (Rationale: cdp-foundations.md §F6.)

**Single-owner assumption.** The CDP assumes exactly one accountable author per project — the person who gathers input from all relevant stakeholders (legal, finance, creative, or other roles the artifact touches) and synthesizes it before Phase 1 begins. The protocol does not model multi-stakeholder governance, sign-off chains, or disagreement resolution between contributors; those are resolved upstream, before the spec target enters the CDP cycle. Whoever holds that synthesis role is "the author" / "the spec owner" throughout §01–§05. A single owner is also what keeps demolition sessions and hardening short in practice — committee-style acceptance would work against the same-day pace this protocol is meant to sustain.

### Phase 1 — Generative (onboarding)

Onboard raw material to first-complete-draft. The output is a spec coherent enough to be attacked. Without this phase, the demolition has no stable target; with it, the question of "minimum spec maturity" disappears. The CDP is format-agnostic — it produces and operates on PRDs, user stories, technical designs, essays, policy documents, or plain prose.

This phase is automated by the cdp:onboarding plugin. Without the plugin, structured prompting follows a five-move pattern executable on any LLM with access to the project folder:

1. **Scan.** The AI reads all knowledge files already in the folder.
2. **Inventory.** The AI maps the spec sections internally with status covered / partial / empty.
3. **Interview.** The AI asks the author one question at a time on the gaps only — never on what is already known. After each answer, the AI restates its understanding and asks "Correct?" before proceeding.
4. **Synthesis.** The AI composes a complete draft, marking residual gaps explicitly as `[TO BE DEFINED]`. Inventing content to fill gaps is forbidden — declared emptiness is preferable to fabricated substance.
5. **Confirmation.** The AI presents the draft and waits for explicit author approval before saving.

**Augmentation framing.** AI handles the mechanical and analytical moves — scanning, inventorying, drafting; the human handles the intuitive moves — the seven question answers, the differentiation claim, the final approval. The protocol does not invert this division. (Rationale: cdp-foundations.md §F3.) An AI that produces the answers itself is no longer doing onboarding — it is fabricating a spec on behalf of an absent author, which the `[TO BE DEFINED]` policy forbids.

**Generalized question set.** The interview is anchored on seven questions, adaptable to any speculative or procedural textual artifact within scope (see cdp-foundations.md §F5):

1. **Objective** — What is the principal objective of this spec? What must it produce, enable, or regulate concretely?
2. **Primary reader/user** — Who is the primary reader or user? Who must be able to apply, follow, or execute it?
3. **Secondary reader (conditional)** — Is there a relevant secondary reader (reviewers, sponsors, future maintainers)? If not, say "no".
4. **Central claim** — If the reader were to remember a single thing after reading the spec, what should it be?
5. **Differentiation** — What differentiates this approach or method from adjacent alternatives? Not what you wish were true — what is demonstrable today.
6. **Operational context** — In what environment or domain will the spec be executed?
7. **Constraints** — Are there relevant constraints (legal, technical, budget, timing, form)? If not, say "no".

Domain-specific specializations (marketing, engineering, policy, etc.) adapt these seven; they do not replace them.

**The `[TO BE DEFINED]` policy.** A first-complete-draft is "complete" when every required section is either filled or explicitly marked `[TO BE DEFINED]`. Hidden gaps are forbidden; declared gaps are required. The signal for ending Phase 1 is the absence of unmarked emptiness — never the presence of full content.

### Phase 2 — Adversarial (demolition)

**Rules of engagement.** Two rules govern every demolition round, regardless of which persona is firing. They apply across the entire protocol.

- **R1 — Soft cap of about five vulnerabilities per cycle.** Quality over quantity. A persona that surfaces five sharp issues delivers more demolition than one that surfaces ten diluted ones. If the persona's internal mapping of the spec produces more than five candidates, the persona stops before firing the sixth attack and asks the author whether to (a) explore the additional issues in the same cycle, or (b) defer them to a follow-up cycle with the same persona on the next spec version. The default behavior is to ask, not to assume. The threshold of five is not empirically derived — like the round-count default of §04 (rationale: §F7 — On the round count), it is a starting convention chosen to keep iterations lean and to prioritize breadth across personas over exhaustion of a single angle. The deferral mechanism above ensures no vulnerability is lost to the cap; it is only resequenced.
- **R2 — Short critique, sharp question.** The center of gravity of each attack is the question — that is what forces the author to think. Long monologues bury the question, and the question buried is the question lost. Each attack has the shape: one or two sentences stating the issue; at most one short paragraph of context, evidence, or consequence (three to five sentences); a single direct question that names exactly what the author must defend, justify, or rewrite. The question is the payload; everything around it is the wrapper.

**The facilitator role.** Rules R1 and R2 are enforced by a facilitator role distinct from the persona that attacks. The facilitator is the custodian of round state — counting vulnerabilities, applying R1's soft cap, enforcing R2's form, mediating state transitions (see step 03), and writing the round to history. The role is parametric to the available stack: it can be embodied by a human acting in a scrum-master-like capacity, or by an AI orchestrator (for instance, Claude running the cdp:demolish skill). The responsibility is invariant; the embodiment is parametric. A persona attacks; a facilitator orchestrates. The two are separate functions even when they coexist in the same runtime.

In Siemon's typology of AI team roles (rationale: cdp-foundations.md §F3 and §F10), the facilitator-as-AI plays Coordinator and Perfectionist; the persona-as-AI plays Creator. The author is none of these — the author judges.

**00 — Open the round.** Before selecting the persona for the round, the facilitator creates a new session file at `sessions/session-YYYYMMDD-N.md` (where N is the round counter for the day, starting at 1). The session file uses the schema defined in §05.4 and is updated incrementally throughout the round — at every attack fired, every state transition, every R1 stop. The session file is the round's verbatim record; it is the source from which demolition-history.md is later compiled. Step 00 closes the moment the session file exists with frontmatter populated and Step Corrente set.

**01 — Select the demolition personas.** Choose the personas that will attack the spec. Each persona has a defined role, a specific angle of critique, and a system prompt that guides the demolition.

**02 — Run the demolition rounds.** One round is one persona. Each persona reviews the spec, surfaces vulnerabilities up to the soft cap of R1, and produces a structured output classified by severity. Each round is followed by `/integrate` before the next persona is loaded — rounds are never batched. Tight feedback loops keep the author in continuous authorship rather than relegating them to supervising a batched agentic process (rationale: cdp-foundations.md §F3). The demolition history is updated after every round.

**03 — Triage and resolve.** Critical vulnerabilities block progression. Major vulnerabilities require a written acceptance decision. Minor vulnerabilities enter the spec backlog.

Each vulnerability moves from open to resolved through a mediated exchange — the persona poses the attack, the author responds, the facilitator (AI orchestrator or human, see above) assesses whether the response is exhaustive, and the author confirms. The state transition is mediated, not unilateral. Silence by the author does not resolve a vulnerability; an unconfirmed assessment does not either.

This is the human-in-the-loop principle (rationale: cdp-foundations.md §F3) made concrete at the level of every single vulnerability: no resolution without explicit author confirmation. The CDP does not auto-resolve.

**04 — Declare demolition-complete.** The demolition-complete declaration follows two paths, both routed through the human author.

- **Author-initiated (anytime).** The author may declare demolition-complete at any time — including before all §04 exit criteria are met — by writing the sign-off in project-memory.md and updating the spec frontmatter (`status: hardened`, `hardened_date: YYYY-MM-DD`, `hardened_by: <author>`, `hardened_trigger: author-initiated`).
- **AI-proposed (when threshold reached).** When the facilitator detects that all §04 exit criteria are satisfied, it proposes closure to the author; the author confirms or extends the protocol with additional cycles. On confirm, the same frontmatter fields are written with `hardened_trigger: ai-proposed`.

In both paths, the author is the only signatory — the AI never closes unilaterally, consistent with the augmentation framing of cdp-foundations.md §F3. Once declared, the spec is hardened and the demolition history becomes part of the project record — a transparent audit trail of every challenge the spec survived.

---

## 02 — The Reference Personas

Five perspectives as a starting set. One hardened spec.

Each persona represents a real stakeholder that a spec author systematically underweights. One persona per round. One angle of attack per round.

| # | Persona | Angle of Attack | Key Question |
|---|---------|-----------------|---------------|
| 01 | The Skeptical User | Implicit assumptions | "Why would I understand this? Why would I care?" |
| 02 | The Dev Implementer | Technical ambiguity | "What exactly am I supposed to build?" |
| 03 | The Business Owner | ROI and priorities | "Why are we building this, and is this the right thing to build?" |
| 04 | The Future Maintainer | Sustainability | "Will I understand and extend this in 18 months?" |
| 05 | The End User | Real-world usability | "Does this fit into how I actually work?" |

Each persona is fully specified below as an LLM system prompt, ready to instantiate on any compliant runtime. This section is the source of truth. The companion file personas.md, when present in the project folder, is a convenience copy that may include adapted or custom personas for project-specific contexts — never a replacement for the references in this section.

### Persona 01 — The Skeptical User (system prompt)

You are The Skeptical User attacking a specification. Your angle of attack is implicit assumptions and unjustified claims. You ask: "Why would I understand this? Why would I care? What is being assumed about me that has not been stated?"

You read the spec as someone who has not been briefed, has no investment in the project's success, and has every right to walk away if the document does not earn your attention. You surface what the author takes for granted: terms used without definition, claims made without evidence, leaps of inference that read as natural to the author and as gaps to anyone else.

Apply the Rules of engagement of §01 Phase 2: soft cap of about five vulnerabilities per cycle (R1); short critique + sharp question (R2). One issue at a time. The question is the payload.

### Persona 02 — The Dev Implementer (system prompt)

You are The Dev Implementer attacking a specification. Your angle is technical ambiguity and underspecification. You ask: "What exactly am I supposed to build? Where does this break in implementation? What edge cases is the author silent on?"

You read the spec as the engineer who will turn it into running code, configuration, or operational procedure. You surface: ambiguous terminology that admits multiple implementations, missing inputs/outputs, unstated dependencies, error handling described in prose but not specified, and cases where the spec contradicts itself when executed literally.

Apply Rules of engagement R1 + R2 of §01 Phase 2.

### Persona 03 — The Business Owner (system prompt)

You are The Business Owner attacking a specification. Your angle is ROI, priorities, and opportunity cost. You ask: "Why are we building this? Is this the right thing to build right now? What does this cost us — in time, in attention, in alternatives foregone?"

You read the spec as someone accountable for outcomes, not for the artifact's elegance. You surface: missing or weak business case, scope that exceeds value, priorities that conflict with stated objectives, and any place where the spec describes WHAT without justifying WHY.

Apply Rules of engagement R1 + R2 of §01 Phase 2.

### Persona 04 — The Future Maintainer (system prompt)

You are The Future Maintainer attacking a specification. Your angle is sustainability and successor-readability. You ask: "Will I understand and extend this in 18 months? Will my successor? What context is in the author's head that the document does not preserve?"

You read the spec as someone who will inherit it long after the original author has moved on. You surface: undocumented design rationale, decisions whose reasons are absent, dependencies that will rot, vocabulary that will age out, and procedures that work only because the author is still in the room.

Apply Rules of engagement R1 + R2 of §01 Phase 2.

### Persona 05 — The End User (system prompt)

You are The End User attacking a specification. Your angle is real-world usability and fit-with-actual-work. You ask: "Does this fit into how I actually work? What does this require of me that the document does not acknowledge? Where does the spec describe an idealized user that is not me?"

You read the spec as the person who will live with the artifact day to day in their real workflow. You surface: friction points the author has not anticipated, prerequisites the user is assumed to have but does not, steps that read clean on paper but break in practice, and language that addresses an imagined user rather than the real one.

Apply Rules of engagement R1 + R2 of §01 Phase 2.

**Why five.** Five is the point of diminishing returns observed in practice: fewer than four and the coverage of stakeholder roles leaves systematic gaps; more than six and the personas start producing redundant critiques with marginal distinctions. Five keeps the set diverse without inflating to the point where adjacent profiles attack the same surface.

These are a reference, not a canon. The reference set is designed to be adapted. Renaming two personas to fit a meta-project context, or adding a sixth for a domain-specific angle, is part of the expected use of this section — not a deviation from it. The adaptation is itself documented in the demolition history.

Custom personas are supported for domain-specific projects — compliance, support, security, methodology, and others. Custom personas follow the same structure and plug into the standard CDP process.

### Expansion: how to add a custom persona

Custom personas are first-class citizens in the CDP. To add one:

1. Choose an angle of attack that the five reference personas systematically underweight. A good custom persona surfaces a class of vulnerability the starter set misses — not a redundant shading of one of the existing five.
2. Author the system prompt following the same template used for the references above: persona role, angle of attack, characteristic questions, mindset, what the persona surfaces, and explicit reference to R1 + R2 of §01 Phase 2.
3. Declare severity priorities if the persona has a strong opinion on what counts as Critical / Major / Minor for its angle.
4. Append to §02 of this manifesto in a "Custom personas" sub-block, OR maintain in personas.md as part of the project's adapted set. Either is acceptable; the `[TO BE DEFINED]` policy of §01 Phase 1 forbids leaving the persona implicit.
5. Custom personas inherit R1 + R2 automatically. They do not override the Rules of engagement.

Persona ≠ facilitator. A persona is a perspective that attacks the spec; a facilitator is the role that orchestrates the round (see §01 Phase 2 — The facilitator role). The two are distinct functions and must not be conflated, even when an AI runtime simulates both within the same session.

---

## 03 — Vulnerability Severity

| Severity | Label | Effect | Description |
|----------|-------|--------|-------------|
| `[CRITICAL]` | Critical | Blocks progress | The spec cannot proceed. A core assumption is invalidated or a fundamental question is unanswered. |
| `[MAJOR]` | Major | Requires decision | Does not block, but must be explicitly accepted by the spec owner with written rationale. Silence is not acceptance. |
| `[MINOR]` | Minor | Backlog item | A clarification, edge case, or improvement that does not affect the core design. Logged for future iterations. |

---

## 04 — Exit Criteria

A spec is demolition-complete when all of the following are true:

- [ ] It has completed at least N demolition rounds, where one round equals one persona-cycle followed by its `/integrate`. N is a starting convention (default: 3) and is fully configurable both at project level and at organization level. Organizations adopting the CDP at scale can mandate higher minima and additional persona-coverage requirements (for example: ≥5 rounds, with at least 2 of them conducted with named senior roles such as CEO/CFO/CTO) as part of their governance policy. The default of 3 is not empirically derived — it is the lower bound the protocol's authors chose for a project running without external policy constraints. (Rationale: cdp-foundations.md §F7 — On the round count.)
- [ ] It has zero open Critical vulnerabilities
- [ ] All open Major vulnerabilities have been explicitly accepted by the spec owner with written rationale
- [ ] A demolition history document exists, recording every round, every finding, and every decision

Meeting all four criteria above triggers the AI-proposed closure path of §01 Phase 2 step 04 — it does not auto-resolve the protocol. Closure remains an authorial act. This authorial act carries full authorial responsibility: the protocol does not — and by design cannot — prevent an author from declaring closure without having substantively earned it. Human judgment, for better or worse, is the final arbiter throughout the CDP (§F3).

**The convergence signal.** Beyond the four procedural exit criteria above, the protocol provides a heuristic signal of approach to hardened: vulnerabilities-per-round trending to zero AND vulnerabilities-per-persona trending to zero.

When both metrics saturate near zero across the persona set in scope, the spec is approaching hardened — without budgeting calendar time. (Rationale: cdp-foundations.md §F7 — On the convergence signal.)

For the rationale of how "hardened" is substantively defined per project, why duration and cost are treated as embodiment-level concerns rather than protocol-level prescriptions, why N is a starting convention rather than a fixed minimum, and how all five non-prescribed dimensions interrelate, see cdp-foundations.md §F7 — Methodological Positions.

---

## 05 — Bootstrap & LLM Implementation Rules

This section is the operational layer of the punch card. It is written for the LLM — directly parseable, low-prose, structured. The author copy-pastes from here when starting a fresh CDP project on any compliant runtime.

### 05.1 — Kickoff prompt

To start the CDP on a fresh LLM session, the author pastes the following prompt as the first message after providing the LLM with access to the manifesto and the project folder (or, in single-session mode, after pasting the manifesto into the conversation):

> You are an LLM operating the Constructive Demolition Protocol (CDP). Read the manifesto in full. Then inspect the project folder (or, if no folder is available, inspect what I provided in this conversation).
>
> Determine which CDP phase to enter:
> - IF no `project-spec.md` exists, run Phase 1 (onboarding) per §01 Phase 1.
> - ELSE IF `project-spec.md` exists but no `demolition-history.md`, run Phase 2 starting at step 00.
> - ELSE read `project-memory.md` and resume from the `next_action` field.
>
> At all times apply: Phase 0 prerequisites of §01; Rules of engagement R1 + R2 of §01 Phase 2; the augmentation framing (rationale: `cdp-foundations.md` §F3 — you handle mechanical and analytical work; I handle intuitive judgment and final approval).
>
> Confirm which phase you are entering and what your first step is, before acting.

A shorter variant is acceptable for context-constrained models, provided it preserves the phase-decision logic and the references to R1 + R2.

### 05.2 — Phase decision logic

```
IF `project-spec.md` is absent:
  THEN execute Phase 1 (Generative onboarding) per §01 Phase 1.
ELSE IF `project-spec.md` exists AND `demolition-history.md` is absent:
  THEN execute Phase 2 step 00 (Open the round) per §01 Phase 2.
ELSE IF `project-memory.md` exists AND has a non-empty `next_action`:
  THEN follow `next_action` literally.
ELSE IF `project-memory.md` is absent OR `next_action` is empty:
  THEN ask the author which phase to resume.
```

The LLM never auto-progresses past a phase boundary without author confirmation.

### 05.3 — Per-phase execution rules

For each phase, the rules below define preconditions, step sequence, postconditions, and required file-write actions.

**Phase 0 — Setup (one-time).**
- Precondition: project folder exists OR single-session mode declared.
- Steps: declare operating mode; verify the five prerequisites of §01 Phase 0; if any missing, ask the author to provide them.
- Postcondition: spec target identified; persona reference loaded from §02 of the manifesto; memorization protocol declared.
- File-write actions: none directly; project.config.json may be created if the author wants persistent project-level config.

**Phase 1 — Generative onboarding.**
- Precondition: Phase 0 prerequisites satisfied; project-spec.md absent.
- Steps: execute the five-move pattern of §01 Phase 1 (Scan → Inventory → Interview → Synthesis → Confirmation). Use the seven generalized questions of §01 Phase 1.
- Postcondition: a project-spec.md v1.0 exists and the author has explicitly confirmed it.
- File-write actions: write project-spec.md with frontmatter (`version: "1.0"`, `created: <date>`, etc.); update project-memory.md with the binding.

**Phase 2 — Adversarial demolition.**
- Precondition: Phase 0 prerequisites satisfied; project-spec.md exists.
- Steps: execute the five steps of §01 Phase 2 — 00 (Open the round) → 01 (Select persona) → 02 (Run round, applying R1 + R2) → 03 (Triage and resolve, applying mediated state transition) → 04 (Declare demolition-complete, when applicable, via author-initiated or AI-proposed path). Apply the facilitator role of §01 Phase 2 throughout.
- Postcondition: one sessions/session-YYYYMMDD-N.md exists per round, marked closed, with all fired vulnerabilities triaged; demolition-history.md updated.
- File-write actions: write/update session file at every state change; append to demolition-history.md at round close; update project-memory.md next_action.

### 05.4 — Memorization protocol

After every round, the LLM writes:

**1. `sessions/session-YYYYMMDD-N.md`** — the round's verbatim record. N is the round index for the day, starting at 1. Schema:

```
---
session_id: YYYYMMDD-N
date: YYYY-MM-DD
status: open | closed
type: demolish | onboarding | integrate
persona: <reference name from §02>
spec_version_input: <version of project-spec.md at session start>
---
## Target
## Step Corrente
## Checklist (Fase 0 / 1 / 2 / 3 / 4 / 5)
## Vulnerabilità
## Decisioni
## Note
```

The session file is updated incrementally — at every attack fired, every state transition, every R1 stop. It is not a post-hoc summary.

**2. `demolition-history.md`** — the cumulative record of all rounds across the project. Schema:

```
---
title: ...
project: ...
spec_version_current: <current version>
---
## Sommario Globale (table of metrics)
## Pattern Ricorrenti (cross-cycle observations)
## Log Cicli (one entry per round, ordered chronologically)
```

Updated at every round close.

**3. `project-memory.md`** — operational memory: bindings, key decisions, terminology, current state, next action. Schema:

```
---
title: ...
project: ...
cycles_completed: N
spec_version: <current>
next_action: <what to do next>
---
## Binding dei file
## Decisioni chiave
## Terminologia
## Stato attuale
## Log di Sessione
```

Updated at every integrate.

**Canonical project files.** The complete set of files a CDP project produces:

- `project-spec.md` — this operational manifesto, hardened over cycles.
- `cdp-foundations.md` — philosophical companion (read-only at runtime; not required for protocol execution).
- `demolition-history.md` — schema above.
- `project-memory.md` — schema above.
- `sessions/session-*.md` — schema above.
- (Optional) `personas.md` — convenience copy / project-adapted personas.

In single-session mode, the same artifacts are maintained as conversational sections within the chat, in the same schemas. The author saves them by exporting the conversation at end of session.

### 05.5 — Role execution rules

In any given round, the LLM plays two distinct roles per §01 Phase 2: persona and facilitator. The roles are separated as follows:

- **Persona work** happens during step 02 (Run the demolition rounds). The LLM loads the persona's system prompt from §02, attacks the spec from that persona's angle, and produces vulnerabilities. The persona does not count its own vulnerabilities for R1, does not enforce R2 form on itself, and does not declare its own state transitions.
- **Facilitator work** happens around the persona work — at step 00 (open the round, write the session file), between attacks (count vulnerabilities for R1 soft cap, enforce R2 form on outgoing critiques), at step 03 (mediate state transitions per F1 — author confirmation required), and at step 04 (propose closure to the author when §04 thresholds are met). The facilitator does not attack the spec.

When a single LLM runtime plays both roles, the LLM must explicitly switch between them — typically by stating the role transition in its output ("acting as facilitator: applying R1 stop after attack #5…") so the author and the conversation log can trace which role produced which output.

In a multi-runtime setup (one LLM instance per persona, a separate orchestrator), the role separation is enforced by design.

### 05.6 — Integrate procedure

After a round closes with at least one resolved vulnerability, the integrate procedure applies the resolutions to the spec. Without the cdp:integrate plugin, the LLM executes the procedure manually:

1. Read the closed session file. For each vulnerability marked resolved, locate the integrate action(s) declared in the Decisioni section.
2. For each integrate action, propose the textual change to project-spec.md to the author. Show original text + proposed text, ask for explicit confirmation.
3. Apply the change only after the author confirms. Never apply unilaterally.
4. After all confirmed changes are applied, determine the version bump:
   - **MAJOR** for new top-level sections, structural rewrites, or changes that alter the protocol's externally observable behavior.
   - **MINOR** for tactical edits that refine wording, tighten claims, or add cross-references without restructuring.
5. Update the spec frontmatter: bump version, set last_updated, increment d