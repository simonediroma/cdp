---
name: ticket
description: "Open a single Jira ticket from whatever you already have — a bug spotted in a payload, something settled in a thread, a piece of maintenance someone has to pick up — with no spec and no boilerplate. Reads the project's real scheme, checks for a duplicate, drafts to the conventions in reference/jira-fields.md (Summary, per-type description, labels + the mandatory AI-ASSISTED), and confirms once before it writes. Use when the ask is 'let's open a ticket for this', 'apri un ticket', 'segna questo bug'. For a whole feature use /cdp:onboarding → /cdp:demolish → /cdp:integrate → /cdp:spec-to-code instead."
disable-model-invocation: false
allowed-tools: Read, Edit, Grep, Glob, Bash, AskUserQuestion, mcp__Atlassian__getAccessibleAtlassianResources, mcp__Atlassian__getVisibleJiraProjects, mcp__Atlassian__getJiraProjectIssueTypesMetadata, mcp__Atlassian__getJiraIssueTypeMetaWithFields, mcp__Atlassian__searchJiraIssuesUsingJql, mcp__Atlassian__lookupJiraAccountId, mcp__Atlassian__createJiraIssue, mcp__Atlassian__getJiraIssue, mcp__Atlassian__createIssueLink
---

# Skill: Ticket

One ticket, from whatever you already have — a bad value noticed in a payload, a decision taken in a thread, a
piece of maintenance someone has to pick up. No spec, no demolition cycle, no boilerplate.

## Why this one is model-invocable

Every other skill in this plugin is heavyweight and should fire only when you type it. This one is the deliberate
exception: **"let's open a ticket for this" is enough to start it**, because the failure it exists to prevent is a
ticket created ad hoc, outside any skill, with the conventions never read.

That failure is not hypothetical here. `/cdp:spike-integrate` shipped writing tickets with a Summary format and a
label of its own invention, missing `AI-ASSISTED` entirely, until it was fixed. A ticket opened by hand in the
middle of a conversation has nothing at all standing between it and the same outcome.

> **Note on the frontmatter.** `disable-model-invocation: false` is set explicitly rather than left to the
> default, so the intent survives the hygiene pass that set `true` on every other skill. This file is the one
> that must not be changed by it.
>
> `allowed-tools` names the Atlassian tools on the `mcp__Atlassian__` prefix, which is the one **observed in a
> working session** (see `reference/mcp-servers.md`). An earlier draft of this file used
> `mcp__claude_ai_Atlassian__*`, carried over from another plugin's conventions without checking it against this
> one; that guess is retired. In the body below, tools are named **bare** — Claude resolves them against whatever
> is connected, so the prose survives a connector being re-registered.

## Scope — and where it stops

**One ticket = one outcome.** If the input carries more than one outcome, or describes a feature that needs
unpacking, **stop and redirect**: `/cdp:onboarding` to draft the spec, `/cdp:demolish` and `/cdp:integrate` to
harden it, `/cdp:spec-to-code` to decompose it. A ticket on the fly is a ticket, not a feature.

No risk analysis and no structured critique — that is `/cdp:demolish`. No macro decomposition — that is
`/cdp:spec-to-code`.

## Output

The ticket lives **in Jira**. This skill writes no deliverable file. Two local records, both small:

- **`cdp-memory.md` session log** — one row, always, because *if it's not written, it didn't happen* (operating
  principle 5). A ticket opened mid-session and recorded nowhere is invisible to `/cdp:resume` tomorrow.
- **`docs/change-requests.md`** — only if the input names an existing `CR-<N>`: fill its `**Jira:**` line.

Field conventions are **not** in this file: read `${CLAUDE_PLUGIN_ROOT}/reference/jira-fields.md` before
drafting. It is the single source for the Summary format, the per-type description skeletons and the label
taxonomy. `/cdp:spike-integrate` reads the same file — **never restate its rules here**, or the two drift apart.

## Cardinal rules

- **Never create without an explicit go-ahead.** Jira is an external system and a ticket is hard to undo: a wrong
  one has to be found, closed and explained, and everyone watching the board saw it. One gate, immediately before
  the write. A reply that only settles fields — assignee, type, labels — is **not** a go-ahead to publish.
- **Never deduce the conventions from the project's existing tickets.** Labels especially: a wrong-case variant
  already sitting on the project is not licence to match it — it is a parallel label somebody created by accident,
  and matching it doubles the mistake. `jira-fields.md` wins over anything observed in the wild.
- **Never assume the project's issue types.** Read the real scheme; a project may have no `Bug` type at all. When
  the scheme forces a deviation, **say so in the ticket itself** (e.g. a first line reading "data bug, opened as
  Task because this project has no Bug type").
- **Never infer what the input doesn't say.** Gaps stay visible as `[TBD]`; never fill one with a plausible
  default to keep the flow moving. This is the same rule the rest of the plugin runs on — Claude formalizes, it
  does not invent.
- **Verify after writing.** The `createJiraIssue` response does not echo labels or priority — re-read the issue
  with `getJiraIssue` and confirm they landed.
- **Synthetic data only** — never real customer PII, credentials, or production identifiers in a summary,
  description, or comment. Strip them from pasted material before quoting it.
- Ask for **today's date**; never fabricate one.

## Phase 0 — Read the input, pick the path

- **Complete, and the project is known** → straight to the draft (Phase 3). Don't manufacture an interview for
  something that already says what it needs. Whoever runs this usually arrives with the payload in hand.
- **Ambiguous, or no project** → at most **3 targeted questions** via `AskUserQuestion`, each carrying your
  proposed answer so the user confirms rather than composes. They exist to close ambiguity, not to translate
  technical content.
- **More than one outcome** → stop and redirect (see Scope).

**Check the risk register.** If `risk-register.md` exists, scan its open rows: an input that matches one is not a
new discovery, it is a known risk arriving in the real world. Say so, and cite the row in the ticket's context —
`Known risk R<n> (<artifact>) in risk-register.md, triaged <ACT NOW|MONITOR|ACCEPT>`. If the ticket closes that risk, say that too, and
point at `/cdp:integrate` to retire it. This skill never edits the register itself.

## Phase 1 — Target and scheme

- Ask for the **project** and the **site / Cloud ID** — they live in no context file. Use
  `getVisibleJiraProjects` (or `getAccessibleAtlassianResources` for the site) if unsure. Never assume.
- Read the scheme: `getJiraProjectIssueTypesMetadata`, then `getJiraIssueTypeMetaWithFields` for the type you
  intend to use, so required fields and allowed priorities are known **before** drafting. Discovering a required
  field after the user has approved the draft means going back and asking twice.
- If an assignee is named, resolve them with `lookupJiraAccountId` and match on the **email**, not the display
  name — homonyms are common, and the wrong account silently assigns the work to a stranger.

## Phase 2 — Check for a duplicate

Search the project before writing (`searchJiraIssuesUsingJql`). If a plausible candidate exists, show it and ask
whether to comment on it or link to it instead of opening a second ticket.

Keep the query cheap: **`maxResults` is what bounds the response, not `fields`** — the MCP search returns full
descriptions regardless of the `fields` you ask for, and a broad query easily overflows the context. Search on a
distinctive term (a field name, an identifier), a handful of results at a time.

## Phase 3 — Draft, then the gate

Draft per `jira-fields.md`, and on top of that skeleton always include:

- an explicit **Out of scope** section — what must *not* be changed for symmetry, and why;
- **acceptance criteria that are testable**, not restatements of the title;
- the **dependencies** or prerequisites, named;
- for a technical ticket, the **offending query, payload, or log quoted verbatim** (synthetic values): that is the
  useful content. Keep implementation code to the minimal snippet that states the fix — no speculative solution
  beyond it.

Then present the **full payload** — type · summary · description · labels · assignee · priority — and **stop**.
Flag any deviation the scheme forced, and name the label category you chose rather than letting it pass
unmentioned. That is the gate.

## Phase 4 — Create, verify, record

1. `createJiraIssue`, with labels, priority and any custom fields via `additional_fields`.
2. `getJiraIssue` to confirm `labels`, `priority`, `assignee`, `issuetype`, `status` actually landed.
3. `createIssueLink` for a related ticket, if Phase 2 found one.
4. **Write the session log row** in `cdp-memory.md`:
   ```
   | [date] | Opened [KEY] — [summary] | [next step] |
   ```
5. If the input named an existing `CR-<N>`, fill that entry's `**Jira:**` line in `docs/change-requests.md`.

## Phase 5 — Report

Say the key and the browse URL, what deviated from the request and why, anything left `[TBD]`, and — if Phase 0
matched one — which risk register row this relates to.

If the verification in step 2 found a field that didn't land, say so plainly and fix it before reporting done. A
create that looks clean and dropped its labels is the failure this whole skill exists to prevent; discovering it
and not mentioning it would be worse than never checking.
