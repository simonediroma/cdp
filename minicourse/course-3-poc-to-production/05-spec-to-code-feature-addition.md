# 05 — `/cdp:spec-to-code` in FEATURE-ADDITION Mode

🎬 Video: [`video-prompts.md#05-spec-to-code-feature-addition`](video-prompts.md#05-spec-to-code-feature-addition)

---

Same command as Course 2 Lesson 01, same Spec Frozen gate — but the process it runs is the FEATURE-ADDITION variant, and it produces a *delta*: what's new, not what already exists.

## Step 1 — analyze PRD + architecture context together

`architecture-context.md` was already loaded in Step 0 (it's mandatory here — Lesson 01's table). From the PRD: what to build, acceptance criteria, users involved, critical flows. From the architecture context: the existing stack, which models/entities the feature touches or extends, naming and error-handling patterns already in use, and the specific files or modules that will be modified. Nothing here gets re-asked — if the architecture context already answered it, the skill uses it directly.

## Step 2 — decompose into delta macros

The same four-step guided process from Course 2 Lesson 01, adapted:

- **A** — extract only the flows *this feature introduces*, not the product's existing flows
- **B** — group by domain, same splitting rule for groups crossing two independent domains
- **C** — size and order: model/DB changes first, then business logic, then APIs, then frontend. **No `M0`** — the repo already exists, there's nothing to scaffold. Any macro touching existing shared code (middleware, base models, auth) has its risk level raised automatically. Anything touching a module the architecture context doesn't describe gets flagged `⏳ SPIKE PENDING`
- **D** — print the delta macro table, wait for confirmation, same as always

## Step 3 — risk and spikes, with one addition

Identical logic to GREENFIELD, plus the shared-code risk escalation from Lesson 01. Spike triggers also expand: beyond an unknown API contract or an undecided library, a FEATURE-ADDITION spike also covers existing modules that aren't described in `architecture-context.md` but that the macro needs to touch, or undocumented current behavior the macro depends on. Lesson 06 covers what happens with these.

## Step 4 — configuration files, only if not already present

If `CLAUDE.md` (or `.cursor/rules/01-operative.mdc`) already exists from Course 2, it is **not overwritten**. The skill only flags in `HANDOFF.md`/`SETUP.md` if the Invariant Files section needs an addition — a new "do not touch" discovered during this feature's analysis.

## Step 5 — `docs/context.md`, not `docs/lessons.md`

A new file, specific to this feature: existing stack, which modules are involved and their role in the feature, existing patterns to follow, conventions, and what not to touch. `docs/deploy-setup.md` is **not** regenerated — the deploy infrastructure already exists. If the feature genuinely needs new infrastructure (a new service, a new external dependency), that becomes a spike, not a silent rewrite of the existing setup guide.

## Steps 6-7 — prompts and memory, feature-branch shaped

Every macro prompt gets one section GREENFIELD prompts don't have: **"Existing modules to read first"** — the specific files this macro needs to understand before touching anything. `CLAUDE_MEMORY.md` (or `02-memory.mdc`) is adapted too: no `M0` to track, the first entry is the first delta macro.

## Check your understanding

- Why does a FEATURE-ADDITION macro plan never include `M0`, and what does that imply about macro numbering carried over from a previous feature cycle?
- What's the one section every FEATURE-ADDITION macro prompt has that a GREENFIELD prompt doesn't, and why does it matter more here?

*Next: [06 — SPIKE PENDING Macros](06-spike-pending-macros.md).*
