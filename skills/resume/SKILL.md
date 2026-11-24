---
name: resume
description: Quick session resume. Reads only frontmatter and the last log rows to answer "Where was I and what do I do now?" in 4 fixed lines.
disable-model-invocation: true
allowed-tools: Read, Glob
---

# Skill: Resume

## Fast Read (frontmatter and last rows only)

Read **only** these parts of the files — do not read the complete body:

1. `project-spec.md` — only YAML frontmatter (version, status, last_demolition_cycle, demolition_cycles_count)
2. `cdp-memory.md` — only the last row of the Session Log
3. `demolition-history.md` — only the last row of the Cycle Log and the Open Deferred Issues list (only if not empty)
4. `risk-register.md` — only the count of `open` rows and how many are `ACT NOW` (skip if the file doesn't exist)
5. `sessions/` — identify files with `status: open` (only session file frontmatter)

## Output

Respond **always and only** in this format, adding nothing:

```
LAST TIME: [one sentence about the last concrete action completed]
PROJECT-SPEC: v[X.X] [status] — [date of last_demolition_cycle or "no cycle yet"]
PENDING: [max 2 pending items, or "Nothing pending"]
NEXT: /cdp:[command] — [minimum context in 5 words]
```

**Rules:**
- `LAST TIME`: use the last row of the Session Log in `cdp-memory.md`. If empty: "No session recorded."
- `PROJECT-SPEC`: include the `status` value verbatim. If it's missing, write `no status` — the spec predates the field.
- `PENDING`: **open ACT NOW risks come first** (max 2, cited as `R[n] (artifact)`), then open deferred issues, then open promises from `cdp-memory.md`. If nothing: "Nothing pending." An ACT NOW risk outranks a deferred issue because it is the one thing blocking a freeze.
- `NEXT`: infer from context — if the last step was demolish, the next is integrate; if it was integrate, the next is demolish; if no spec exists, the next is onboarding.
- Do not add text outside the format. Do not explain. Do not introduce.
