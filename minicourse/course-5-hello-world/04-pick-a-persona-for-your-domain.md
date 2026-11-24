# 04 — Pick a Persona for Your Domain

🎬 Video: [`video-prompts.md#04-pick-a-persona-for-your-domain`](video-prompts.md#04-pick-a-persona-for-your-domain)

---

Persona selection happens inside `/cdp:demolish` itself, not as a separate command — Phase 0 of that skill presents the full list of predefined personas (plus any custom ones you've built with `/cdp:persona`) and asks which perspective to demolish your spec from. Before you run it, it's worth deciding deliberately instead of picking the first name on the list.

## The six predefined personas

- **The Target Customer** — *"Why should I choose you?"* Attacks audience-fit and message hierarchy first.
- **The Competitor** — *"What's here that I can't copy?"* Attacks differentiation first.
- **The Journalist** — *"What happens if I put this to the test?"* Attacks whether claims hold up under scrutiny.
- **The Creative Director** — *"What's the most interesting thing in this brief?"* Attacks genericness.
- **The CFO** — *"How do we measure this and what justifies the spend?"* Attacks unmeasurable objectives.
- **Legal & Compliance** — *"What happens if someone asks us to prove it?"* Attacks undefended claims and exposure.

Course 1 Lesson 06 introduced all six in full, with their complete priority orders — worth a refresher if you don't remember how one of them attacks beyond its key question.

## How to pick, deliberately

Go back to your own v1.0 spec from Lesson 03. Ask yourself: **which single claim, if it turned out to be wrong or undefended, would matter most?** Match that to the persona whose key question points straight at it, not to whichever sounds most interesting:

- If your biggest worry is *"would anyone actually need this over doing it in their head or in a spreadsheet"* → **The Target Customer** or **The Competitor**.
- If your biggest worry is a claim you couldn't actually back up if someone pushed on it → **The Journalist**.
- If your biggest worry is that the idea is generic — the kind of thing that's been built a hundred times with nothing to say for itself → **The Creative Director**.
- If your biggest worry is that you can't say what "working" even means, or what it's worth building at all → **The CFO**.
- If your biggest worry is a hedge you left in Question 7 — a constraint you flagged but didn't resolve, anything with a fairness, privacy, or accountability shape to it → **Legal & Compliance**.

If none of the six actually fits your domain's real risk, `/cdp:persona` lets you create a custom one — Course 1 Lesson 06 covers that process. Don't force a predefined persona onto a risk it wasn't built to find.

## Now do it

Reread your own spec with that question in mind — which claim would hurt most if it were wrong. Decide which persona matches. You'll actually select it inside `/cdp:demolish` in Lesson 05, so hold your answer for a moment — but have it settled before you open that command, not while you're staring at the selection menu.

## Check your understanding

- Which persona did you land on, and which specific line in your own v1.0 spec made that the obvious choice over the other five?
- Suppose you're wrong about which claim is riskiest. What would the demolition cycle in Lesson 05 look like if you'd picked a persona that missed your actual weak point entirely?

*Next: [05 — Run Your Demolition Cycle](05-run-your-demolition-cycle.md).*
