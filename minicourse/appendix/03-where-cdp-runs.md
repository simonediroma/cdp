# Where cdp Runs — Cowork, Claude Code, Cloud

`cdp` is a Claude plugin, and the same plugin runs on three surfaces. Every course and guide works on all three; what changes is **how you install it**, **where your files live**, and **how you hand Claude a document**. This page is the one place that says how — lessons link here instead of repeating it.

| | **Cowork** (Claude Desktop) | **Claude Code** (CLI, IDE, desktop) | **Cloud** (Claude Code on the web) |
|---|---|---|---|
| Best for | spec work without a terminal: onboarding, demolition, integration | spec work next to a codebase; `spec-to-code` and the build loop | working from a browser or phone, on a GitHub repo |
| Install | **Customize → Plugins → Add → Add marketplace** → `simonediroma/cdp`, then **Discover → cdp → Add** | `/plugin marketplace add simonediroma/cdp` then `/plugin install cdp@simonediroma-cdp` | add it to your claude.ai account at [claude.ai/customize/plugins](https://claude.ai/customize/plugins) (add marketplace `simonediroma/cdp`), then start a **new** session |
| Your files | the folder you give Cowork to work in | the directory you start `claude` in | a fresh clone of the session's GitHub repo |
| Handing Claude a document | put it in that folder, or attach it to the conversation | put it in the working directory | **commit it to the repo** before starting the session |
| `project-spec.md` & memory files survive… | in the folder | in the directory | **only if committed and pushed** — the container is discarded when the session ends |

Verify on any surface with `/cdp:echo` — it answers `hello world`.

## What to know per surface

**Cowork.** Commands are typed the same way: `/cdp:onboarding`. If your organization restricts plugin sources, an admin may need to allow the repository.

**Claude Code.** To try a local checkout without installing: `claude --plugin-dir ./cdp`. `/plugin` shows what's installed and any load errors. Installing at *project* scope writes the plugin into the repo's `.claude/settings.json` so collaborators get it too.

**Cloud.** Plugins installed on your computer are **not** carried into cloud sessions — install through your claude.ai account, as above. Everything the session should read (a manuscript, a PRD, `architecture-context.md`) must be in the repo; everything it writes (`project-spec.md`, `cdp-memory.md`, `risk-register.md`, `sessions/`) must be committed and pushed before you close it. Ask Claude to do that at the end of each session — it's the cloud equivalent of saving.

## Moving between surfaces

The plugin keeps all its state in plain files — `project-spec.md`, `cdp-memory.md`, `demolition-history.md`, `risk-register.md`, `sessions/`. Put them in a git repository and you can run onboarding in Cowork, a demolition cycle from your phone in a cloud session, and `spec-to-code` in Claude Code, on the same project. `/cdp:resume` picks up wherever the last session left off, regardless of where it ran.

Official documentation: [Discover and install plugins](https://code.claude.com/docs/en/discover-plugins) · [Claude Code on the web](https://code.claude.com/docs/en/claude-code-on-the-web) · [Use plugins in Cowork](https://support.claude.com/en/articles/13837440-use-plugins-in-cowork).
