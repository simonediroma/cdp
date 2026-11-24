# MCP server names

The single place that records **what the connectors this plugin calls are actually named**. Skills point here; none of them invents a prefix of its own. The rule this file exists to enforce:

> A tool name is either **observed in a working session** or it is a guess. Guesses do not go in `allowed-tools`, because `allowed-tools` is a hard allowlist — a wrong name silently strips a skill of the tool it exists to call, and the skill then reports the connector as unavailable when it is sitting right there.

## Confirmed

| Server | Prefix | Evidence |
|---|---|---|
| Atlassian (Confluence **and** Jira) | `mcp__Atlassian__` | A working call observed in a real session — `mcp__Atlassian__getConfluencePage` with a real `cloudId` and `pageId`. A transcribed successful call, not a plausible-looking name. |
| Google Drive | `mcp__Google_Drive__` | Observed the same way: `mcp__Google_Drive__search_files` / `download_file_content`. |

Confluence and Jira are **one connector**, not two: `getAccessibleAtlassianResources` is evidenced on the Atlassian server, and the Jira tools live behind the same prefix.

Tools used by this plugin, all on `mcp__Atlassian__`:

```
getAccessibleAtlassianResources   getConfluencePage
getVisibleJiraProjects            getJiraProjectIssueTypesMetadata
getJiraIssueTypeMetaWithFields    searchJiraIssuesUsingJql
lookupJiraAccountId               createJiraIssue
getJiraIssue                      createIssueLink
getTransitionsForJiraIssue        getIssueLinkTypes
```

## Not confirmed

| What | Used by | Status |
|---|---|---|
| `project_read` / `project_search` | `spec-to-design` (Step 0a), `design-init` | Claude Desktop **Project** tools, not an MCP server — no `mcp__` prefix, and no session has confirmed the literal names. `spec-to-design` therefore keeps `allowed-tools` omitted. |
| Design-system sources | `design-init` | Declared per project (`project.config.json` → `design_system`) — docs site, Confluence, Notion, Storybook, a repo. The tool surface depends on the project, so `design-init` keeps `allowed-tools` omitted too. |

## Retired guesses

Kept so nobody reintroduces them:

| Guess | Was in | Why it was wrong |
|---|---|---|
| `mcp__confluence__*` | `arch-init` | A plausible name in a prose availability check; never backed by a successful call. |
| `mcp__claude_ai_Atlassian__*` | `ticket` | Carried over from another plugin's conventions without checking it against this one. |

## How a skill should call these

**In prose, use the bare API name** — `getVisibleJiraProjects`, `getConfluencePage`. Claude resolves it against whatever is connected, so the skill keeps working if a connector is ever re-registered under a different name. The prefix matters in exactly one place: `allowed-tools`.

**Detect availability by trying the call**, not by testing for a name. A skill whose MCP step is optional (`spike-integrate`'s Jira mirror, `arch-init`'s Confluence lookup) tries it, and on failure says so and continues on the local path — never blocks, and never reports "not connected" without having attempted it.

**When you observe a name this file doesn't have**, add it here with what you saw, and complete the `allowed-tools` lists that were waiting on it. That is the whole maintenance loop.
