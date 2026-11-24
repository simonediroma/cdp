# Glossary

Alphabetical. Each entry is deliberately short — enough to unblock you mid-lesson, not a substitute for the linked resource in `02-useful-resources.md` if you want the full picture. Two reference appendices follow the alphabetical list: every file name the plugin or the CDP protocol uses, and every plugin command with a one-line description.

---

**5-axis code review** — The review that closes every macro's Pre-PR Gate regardless of risk level: correctness, security, readability, performance, and "surgical" (does every changed line trace back to the requirement). See Course 2 Lesson 03, Course 4 Lesson 02.

**Agent-skills rules** — This minicourse's term for the five embedded engineering behaviors (Doubt-Driven Review, TDD, security checklist, Shipping checklist, 5-axis code review) that the plugin's own reference file internally labels "Osmani" — see that entry for why this course names them after the repo (Addy Osmani's `agent-skills` Claude Code plugin) rather than the person. Course 2 Lesson 04.

**API Contract / Hyrum's Law** — A macro prompt's "API Contract" section requires defining input/output types before writing handlers and never silently removing or renaming an exposed field. The underlying principle is Hyrum's Law: with enough users of an API, every observable behavior of it will eventually be depended on by someone, whether you intended it as a contract or not — so treat every field you expose as one. Generated automatically by `/cdp:spec-to-code` for any macro that exposes endpoints.

**Architecture-context.md** — The file that gives `/cdp:spec-to-code` and `/cdp:arch-init` enough knowledge of an existing codebase (stack, key modules, conventions, and — always asked for explicitly — what NOT to touch) to generate contextualized macros instead of generic placeholders. Optional for GREENFIELD, required for FEATURE-ADDITION. Course 3 Lessons 01-03.

**Augmentation (vs. automation)** — The CDP's central design commitment: the AI does mechanical and analytical work (scanning, drafting, finding patterns in attacks), the human keeps every decision that actually touches the spec. An AI technically capable of running a persona but that starts deciding for the author has crossed into automation and broken the protocol, even if nothing else changed. Appendix's CDP Protocol deep dive, Lessons 02 and 04.

**Cascade (cascade-checking)** — `/cdp:integrate`'s check for ripple effects before applying a resolved vulnerability: a redefined objective, for instance, might invalidate something stated elsewhere in the spec. Flagged instead of silently leaving the spec inconsistent. Course 1 Lesson 06.

**Change Request** — What `/cdp:spike-integrate` opens, on top of an unblocked macro, when a resolved spike changed scope versus the original PRD (new acceptance criteria, more modules touched, a real risk-level jump, or an entirely new macro). Linked back to the original requirement, what changed, and why. Course 3 Lesson 07.

**Chesterton's Fence** — A parable (G.K. Chesterton, *The Thing*, 1929): don't remove a fence until you understand why it was put there. Used in Course 3 Lesson 01 as the reasoning behind FEATURE-ADDITION's automatic risk escalation for shared code — understand why existing code is built the way it is before changing it. See `02-useful-resources.md` for the original argument.

**CI/CD** — Continuous Integration / Continuous Deployment: the automated pipeline that builds, tests, and (for CD) deploys code on every change. Referenced as a trigger for the `M_deploy` macro ("non-trivial CI/CD") in Course 2 Lesson 01 and Course 3's decomposition rules.

**Composer** — Cursor's chat-and-edit interface (opened with `Cmd+I`), where you write prompts and Cursor proposes/applies code changes. Course 2 Lesson 05 covers the Cursor execution flow through it.

**Confluence** — Atlassian's wiki/documentation product. `/cdp:arch-init` (Course 3 Lesson 03) can query a connected Confluence MCP server to pull confirmed stack and convention details when generating `architecture-context.md`.

**Constructive Demolition Protocol (CDP)** — The full name behind the acronym used throughout this course: a domain-agnostic method for finding a specification's blind spots through controlled, structured, adversarial review before anyone starts building from it — "demolish your specification before reality does." Taught hands-on through the `claude-cdp` plugin in Course 1, and in full plugin-agnostic depth in the Appendix's CDP Protocol deep dive.

**Convergence signal** — An observational heuristic for approaching a hardened spec, distinct from the four formal exit criteria: vulnerabilities-per-round and vulnerabilities-per-persona both trending toward zero. Not a fifth requirement — a signal that a round concluding fast means that angle is already robust. Appendix's CDP Protocol deep dive, Lesson 13.

**Coverage map** — `/cdp:arch-init`'s internal tracking of `architecture-context.md`'s sections (tech stack, repo structure, key modules, conventions, design system) as auto-detected, partial, or missing — the basis for asking about gaps only, one at a time. Course 3 Lesson 03.

**Declared limitation** — One of the three ways a demolition attack can close, alongside modifying the claim or narrowing the scope: explicitly accepting a vulnerability as a known boundary rather than fixing it. Requires a written rationale — silence never counts as one. Course 1 Lesson 06; Appendix's CDP Protocol deep dive, Lesson 11.

**Demolition history** — `demolition-history.md`, the cumulative, chronological record of every round, every persona, every vulnerability, and every resolution across a spec's hardening cycles. One of the three canonical memory files, and the artifact the four exit criteria ultimately check against. Appendix's CDP Protocol deep dive, Lessons 13-14.

**Deploy Discovery** — The mandatory interview `/cdp:spec-to-code` runs before macro decomposition, for GREENFIELD projects only: the plugin proposes a concrete deploy setup (platform, strategy, rough cost), then refines it with the author on budget, provider, region, and domain before confirming. Feeds both `M_deploy`'s trigger and `docs/deploy-setup.md`. Course 2 Lesson 02.

**DNS** — Domain Name System, the internet's address book (translates a domain name like `yourapp.com` to a server's actual address). Comes up in Course 2 Lesson 02 and 06's Deploy Discovery / Shipping checklist — "does the domain resolve" is literally a DNS question.

**Docker / Dockerfile** — Docker packages an application and everything it needs to run into a portable "container"; a `Dockerfile` is the recipe that builds one. Course 2's `M0` scaffold macro always produces one for GREENFIELD projects (Lesson 01, Lesson 03).

**docs/lessons.md** — The consolidated-patterns document `/cdp:spec-to-code` generates for GREENFIELD projects as macros complete; FEATURE-ADDITION generates `docs/context.md` instead, scoped to the one feature rather than the whole product. Course 3 Lesson 01.

**Doubt-Driven Review (CLAIM / DOUBT / RECONCILE)** — One of the five agent-skills-derived behaviors, required for HIGH-risk macros: state a decision as an explicit CLAIM, list 2-3 ways it could be wrong (DOUBT), then verify or adjust (RECONCILE) — capped at 3 cycles, after which an unresolved doubt means stop and ask a human rather than keep looping. Works pointed backward at a decision that already shipped just as well as forward at one not yet made. Course 2 Lesson 04, Course 4 Lesson 07.

**Exit criteria** — The four procedural conditions that make a spec "demolition-complete": at least N rounds (default 3), zero open Critical vulnerabilities, every open Major explicitly accepted with written rationale, and a demolition history recording all of it. A floor the author or facilitator can propose closing against — never a bar the AI closes unilaterally. Appendix's CDP Protocol deep dive, Lesson 13.

**Explainability by construction** — The claim that the demolition history is an audit trail as a side-effect of running the protocol as written, not a separate documentation step bolted on afterward: session files, history, and memory get written at every round close because the procedure requires it. Appendix's CDP Protocol deep dive, Lesson 16.

**Facilitator** — In the CDP manifesto, the role that orchestrates a demolition round (enforcing R1/R2, mediating state transitions, writing history) as distinct from the persona that attacks. The Appendix's CDP Protocol deep dive (Lesson 09) covers the distinction; note that the installed plugin doesn't currently separate the two into distinct narrated roles (same lesson).

**First-complete-draft** — The output Phase 1 (generative onboarding) is aiming for: a spec coherent enough to actually be attacked, with every gap explicitly marked `[TO BE DEFINED]` rather than hidden or invented. Not the same as a hardened spec — it's what demolition starts from, not what it ends with. Appendix's CDP Protocol deep dive, Lesson 08.

**Five moves (Scan → Inventory → Interview → Synthesis → Confirmation)** — Phase 1's generative-onboarding procedure: read what already exists, map it as covered/partial/empty, interview the author on the gaps only, compose a draft marking residual gaps `[TO BE DEFINED]`, then wait for explicit approval before saving. Appendix's CDP Protocol deep dive, Lesson 08.

**Frontmatter** — The YAML block at the top of a markdown file, delimited by `---`, holding structured metadata (version, dates, status) that tools can read without parsing the whole document. `project-spec.md`'s frontmatter (Appendix's CDP Protocol deep dive, Lesson 08, 12) and every course lesson file in this minicourse both use it.

**GREENFIELD / FEATURE-ADDITION** — The two modes `/cdp:spec-to-code` operates in: building a new project from scratch versus adding a feature to an existing codebase. Courses 1-2 cover GREENFIELD; Course 3 Lesson 01 covers the difference in full.

**Glob pattern** — A wildcard-based file-matching pattern (e.g. `"**/routes/*"` matches any file inside any `routes/` folder, at any depth). Cursor's `.mdc` rule files use globs to decide when a macro's rule activates automatically — Course 2 Lesson 03 covers this; the pattern syntax itself is standard across most build/dev tooling, not CDP-specific.

**Hardened (spec)** — What a spec is called once it has survived rounds of adversarial demolition — not because it feels done, but because its vulnerabilities were triaged and either fixed or consciously accepted, with a written record proving it. The prerequisite `/cdp:spec-to-code` refuses to proceed without. Course 1 throughout.

**Health-check endpoint** — A URL a deployed service exposes (often `/health` or `/status`) that returns a simple "I'm alive and working" response, used to verify a deployment actually succeeded. Central to the `M_deploy` macro's Shipping checklist (Course 2 Lesson 06).

**Idempotent** — An operation that produces the same result no matter how many times you run it. Course 2 Lesson 06 requires the deploy command to be idempotent — running it twice shouldn't break the running service.

**Interdependency** — In the CDP's human-AI collaboration framing, the specific relationship the protocol occupies: distinct from Competition, Supplementation, or the further step, Hybrid. The persona has nothing to attack without the author's spec, and the author can't see their own blind spots without the persona's pressure — neither side produces a hardened spec alone, and the protocol deliberately stops short of Hybrid, where authorship itself would dissolve. Appendix's CDP Protocol deep dive, Lesson 04.

**Invariant ("What NOT to touch")** — The section of `architecture-context.md` listing files or modules a macro is never allowed to modify regardless of convenience. The one field `/cdp:arch-init` always asks about explicitly, even when everything else auto-detects cleanly, because there's no reliable way to infer it from a repo scan. Course 3 Lessons 02-03.

**JWT (JSON Web Token)** — A compact, signed token format commonly used to carry authentication claims (who's logged in, what they're allowed to do) between a client and server without a server-side session lookup. Appears throughout Course 2/4 as a HIGH-risk trigger (auth macros).

**Jira** — Atlassian's issue-tracking product. `/cdp:spec-to-code` and `/cdp:spike-integrate` can optionally populate it (Epics, Stories, Spikes, Change Requests) if a Jira MCP connection is available — Course 2 Lesson 01, Course 3 Lessons 06-07.

**Key Modules** — The `architecture-context.md` table mapping module names to paths and one-line responsibilities — one of the two sections (with "What NOT to touch") that carries disproportionate weight over how precisely `/cdp:spec-to-code` can write a FEATURE-ADDITION macro. Course 3 Lesson 02.

**Loop engineering** — Replacing a single improvised drafting or build pass with a fixed sequence of stages, each with a defined input, output, and gate before moving to the next: memory persists between sessions, risk is tracked per stage, and "done" is checked against written criteria instead of felt. Names the whole five-course sequence; Course 1 Lesson 01 covers it in full, with a direct comparison against vibe coding.

**Macro** — The unit of implementation work `/cdp:spec-to-code` decomposes a frozen spec into: a self-contained prompt with context, an objective, acceptance criteria, and a Pre-PR Gate scaled to its risk level. Sized (XS-XL), ordered by dependency, and named `M0`, `M1`, etc. — or flagged `⏳ SPIKE PENDING` when there isn't enough information to write one. Course 2 Lesson 01.

**M0 (Scaffold macro)** — The one macro every GREENFIELD plan starts with: fixed, identical content across projects, always present because there's nothing yet to build on. Never appears in a FEATURE-ADDITION plan, since the repo it would scaffold already exists. Course 2 Lesson 01, Course 3 Lesson 01.

**M_deploy** — The macro that provisions the infrastructure decided during Deploy Discovery and gets the current build reachable at a public URL. The only macro gated by the Shipping checklist instead of the ordinary risk-scaled Pre-PR Gate. Course 2 Lesson 06.

**MCP (Model Context Protocol)** — An open standard (created by Anthropic) for connecting an AI application to external tools and data sources — Jira, Confluence, a filesystem, a database — through a common protocol instead of a bespoke integration per tool. Every "if a Jira MCP connection is available" and "Confluence MCP" reference across Courses 2-3 is this. See `02-useful-resources.md` for the full explanation.

**Mediated resolution** — The CDP's rule that no vulnerability, edit, or phase transition applies itself: the persona attacks, the author responds, and the state only moves from open to resolved (or a spec change gets applied) after explicit confirmation. Silence never resolves anything, and an unconfirmed assessment doesn't either. Appendix's CDP Protocol deep dive, Lessons 09 and 12.

**Memory file** — The persisted record a session reads before doing anything else: `cdp-memory.md` for the spec-hardening loop, `CLAUDE_MEMORY.md` / `.cursor/rules/02-memory.mdc` for implementation. Tracks decisions, blockers, and the next concrete step, which is what makes `/cdp:resume` and "what's the next task?" actually mean something. Course 1 Lesson 01, Course 2 Lesson 03.

**Meta-principle (the CDP validates itself)** — The claim that makes the protocol trustworthy rather than merely plausible: the CDP has itself survived its own demolition, and the [cdp claude plugin](https://github.com/simonediroma/cdp)'s `demolition-history.md`, `cdp-memory.md`, and `sessions/` folder are the record of that self-application. "If the CDP cannot withstand its own method, it does not deserve to exist." Appendix's CDP Protocol deep dive, Lesson 03.

**Missed spike** — A bug that isn't really an implementation mistake but an unverified assumption that should have been flagged as `⏳ SPIKE PENDING` and wasn't. The tell: the "fix" is a guess dressed up as a patch. Treated by investigating retroactively, the same shape as a spike stub, rather than patched like an ordinary bug. Course 4 Lesson 05.

**Non-prescribed dimensions** — The five things the manifesto deliberately declines to legislate — what "hardened" substantively means, round duration, cost, round count, and total time-to-value — because a single fixed rule for any of them would work for some domains and distort others. An observational signal (the convergence signal) fills the gap where one exists, instead of a rule. Appendix's CDP Protocol deep dive, Lesson 15.

**OAuth** — An authorization protocol that lets a user grant one application limited access to their data on another, without sharing a password (the "sign in with Google" pattern). Named as an auth option throughout Course 1/2/4 wherever authentication is discussed.

**Osmani** — The plugin's internal label (`osmani-skill-map.md`) for the five embedded engineering behaviors — Doubt-Driven Review, TDD, security checklist, Shipping checklist, 5-axis code review — naming a person where the confirmed source is actually a repo: Addy Osmani's `agent-skills` Claude Code plugin (`github.com/addyosmani/agent-skills`), never cited directly in the [cdp claude plugin](https://github.com/simonediroma/cdp). Course 2 Lesson 04 traces the label to that source and, from there on, calls these the **agent-skills rules** — see that entry for the term used elsewhere in this minicourse. `document/osmani-agent-skills-gap-analysis.md` has the full comparison against the source, and `document/osmani-skills-boilerplate-matrix.md` breaks it down skill by skill (all 24) across both the Claude Code and Cursor tracks.

**OWASP Top 10** — A regularly updated list, maintained by the OWASP Foundation, of the most critical web application security risks. The security checklist embedded in every HIGH-risk macro prompt explicitly requires checking against it (Course 2 Lesson 03, Course 4 Lesson 02).

**PaaS (Platform as a Service)** — A hosting model where the provider manages the underlying servers and infrastructure and you just push code (as opposed to managing your own containers or VMs). Course 2 Lesson 02's Deploy Discovery proposals (Railway, Render) are typically PaaS.

**Persistent mode / Single-session mode** — The two operating modes Phase 0 declares before anything else: persistent (an LLM with folder read/write access — what the plugin gives you) or single-session (no folder, the whole cycle lives inside one chat's context, exported at the end). Protocol behavior is identical either way; only where the state lives differs. Appendix's CDP Protocol deep dive, Lesson 07.

**Persona** — A simulated stakeholder role, instantiated as an AI system prompt, whose job is to attack a spec from one angle per round — never to author or fix it. Distinct from a facilitator, which orchestrates the round instead of attacking. The plugin ships six marketing personas by default; The Five Reference Personas are the generic, software-friendly alternative. Course 1 Lesson 06; Appendix's CDP Protocol deep dive, Lesson 10.

**Pre-PR Gate** — The set of checks (5-axis review, plus TDD/Doubt-Driven Review/security checklist depending on risk) every macro prompt requires before a PR is considered mergeable. Course 2 Lesson 03, Course 4 throughout.

**PRD (Product Requirements Document)** — A document describing what to build and why; the generic term `/cdp:spec-to-code` uses for its required input, whether or not it came from `/cdp:onboarding`. Course 1 Lesson 05 and Course 2 Lesson 01.

**project-memory.md** — The third canonical memory file in the manual, no-plugin version of the protocol (alongside the session files and `demolition-history.md`): bindings, key decisions, terminology, current state, and a `next_action` field that lets a fresh session resume cold. Distinct from the plugin's own `cdp-memory.md`, which doesn't carry a `next_action` field. Appendix's CDP Protocol deep dive, Lessons 14 and 16.

**Propose-then-refine** — The interview pattern shared by `/cdp:onboarding` and Deploy Discovery: the plugin states a concrete first draft rather than opening with a blank question, then asks only about what the proposal didn't already resolve, one question at a time, before asking for final confirmation. Course 2 Lesson 02.

**Punch card (manifesto metaphor)** — The design metaphor behind platform-agnosticism: `document/cdp-manifesto.md` is meant to be a self-contained instruction set that instantiates the protocol on any sufficiently capable LLM, the way a punch card ran the same program on any compatible machine — provided it's self-explanatory and bootstrappable from an empty folder. Appendix's CDP Protocol deep dive, Lesson 06.

**RBAC (Role-Based Access Control)** — An authorization model where permissions are attached to roles (admin, editor, viewer) rather than to individual users directly. Listed throughout Course 2/4 as a HIGH-risk trigger.

**Regression discipline** — The closing obligation of every bugfix: keep the reproduction test permanently (not delete it once green), re-run the Pre-PR Gate on the fix itself, check whether the same wrong assumption appears elsewhere in the codebase, and record the decision where the next person will see it. Scales down for Minor bugs, close to non-negotiable for Critical/Major ones. Course 4 Lesson 11.

**Reproduce → Isolate → Fix → Verify** — The bugfixing loop, a direct mapping onto TDD's RED-GREEN-REFACTOR: write a test that fails because of the actual bug, narrow it to the smallest responsible unit, make the minimum change that passes it, then confirm the fix addresses the root cause and not just that one path to the symptom. Course 4 Lesson 06.

**Risk level (risk tier)** — The rating — LOW, MEDIUM, HIGH, FRONTEND, FRONTEND HIGH, or DEPLOY — every macro gets during decomposition, determining which gates its prompt embeds. Touching existing shared code (middleware, base models, auth) in FEATURE-ADDITION mode raises a macro's risk level automatically, regardless of how small the change looks. Course 2 Lesson 01, Course 3 Lesson 01.

**Rollback** — Reverting a deployment to the previously working version after a bad release. Course 2 Lesson 06 requires the rollback procedure to be actually exercised once, not just documented, before `M_deploy` is considered done.

**Rules of engagement (R1 / R2)** — The two rules every demolition round follows regardless of persona: R1, a soft cap of about five vulnerabilities per round before the persona stops and asks whether to continue or defer the rest; R2, the fixed shape of each attack — one or two sentences on the issue, brief context, and a single sharp question. Enforced by the facilitator. Appendix's CDP Protocol deep dive, Lesson 09.

**Session types** — The four categories `/cdp:session-start` asks you to choose from when opening a session — onboarding, demolition, integration, review — or you can describe the work freely and let it infer the closest fit (a bugfix investigation, for instance, behaves most like a review session). Course 3 Lesson 08, Course 4 Lesson 09.

**Severity (Critical / Major / Minor)** — The three-tier classification every demolition finding — and, in Course 4, every bug — gets triaged into: Critical blocks progress outright, Major requires an explicit written acceptance if not fixed ("silence is not acceptance"), Minor goes to the backlog without blocking anything. Appendix's CDP Protocol deep dive, Lesson 11; Course 4 Lesson 03.

**Shipping checklist** — The seven-point gate that replaces the ordinary Pre-PR Gate for the `M_deploy` macro alone: environment variables set on the platform, no committed secrets, a working health check, DNS resolution, a rollback procedure actually exercised once, and cost matching the agreed budget. Only after it passes does the familiar 5-axis review apply, to the deploy configuration itself. Course 2 Lesson 06.

**Single-owner assumption** — The CDP's premise that exactly one accountable author exists per project, who has already synthesized input from whatever stakeholders the artifact touches before Phase 1 begins. The protocol doesn't model multi-stakeholder sign-off chains — that's resolved upstream, and it's part of why demolition rounds stay fast. Appendix's CDP Protocol deep dive, Lesson 07.

**Spec gap (a bug reveals a spec gap)** — When a bug's real cause isn't an implementation mistake but the spec itself being silent, ambiguous, or wrong about the case that broke — two people could have built two different, both-defensible behaviors from the same text. Routed to `/cdp:integrate` or a fresh demolition round, not patched in code alone. Course 4 Lesson 10.

**Spike / SPIKE PENDING** — A macro marked `⏳ SPIKE PENDING` instead of getting a full implementation prompt when there's genuinely not enough information to write one (an unknown API contract, an undecided library, an undocumented existing module). Produces a `docs/spike-M<N>.md` stub, investigated and filled in until `RESOLVED`, at which point `/cdp:spike-integrate` rewrites the macro it was blocking. Course 2 Lesson 01, Course 3 Lessons 06-07.

**TDD (Test-Driven Development) / RED-GREEN-REFACTOR** — Writing a failing test first (RED), writing the minimum code to pass it (GREEN), then cleaning up without changing behavior (REFACTOR). Course 2 Lesson 03 and Course 4 Lesson 06 both build on this; see `02-useful-resources.md` for a fuller treatment if TDD itself is new to you.

**T-shirt sizing (XS-XL)** — The rough sizing scale (`XS`/`S`/`M`/`L`/`XL`) applied to each macro candidate during decomposition, alongside its risk level and dependency order. Course 2 Lesson 01.

**The Five Reference Personas** — The Skeptical User, the Dev Implementer, the Business Owner, the Future Maintainer, and the End User: the manifesto's default attack angles, each surfacing a different systematic blind spot. A reference, not a canon — renaming or adding a domain-specific sixth is expected use as long as it's documented. Appendix's CDP Protocol deep dive, Lesson 10.

**Track (Claude Code / Cursor)** — The two parallel output formats `/cdp:spec-to-code` can generate from the same spec: `CLAUDE.md`/`CLAUDE_MEMORY.md`/`prompts/` for Claude Code, or always-active plus glob-activated `.cursor/rules/*.mdc` files for Cursor. Neither is the "real" one; `docs/architecture.md` and `docs/context.md` are the two files that never fork between them. Course 2 Lesson 03, Course 3 Lesson 09.

**Trigger phrase** — The exact phrase ("what's the next task?" for Claude Code, "next task" for Cursor) that fires a macro-execution session and its memory-file update. Deliberately strict — a read-only request like "explain this file" doesn't match it, so exploratory questions get answered without triggering the session-status ritual. Course 2 Lesson 05.

**Two frontiers (too late / too small to harden)** — The CDP's only scope boundary, stated as a property rather than a list of domains: too late (a spec already finalized externally, with no generative window left) and too small (an artifact below the complexity needed to give five personas distinct angles). If running the protocol here would produce ceremony instead of hardening, decline. Appendix's CDP Protocol deep dive, Lesson 05.

**Vendor lock-in / stack drift** — The two risks the CDP's platform-agnosticism is designed to avoid: dying if one AI vendor changes terms, or becoming unrunnable as one specific product evolves. The manifesto, not the plugin, is the actual portable instruction set. Appendix's CDP Protocol deep dive, Lesson 06.

**Vertical slicing** — Decomposing work by complete end-to-end feature (schema + endpoint + UI for one flow) rather than by horizontal layer (all schemas, then all endpoints, then all UI). The mandatory pattern behind `/cdp:spec-to-code`'s macro decomposition — Course 2 Lesson 01.

**Vibe coding** — Opening a chat, describing roughly what you want, and iterating by feel until something works: fast for a prototype or a one-off script, but with no memory between sessions and no risk gating once a project outlives a single sitting. Course 1 Lesson 01 names this as the failure mode loop engineering answers; Course 4 Lesson 01 extends the same critique to ad-hoc bug fixing.

**Vulnerability (CDP sense)** — What a persona's attack surfaces during a demolition round: a gap, ambiguity, or unexamined assumption in the spec — not necessarily a security defect (compare OWASP Top 10 above). Every vulnerability is triaged by severity and resolved only through mediated confirmation, never silently. Appendix's CDP Protocol deep dive, Lessons 09 and 11.

**Webhook** — An HTTP callback: instead of your app polling another service for updates, that service calls a URL you provide the moment something happens. Listed as a HIGH-risk trigger (Course 2/4) because webhook payloads are external, untrusted input arriving asynchronously.

---

## Appendix A — Files Used by the Plugin and the CDP Protocol

Every file name that recurs across the four courses, grouped by what produces it. Paths are relative to a project's root unless stated otherwise.

### A1 — Files a CDP project accumulates (the plugin's own working files)

| File | What it is |
|---|---|
| `project-spec.md` | The central spec document (10 sections) — the source of truth, produced by `/cdp:onboarding` and updated by `/cdp:integrate`. |
| `cdp-memory.md` | Defined terms, architectural decisions, open promises, and the session log — the plugin's memory file for the spec-hardening loop. |
| `demolition-history.md` | The cumulative, chronological record of every demolition round, persona, vulnerability, and resolution. |
| `project.config.json` | Project configuration: name, type, language, file paths. |
| `personas/[id].md` | One file per custom persona created or cloned via `/cdp:persona`. |
| `personas_template.md` | The blank template a new custom persona is built from. |
| `persona-interview.md` | The guided-interview script `/cdp:persona` runs to build a persona from scratch. |
| `sessions/session-template.md` | The blank template every session file is created from. |
| `sessions/[date]-[type].md` | One state file per work session, created by `/cdp:session-start`. |

### A2 — Files `/cdp:spec-to-code` and related skills generate for a target project

| File | What it is |
|---|---|
| `architecture-context.md` | Stack, key modules, conventions, and invariants for an existing codebase — optional for GREENFIELD, required for FEATURE-ADDITION. Written by hand or by `/cdp:arch-init`. |
| `docs/architecture.md` | The generated architecture doc — identical content on the Claude Code and Cursor tracks; its Tech Stack table is seeded from `architecture-context.md` when one was loaded. |
| `docs/deploy-setup.md` | The step-by-step deploy guide, generated from the confirmed Deploy Discovery decision. |
| `docs/lessons.md` | GREENFIELD's consolidated-patterns doc, updated as macros complete. |
| `docs/context.md` | FEATURE-ADDITION's equivalent of `docs/lessons.md`, scoped to the one feature being added. |
| `docs/spike-M<N>.md` | The stub a `⏳ SPIKE PENDING` macro produces — open question, hypotheses, and an "expected output" section, filled in once investigated and flipped to `RESOLVED`. |
| `CLAUDE.md` | The generated operating rules + "next task" trigger, for the Claude Code track of a target project (a different file from the [cdp claude plugin](https://github.com/simonediroma/cdp)'s own `CLAUDE.md`). |
| `CLAUDE_MEMORY.md` | The generated session-memory file for the Claude Code track — macro status, decisions, blockers. |
| `.cursor/rules/01-operative.mdc` | The Cursor-track equivalent of `CLAUDE.md` — always-active. |
| `.cursor/rules/02-memory.mdc` | The Cursor-track equivalent of `CLAUDE_MEMORY.md` — always-active, auto-updated (Rule 10). |
| `.cursor/rules/03-refs.mdc` | Technical references, always-active on the Cursor track (inline in `CLAUDE.md` on the Claude Code track). |
| `.cursor/rules/MN-<name>.mdc` | One glob-activated rule per macro, on the Cursor track. |
| `prompts/M0_scaffold.md`, `prompts/M<N>_<name>.md` | One implementation prompt file per macro, on the Claude Code track. |
| `HANDOFF.md` | Setup/onboarding instructions for the Claude Code track. |
| `SETUP.md` | Setup/onboarding instructions for the Cursor track. |
| `exports/<name>-v<version>.docx` | The shareable Word export `/cdp:export` produces from `project-spec.md`. |

### A3 — Files used only in the manual, no-plugin version of the protocol

| File | What it is |
|---|---|
| `project-memory.md` | The manifesto's own memory file — bindings, decisions, terminology, current state, and a `next_action` field. Distinct from the plugin's `cdp-memory.md`, which doesn't carry a `next_action` field. |
| `sessions/session-YYYYMMDD-N.md` | The manual naming convention for a round's session file, one per round, written by hand. |

### A4 — Reference and source files from the [cdp claude plugin](https://github.com/simonediroma/cdp) repo

| File | What it is |
|---|---|
| `document/cdp-manifesto.md` | The operational manifesto — the CDP's actual source of truth, the "how." |
| `document/cdp-foundations.md` | The foundations companion — the "why" behind the manifesto. |
| `document/plugin-alignment-review-v10.1.md` | A gap analysis documenting where the shipped plugin diverges from the manifesto. |
| `document/osmani-agent-skills-gap-analysis.md` | A practice-by-practice comparison against Addy Osmani's `agent-skills` plugin. |
| `document/osmani-skills-boilerplate-matrix.md` | A 24-row table showing where each agent-skills-sourced skill is (or isn't) implemented, across both tracks. |
| `document/self-demolition-example/` | A worked example of the plugin's own memory files (`cdp-memory.md`, `demolition-history.md`, `sessions/`), produced by running the CDP on the manifesto itself. |
| `skills/*/SKILL.md` | The actual skill/prompt-logic definitions each `/cdp:*` command executes — one folder per command. |
| `skills/spec-to-code-update/references/*.md` | Supporting reference material for `/cdp:spec-to-code`: `osmani-skill-map.md` (the agent-skills-rules mapping), boilerplate formats, decomposition rules, and the agent-skills reference map. |

`.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json` are intentionally left out of this table: they're packaging manifests Claude Desktop reads to install and list the plugin, not part of the CDP method itself — no course lesson references them, and no spec you produce ever touches them.

---

## Appendix B — Plugin Commands

Eleven commands, one plugin. Listed in rough first-use order.

| Command | What it does | Covered in |
|---|---|---|
| `/cdp:echo` | Always responds "hello world" — verifies the plugin is installed and active, nothing else. | Course 1 Lesson 03 |
| `/cdp:onboarding` | Guided interview to build `project-spec.md` v1.0: reads existing project documents, covers gaps with targeted questions one at a time, saves only after explicit confirmation. | Course 1 Lesson 05 |
| `/cdp:persona` | Creates and modifies personas for demolition cycles — guided interview, free-flow from free text, or cloning a predefined persona. | Course 1 Lesson 06 |
| `/cdp:demolish` | Runs one demolition round: reads `project-spec.md`, selects a persona, attacks vulnerabilities one at a time (one criticism per turn, zero solutions offered), evaluates responses, logs everything. | Course 1 Lesson 06 |
| `/cdp:integrate` | Integrates a demolition round's resolutions into `project-spec.md`, section by section with explicit confirmation for each change, handles version bumps, updates project memory (incl. Defined Terms). | Course 1 Lesson 06 |
| `/cdp:export` | Exports `project-spec.md` as a shareable `.docx`, guiding brand customization (primary color, logo, document name) one question at a time. | Course 1 Lesson 06 |
| `/cdp:spec-to-code` | Reads a frozen PRD and generates a complete implementation boilerplate package (Claude Code or Cursor format), decomposed into risk-leveled macros — GREENFIELD or FEATURE-ADDITION mode. | Course 2 Lesson 01, Course 3 Lesson 05 |
| `/cdp:arch-init` | Generates `architecture-context.md` by scanning the repo's build files and docs, querying Confluence MCP if available, and interviewing only for what it couldn't detect automatically. | Course 3 Lesson 03 |
| `/cdp:session-start` | Initializes a new work session: reads the current project state (partial slices only), creates a session file from the template, sets context for the work ahead. | Course 3 Lesson 08 |
| `/cdp:resume` | Reads only frontmatter and the last log rows to answer "where was I, what's next" in four fixed lines — no interview, no summary paragraph. | Course 3 Lesson 08 |
| `/cdp:spike-integrate` | Integrates resolved `docs/spike-M<N>.md` stubs back into the boilerplate: rewrites the unblocked macro's prompt, updates the memory file, and — if Jira is available — closes the spike ticket and opens a Change Request if scope changed. | Course 3 Lesson 07 |
