# 03 — Installing the Plugin

🎬 Video: [`video-prompts.md#03-installing-the-plugin`](video-prompts.md#03-installing-the-plugin)

---

Lesson 02 named CDP as the path this course teaches hands-on from here forward. This lesson is the on-ramp: getting the `claude-cdp` plugin installed and verified, so Lesson 05 has something to run. If you're following one of the other two paths from Lesson 02 instead, skip ahead to Chapter 2 — `/cdp:spec-to-code` only needs a frozen PRD, not one produced by this specific plugin.

Two installation paths, both documented in the [cdp claude plugin](https://github.com/simonediroma/cdp)'s main `README.md`. Pick whichever matches how you work.

## Method 1 — Marketplace (recommended)

1. In Claude Desktop, open **Menu → Plugins → Browse Marketplace** (or click the ⊕ icon in the sidebar)
2. If `cdp` doesn't appear in the default list, add the repository manually: `https://github.com/simonediroma/cdp`
3. Click **Install** next to *cdp*
4. Verify: type `/cdp:echo` in chat — it should respond `hello world`

## Method 2 — Manual installation

1. Clone the repo: `git clone https://github.com/simonediroma/cdp.git`
2. Open Claude Desktop's config file:
   - macOS: `~/Library/Application Support/Claude/claude_desktop_config.json`
   - Windows: `%APPDATA%\Claude\claude_desktop_config.json`
3. Add the plugin entry:
   ```json
   {
     "plugins": [
       {
         "name": "cdp",
         "path": "/absolute/path/to/cdp"
       }
     ]
   }
   ```
4. Restart Claude Desktop
5. Verify: `/cdp:echo` → `hello world`

## Local test (Claude Code CLI)

If you're working from the command line instead of the desktop app:

```bash
claude --plugin-dir ./cdp
/cdp:echo
```

## Why the echo check matters

`/cdp:echo` exists for exactly one reason: to give you a fast, unambiguous signal that the plugin is actually wired up before you invest time in an onboarding interview. If it doesn't respond `hello world`, nothing downstream in this course will work — stop and fix the install before continuing.

## What you get once it's installed

Ten commands become available (`/cdp:onboarding`, `/cdp:persona`, `/cdp:demolish`, `/cdp:integrate`, `/cdp:export`, `/cdp:resume`, `/cdp:session-start`, `/cdp:spec-to-code`, `/cdp:spike-integrate`, `/cdp:arch-init`), plus `/cdp:echo`. Lesson 04 walks through what each one does and when you'd reach for it.

## Check your understanding

- What does a successful `/cdp:echo` actually verify, and why check it before running `/cdp:onboarding`?
- If you're on Claude Code CLI rather than Claude Desktop, what changes about installation?

*Next: [04 — Command Overview](04-command-overview.md).*
