# 07 — `/cdp:spike-integrate`

Once a `docs/spike-M<N>.md` stub is filled in and marked `RESOLVED`, `/cdp:spike-integrate` is what turns that resolved investigation back into a real implementation prompt — unblocking the macro that was waiting on it.

## What it looks for

It scans `docs/spike-M*.md`. Anything still `OPEN` (or with `[TO BE FILLED]` sections still empty) gets skipped and listed at the end as a reminder. Anything genuinely `RESOLVED` gets processed: which macro it unblocks, the decision made, what was discarded, the technical constraints discovered, the files and patterns found, any new acceptance criteria, and the impact on other macros.

## What gets rewritten

For each resolved spike, the corresponding macro prompt (`prompts/M<N>_<name>.md` or `.cursor/rules/MN-<name>.mdc`) is rewritten using the correct risk template — and the risk level itself may change from what was originally estimated, based on what the spike actually revealed. The rewrite incorporates:

- The decision and discarded alternative, into the Context section
- Discovered files/patterns, into "Existing modules to read first"
- Technical constraints, as explicit notes for Claude Code or Cursor
- Any new acceptance criteria that emerged
- A risk level assignment based on what was actually found, not what was guessed at Step 3 of decomposition

## What gets updated alongside it

`CLAUDE_MEMORY.md` (or `02-memory.mdc`): the `⏳ M<N>` line becomes `[ ] M<N>` — spike resolved, ready to implement. If the spike changed the dependency between macros, `HANDOFF.md`/`SETUP.md`'s execution order gets updated too.

If Jira is connected: the spike ticket closes with a comment naming the decision, the unblocked story gets created, and — only if the spike changed scope versus the original PRD (new acceptance criteria, additional modules touched, a significant risk-level jump, or an entirely new macro that didn't exist before) — a **Change Request** gets opened, linking the original requirement, what changed, why, and what it impacts.

## The exit check

After integrating everything resolved, `/cdp:spike-integrate` reports plainly: how many spikes were integrated, which macros got unblocked, how many Change Requests were created, and — critically — how many spikes are still open, listed with their questions so nothing goes quiet. If a spike created an entirely new macro that didn't exist in the original plan, that macro gets added, risk-assigned, and tracked the same way any other macro would be.

## Check your understanding

- What has to be true of a `docs/spike-MN.md` file before `/cdp:spike-integrate` will act on it?
- Under what specific conditions does resolving a spike produce a Change Request, rather than just an unblocked macro?

*Next: [08 — Long-Running Sessions](08-long-running-sessions.md).*
