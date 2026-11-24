---
name: session-start
description: Initializes a new work session. Reads the current project state, creates the session file from the template, and sets the context for the work ahead.
disable-model-invocation: true
allowed-tools: Read, Write, Glob
---

# Skill: Session Start

## Phase 0 — Read Project State

**Read all 4 files in parallel (partial reads — do not load the complete body):**

- `project-spec.md` — **only YAML frontmatter** (version, status, created, last_demolition_cycle); if it doesn't exist: version = "not initialized"
- `cdp-memory.md` — **only the last row of the Session Log** (next step)
- `demolition-history.md` — **only Summary Metrics** (total cycles) **and the last row of the Cycle Log**
- `risk-register.md` — **only the count of `open` rows and how many are `ACT NOW`**; skip if the file doesn't exist

If `project-spec.md` doesn't exist yet: the session type is `onboarding`.

## Phase 1 — Determine Session Type

Ask:

```
What kind of work are we starting today?

1. Onboarding — build project-spec.md v1.0 from scratch
2. Demolition — attack the spec from a critical persona's perspective
3. Integration — bring the resolutions from the last cycle into the spec
4. Review — re-read and evaluate the project state

[or describe freely what you want to do]
```

If the user describes freely: infer the type among `onboarding`, `demolish`, `integrate`, `review`.

## Phase 2 — Create Session File

Determine the file name: `sessions/[DATE]-[type].md`
- E.g.: `sessions/2026-04-21-demolish.md`
- If a file with the same name already exists: add suffix `-2`, `-3`, etc.

Create the file from the template `sessions/session-template.md` and fill in:
- `title`: "[Type] — [DATE]"
- `date_created`: today's date
- `last_updated`: today's date
- `status`: `open`
- `Type`: chosen session type
- `Target`: current version of `project-spec.md`
- `Current step`: first step of the session type
- `Checklist`: populate with the standard steps for the type:

  **Onboarding**: Read documents → Interview → Synthesis → Confirmation → Save
  **Demolish**: Read files → Select persona → Attack → Log
  **Integrate**: Read prerequisites → Integrate issues → Versioning → Update memory
  **Review**: Read spec → Evaluate → Notes

## Phase 3 — Launch Output

Append a row to the Session Log in `cdp-memory.md`:

```
| [DATE] | Started [type] session — spec v[X.X] | [next step] |
```

Then present a contextual summary:

```
Session started: [type] — [DATE]
Session file: sessions/[filename]

PROJECT-SPEC: v[X.X] — [date of last update or "not initialized"]
DEMOLITION CYCLES: [N total]
SUGGESTED NEXT STEP: [from cdp-memory.md or inferred]

Use /cdp:[command] to begin.
```
