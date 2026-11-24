# 03 — Run Your Own Onboarding

You've got a domain in mind from Lesson 02. Now you run `/cdp:onboarding` on it. If you have no existing documents in your project folder, Phase 0's document scan finds nothing and you go straight into all seven questions, one at a time — the plugin confirms its understanding after each answer before moving to the next, exactly as Course 1 Lesson 05 described.

## What to expect from each question

Each question comes with a "how to read this" insight right after you're asked — a marketing-campaign example and a product-feature example. Read the product-feature side; that's your translation already done for you.

**Question 1 — Objective.** *"What must this concretely produce, enable, or regulate? What's the objective?"* Answer as a builder, not a marketer: what do you actually want this app to do for you. "Log every wine I taste, score it on what matters to me, and get a ranked list" is a complete answer. So is "score every candidate against the same rubric so the decision isn't just whoever argues loudest."

**Question 2 — Primary reader/user.** *"Who is the primary reader or user?"* This is the one to answer with real precision, because it quietly decides more than it sounds like it should. "Just me" and "me plus two colleagues who need to see the same scorecard" are both valid — but they lead to very different builds later, starting with Deploy Discovery in Lesson 07.

**Question 3 — Secondary reader/user (conditional).** *"Is there a relevant secondary reader or user? If not, just say 'no'."* If there genuinely isn't one, say so — don't invent a maybe-someday user to sound thorough. If there's a real "not yet, but possibly later," say that instead; it's a legitimate answer and worth being honest about.

**Question 4 — Central claim.** *"If your reader remembered only one thing, what should it be?"* Watch for anything you say here that quietly implies a rule you haven't stated elsewhere — "the decision comes from criteria agreed before the interview happened," for instance, smuggles in a constraint about *when* criteria get set, not just what they are. If you catch yourself doing that, make a mental note; it's exactly the kind of thing worth surfacing explicitly rather than leaving buried in a sentence about messaging.

**Question 5 — Differentiation.** *"What's already true or demonstrable today, not aspirational?"* Be honest about what a spreadsheet already does versus what you actually need the app for. If your answer to this doesn't survive that comparison, that's useful to know now — it's exactly the kind of claim a demolition persona will target first in Lesson 05.

**Question 6 — Operational context.** *"What environment, domain, or platform will this run in or be experienced through?"* For a small self-contained app this is usually short: a personal web page, or a page a handful of named people all reach at the same URL. Answer for what's actually true, not what would look more ambitious.

**Question 7 — Constraints.** *"Are there relevant constraints? If not, just say 'no'."* If you have a real "no," say it plainly. But if something nags at you — a data-retention question, a fairness concern, anything you can name but not fully resolve — don't smooth it into a confident-sounding answer you don't actually believe. A hedge like "I don't know the exact rule, but it feels like something I shouldn't guess at" is a completely legitimate answer here. Onboarding's rule is to never invent what you haven't confirmed, so it goes into your spec as `[TO BE DEFINED]` — and that's exactly the thread Lesson 05 will pick back up.

## Now do it

Open `/cdp:onboarding`. Answer all seven questions honestly, about your own idea from Lesson 02. Confirm the draft when the plugin shows it to you — check that anything genuinely unresolved is marked `[TO BE DEFINED]` rather than quietly filled in with a guess. Once you've confirmed and `project-spec.md` v1.0 is saved, come back here for Lesson 04.

## Check your understanding

- Which of your seven answers do you expect a demolition persona to attack first, and why?
- Did any answer smuggle in a constraint or rule you hadn't stated anywhere else? Where would you go looking for it if you'd missed it?

*Next: [04 — Pick a Persona for Your Domain](04-pick-a-persona-for-your-domain.md).*
