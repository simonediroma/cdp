# 02 — Meet Custom Scorecard, the App Category

🎬 Video: [`video-prompts.md#02-meet-custom-scorecard`](video-prompts.md#02-meet-custom-scorecard)

---

Before you open `/cdp:onboarding`, it helps to see the shape you're about to specialize into your own app. Strip away any specific domain and a Custom Scorecard is three ideas stacked on top of each other:

1. **An entity you rate** — a wine, a candidate, a restaurant, an apartment you're considering. Whatever gets a new entry each time you use the app.
2. **A set of criteria you define, each with a weight** — not fixed by the app, chosen by the person using it. "Body" might matter more than "price/quality" to one person and the reverse to another.
3. **A computed, weighted ranking** — every entity gets a score per criterion, the app multiplies by weight and sums, and you get an ordered list.

That's the entire mechanic. No recommendation engine, no crowd-sourced average, no AI judging anything — just numbers you entered and arithmetic the app runs on them. The peculiarity worth noticing: the ranking often surprises the person who built it. You can believe you prefer one entity and find, once your own weights are applied consistently, that another one actually wins. That small moment of "huh, I didn't expect that" is the whole reason this app category is worth building at all — it's not a form with extra steps, it does something a mental tally can't.

## Why this shape forks so easily

Notice what's *not* specified yet: what the entity actually is, what the criteria actually are, who else (if anyone) needs to see the ranking, and what happens if two people disagree about a score. Every one of those is domain-specific, and every one of those is exactly what onboarding's seven questions are designed to surface. That's not a coincidence this course is exploiting — it's the reason Custom Scorecard was chosen over, say, a fixed-schema expense tracker. An expense has the same handful of fields no matter who's tracking it. A scorecard's fields are undefined until a human says what they're scoring.

## Why it stays self-contained

Three constraints worth stating explicitly, since they shaped the choice of app category in the first place:

- **No external data sources.** Nothing is scraped, polled, or fetched from a third-party service. Every entity and every score is typed in by the person using the app.
- **No paid APIs, no cloud project to configure.** Whatever `/cdp:spec-to-code`'s Deploy Discovery proposes in Lesson 07, it won't require setting up a Google Cloud project, a Twilio account, or any billed integration to get a working version live.
- **No AI at runtime.** The plugin uses an LLM to help *build* the app — that's the whole method this course teaches. The app itself, once built, is CRUD and arithmetic. Nobody using the finished Custom Scorecard is calling a model.

## Picking your own domain

You start from a blank project — no existing `project-spec.md`, no prior documents for onboarding to scan. What you bring instead is a domain, in your own head, that you haven't written down yet. Something you'd genuinely rate more than once is enough: wines you taste, candidates your team interviews, restaurants you try, apartments you're comparing, running shoes, books — anything with a real entity, real criteria you actually weigh against each other, and a ranking you'd actually look at.

Pick one now, even a rough version of it. You don't need it fully thought through — that's what onboarding is for. You just need something specific enough that "who's rating this, and why" has a real answer in your head, not a placeholder.

## Check your understanding

- Which of the three self-containment constraints (no external sources, no paid APIs, no runtime AI) would break first if your domain were, say, a restaurant-recommendation app that pulled in other people's reviews?
- Before you've answered a single onboarding question, what's one thing about your own idea that you'd expect to shape the build in a way a generic scorecard template couldn't predict?

*Next: [03 — Run Your Own Onboarding](03-run-your-own-onboarding.md).*
