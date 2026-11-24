# Useful Resources

External, official documentation for the tools and platforms the five courses mention but don't teach from scratch. Organized by topic, roughly in the order you'll need them across Courses 1-5.

---

## Claude Code — the surfaces

The courses mention "Claude Desktop," "Claude Code CLI," and occasionally the web — these are different surfaces for related but distinct products, and the courses assume you can tell them apart.

- **Claude Code** is the agentic coding tool itself — it reads your codebase, edits files, and runs commands. It's available as:
  - a **CLI** in your terminal (`claude` command) — what Course 1 Lesson 03's local-test path and Course 2 Lesson 05's "open a Claude Code session in the repo root" both assume
  - a **desktop app** (Mac/Windows) — where the `claude-cdp` plugin itself is installed and where Course 1's `/cdp:onboarding` → `/cdp:demolish` → `/cdp:integrate` cycle typically runs
  - a **web app** at [claude.ai/code](https://claude.ai/code) — browser-based sessions, including remote execution environments
  - **IDE extensions** for VS Code and JetBrains — inline coding assistance inside an editor you already use
- Official docs: [code.claude.com/docs](https://code.claude.com/docs/en/overview)

**Claude Desktop** (a separate product from Claude Code) is the general-purpose chat app where plugins like `cdp` install via the Marketplace — Course 1 Lesson 03's Method 1 and Method 2 both target this app specifically.

## MCP — Model Context Protocol

An open standard, created by Anthropic, for connecting an AI application to external tools and data sources — Jira, Confluence, a filesystem, a database — through one common protocol instead of a custom integration per tool. Every "if a Jira MCP connection is available" or "Confluence MCP" reference in Courses 2-3 depends on this.

- What it is, in plain terms: [modelcontextprotocol.io — Introduction](https://modelcontextprotocol.io/docs/getting-started/intro)
- Original announcement: [Anthropic — Introducing the Model Context Protocol](https://www.anthropic.com/news/model-context-protocol)

## Cursor

The IDE track `/cdp:spec-to-code` can generate for (Course 2 Lesson 03, Course 3 Lesson 09) — an alternative to Claude Code with its own agent, rules system, and Composer interface.

- Official docs: [cursor.com/docs](https://cursor.com/docs)

## Git & pull requests

Courses 2-4 assume you already know how to branch, commit, and open a PR ("one branch, one PR, per task — never straight to `main`"). If any of that is new:

- Git itself, comprehensively: [Pro Git book](https://git-scm.com/book/en/v2) (free)
- Git reference docs: [git-scm.com/doc](https://git-scm.com/doc)
- Pull requests specifically: [GitHub Docs — About pull requests](https://docs.github.com/articles/about-pull-requests)

## Testing & TDD

Course 2 Lesson 03 and Course 4 Lesson 06 both assume familiarity with RED-GREEN-REFACTOR (write a failing test, make it pass, then clean up). If TDD itself is new:

- Kent Beck's original formulation is the canonical starting point — search for "Kent Beck Test-Driven Development" for the book and talks; there isn't one single canonical URL, so this is worth a search rather than a fixed link here.

## "Osmani" — the confirmed source

Course 2 Lesson 04 covers this label; `document/osmani-agent-skills-gap-analysis.md` (in the [cdp claude plugin](https://github.com/simonediroma/cdp)'s `document/` folder, not this appendix) has the full comparison. The source is Addy Osmani's `agent-skills` Claude Code plugin:

- Repo: [github.com/addyosmani/agent-skills](https://github.com/addyosmani/agent-skills)

Never cited directly by this plugin's own reference files, but the overlap in specific wording (vertical slicing, macro sizing, the CLAIM/DOUBT/RECONCILE triad, named principles like Chesterton's Fence and Hyrum's Law) is close enough to treat as confirmed, not merely likely.

## Security basics

The security checklist embedded in every HIGH-risk macro prompt (Course 2 Lesson 03, Course 4 Lesson 02) checks against the OWASP Top 10 and assumes basic familiarity with JWT, OAuth, and RBAC.

- OWASP Top 10: [owasp.org/www-project-top-ten](https://owasp.org/www-project-top-ten/)
- If JWT/OAuth/RBAC are unfamiliar terms rather than just unfamiliar acronyms, start with the glossary entries in `01-glossary.md` — each names what to search for next.

## Deploy platforms

Course 2 Lesson 02's Deploy Discovery interview names several platforms as examples. Official docs for each, in case your Deploy Discovery conversation lands on one you haven't used before:

- Railway: [docs.railway.com](https://docs.railway.com/)
- Fly.io: [fly.io/docs](https://fly.io/docs/)
- Render: [render.com/docs](https://render.com/docs/)
- Vercel: [vercel.com/docs](https://vercel.com/docs)

These aren't endorsements of one over another — Course 2 Lesson 02 is explicit that the choice is yours, proposed and refined, not prescribed by the protocol.

## Docker

Course 2's `M0` scaffold macro always produces a `Dockerfile` for GREENFIELD projects (Lesson 01, 03).

- Official docs: [docs.docker.com/get-started](https://docs.docker.com/get-started/)

## Jira & Confluence

Both are Atlassian products; Courses 2-3 only interact with them through MCP (see above), but if you're setting up either for the first time:

- Atlassian documentation portal: [confluence.atlassian.com](https://confluence.atlassian.com/)

---

None of these links are required reading before starting the courses — they're here for the moment a lesson uses a term or tool you want to go deeper on than a glossary entry allows.
