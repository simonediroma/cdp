# 03 — Installing the Plugin

Lesson 02 named CDP as the path this course teaches hands-on from here forward. This lesson is the on-ramp: getting the `claude-cdp` plugin installed and verified, so Lesson 05 has something to run. If you're following one of the other two paths from Lesson 02 instead, skip ahead to Chapter 2 — `/cdp:spec-to-code` only needs a frozen PRD, not one produced by this specific plugin.

The plugin runs on three surfaces — **Cowork** (Claude Desktop), **Claude Code** (CLI, IDE, desktop) and **Cloud** (Claude Code on the web). Pick the one that matches how you work; every lesson in this course works on all three. [Where cdp Runs](../appendix/03-where-cdp-runs.md) compares them side by side.

## Cowork (Claude Desktop)

1. In the left sidebar open **Customize → Plugins**
2. Click **Add → Add marketplace → Add from a repository**, and enter `simonediroma/cdp`
3. Open the **Discover** tab, select *cdp*, click **Add**
4. Verify: type `/cdp:echo` — it should respond `hello world`

## Claude Code (CLI, IDE, desktop)

```
/plugin marketplace add simonediroma/cdp
/plugin install cdp@simonediroma-cdp
/cdp:echo
```

To try a local checkout without installing it: `git clone https://github.com/simonediroma/cdp.git`, then `claude --plugin-dir ./cdp`.

## Cloud (Claude Code on the web)

1. Go to [claude.ai/customize/plugins](https://claude.ai/customize/plugins) and add the marketplace `simonediroma/cdp`, then add *cdp*
2. Start a **new** cloud session on the GitHub repository that will hold your spec
3. Verify: `/cdp:echo`

Plugins installed on your computer don't follow you into cloud sessions — this step is separate. And a cloud session works on a fresh clone of the repo: any document you want onboarding to read must be committed first, and the spec files it writes must be pushed before you close the session.

## Why the echo check matters

`/cdp:echo` exists for exactly one reason: to give you a fast, unambiguous signal that the plugin is actually wired up before you invest time in an onboarding interview. If it doesn't respond `hello world`, nothing downstream in this course will work — stop and fix the install before continuing.

## What you get once it's installed

Every `/cdp:` command becomes available — `/cdp:onboarding`, `/cdp:persona`, `/cdp:derisk`, `/cdp:demolish`, `/cdp:integrate`, `/cdp:export` and the rest, plus `/cdp:echo`. Lesson 04 walks through what each one does and when you'd reach for it.

## Check your understanding

- What does a successful `/cdp:echo` actually verify, and why check it before running `/cdp:onboarding`?
- On a cloud session, what has to happen before onboarding can read your documents — and after it, before you close the session?

*Next: [04 — Command Overview](04-command-overview.md).*
