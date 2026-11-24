# Skill /persona — Guided Interview

## Question 1 — Name
"What is this persona called?"

Fields: `name` (free string) + `id` (auto-inferred slug, e.g. `the-growth-hacker`)
Claude proposes the id and asks for confirmation before proceeding.

---

## Question 2 — Role
"Who are they and why are they in the room? Describe their role, their fundamental point of view, and what brings them to judge this type of project."

Collect: identity (title, function), why they judge, the lens through which they view the project.

> Example: "Co-founder of a digital marketplace, CMO + CPO. 20+ years of digital marketing. Business and numbers-oriented, with a strong bias toward concrete execution."

---

## Question 3 — Tone
"How do they formulate criticism? What style do they use in a meeting?"

Collect: operational adjectives, attack mode. Not abstract descriptions — observable behaviors.

> Example: "Direct but empathetic. Says things without filters but with emotional intelligence. Attacks reasoning, not people."

---

## Question 4 — Key Question
"What is the question they ask above all others — the one where, without an answer, everything stops?"

Collect: one single first-person, blocking question.

> Examples: "How do we measure this?" / "What happens if I put this to the test?" / "Why should I choose you?"

---

## Question 5 — Category Priority
"Order these 7 categories from most to least important for this persona:"

| Slug | Test question |
|------|--------------|
| `audience-fit` | Does the message truly reach the audience? |
| `claim` | Are the statements provable? |
| `differentiation` | Is the positioning truly unique? |
| `hierarchy` | Is the primary message clear? |
| `channel` | Does the message work on the chosen channel? |
| `tone` | Is the register consistent with the brand? |
| `objective-gap` | Does the campaign truly lead to the objective? |

The user can list them in order or describe them in words — Claude infers and asks for confirmation.

**Inference from natural language:**
- "Numbers first" → `objective-gap`, `claim` at the top
- "Wants proof" → `claim` first
- "Checks if the message lands" → `audience-fit` first
- "Wants uniqueness" → `differentiation` first

In the file, serialized as: `cat1 → cat2 → ... → cat7`

---

## Question 6 — Freecontext *(optional)*
"Is there anything else I should know? Background, past experiences, known biases, relationship with this type of project. Leave blank if you have nothing to add."

Collect: relevant biographical context, biases and their origin, specific behavioral patterns.
If empty → field omitted from the file.

> Example: "Has an F5 tattoo on their wrist — symbol of their operational culture: real-time verification, continuous iteration."
