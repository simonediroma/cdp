---
name: persona
description: Creates and modifies personas for demolition cycles. Supports guided onboarding, free-flow from free text, and cloning of predefined personas.
argument-hint: "[persona name to create or edit]"
disable-model-invocation: true
allowed-tools: Read, Write, Edit, Glob
---

# Skill: Persona

## Phase 0 — Read

List the files present in `personas/`. Each file is a custom persona (filename = ID). If the directory doesn't exist or is empty, the custom list is empty. Do not create files now.

Do not read `project-spec.md` — this skill does not need it.

The 6 predefined personas are defined in the **Reference — Predefined Personas** section at the end of this file. Do not look for them elsewhere.

## Phase 1 — Select Action

Ask what they want to do:

```
What do you want to do?
1. Create a new custom persona
2. Modify an existing custom persona
3. Clone a predefined persona as a starting point
```

- If they choose **2** and there are no custom personas: "You don't have custom personas yet. Do you want to create a new one?"
- If they choose **2** and there are custom personas: show the list with name and key question, ask which to modify.
- If they choose **3**: show the 6 predefined personas with name and key question, then go to Phase 3 — Modify with the pre-populated fields of the chosen persona (which becomes a new custom persona, does not overwrite the predefined one).

## ID Rule — no collisions

Every time an `id` is derived or modified, apply this check before proceeding:

1. Check if `personas/[id].md` already exists.
2. If it exists and it's the **same persona being modified**: no problem, the overwrite is intentional.
3. If it exists and it's a **different persona**: warn and propose an alternative ID.

```
The ID "[id]" is already used by another persona.
Proposed alternative: "[id]-2"
Do you want to use this ID or choose a custom one?
```

Do not proceed until the ID is unique. The user can accept the proposal or enter a custom ID (lowercase slug, only `[a-z0-9-]`).

---

## Phase 2A — Creation: Guided Onboarding

Interview one question at a time. After each response, confirm in one sentence what you understood and ask "Is that correct?" before proceeding.

**Question 1 — Name**
"What is this persona called?"
→ `name`. Infer `id` as lowercase slug (e.g. "The Board" → "the-board"). Show the proposed id, apply the **ID Rule**, then ask for confirmation.

**Question 2 — Role**
"Who are they and why are they in the room? Describe their role, their fundamental point of view, and what brings them to judge this type of project."
→ `role`

**Question 3 — Tone**
"How do they formulate criticism? What style and register do they use? Think about how they'd speak in a meeting."
→ `tone`

**Question 4 — Key question**
"What is the question they ask above all others — the one where, if you don't have an answer, everything stops?"
→ `key_question`

**Question 5 — Category priority**
"Which vulnerabilities do they attack first? Order these 7 categories from most to least important for this persona:

- audience-fit (does the message truly reach the audience?)
- claim (are the statements provable?)
- differentiation (is the positioning truly unique?)
- hierarchy (is the primary message clear?)
- channel (does the message work on the chosen channel?)
- tone (is the register consistent with the brand?)
- objective-gap (does the campaign truly lead to the objective?)

You can list them in order, or describe the priorities in words and I'll order them."
→ `priority` (array of 7 elements)

If the user describes in words (e.g. "numbers first, then whether the claims hold up"): infer the order and show it for confirmation.

**Question 6 — Freecontext (optional)**
"Is there anything else I should know about this persona? Specific background, sector of origin, past experiences, known biases, particular relationship with this type of project. Leave blank if you have nothing to add."
→ `freecontext` (free string; if the user doesn't respond or says "no", the field is an empty string)

Then go to **Phase 4 — Confirm and Save**.

## Phase 2B — Creation: Free Flow

The user provides a description as free text — a paragraph, a characterization, a character sketch.

Internally extract the 6 fields from the description:
- `name`: if not explicit, propose a name and ask for confirmation
- `id`: slug from the proposed name — apply the **ID Rule** immediately before presenting the extracted persona
- `role`: extract from the text; if ambiguous, use the most descriptive phrase of the point of view
- `tone`: extract adjectives and mannerisms from the text
- `key_question`: extract or infer; if not present, formulate a question consistent with the profile and ask for confirmation
- `priority`: infer from the described attitude (e.g. if the text says "only wants numbers" → objective-gap and claim come first)
- `freecontext`: everything that doesn't fit in the structured fields goes here in full, plus any contextual nuances

Present the fully extracted persona:

```
I extracted this persona from your text:

Name: [name]
ID: [id]
Role: [role]
Tone: [tone]
Key question: [key_question]
Priority: [priority 1] → [priority 2] → ... → [priority 7]
Freecontext: [freecontext]

Do you want to change anything before saving?
```

If the user wants to modify: treat as Phase 3 — Modify.
If they confirm: go to **Phase 4 — Confirm and Save**.

For required fields that can't be extracted (`priority` if ambiguous): ask one targeted question, not a complete interview.

## Phase 3 — Modify

Show the complete persona with numbered fields:

```
Persona: [name]

1. Name: [name]
2. ID: [id]
3. Role: [role]
4. Tone: [tone]
5. Key question: [key_question]
6. Priority: [priority 1] → ... → [priority 7]
7. Freecontext: [freecontext or "(empty)"]

Which field do you want to modify? (number or field name)
```

The user can:
- Indicate the field number + new value
- Say in natural language what to change (e.g. "make the tone more aggressive", "put objective-gap first")

Apply the change, show the updated field, ask if they want to modify anything else.

Repeat until the user says it's good.

> Predefined personas cannot be modified directly. If the user tries to modify a predefined one, say: "Predefined personas cannot be modified. Do you want to clone it and modify the copy?"

> If the **ID** field (field 2) is modified: apply the **ID Rule** on the new value before continuing.

Then go to **Phase 4 — Confirm and Save**.

## Phase 4 — Confirm and Save

Present the final complete persona in the same format as Phase 3.

Ask: "Confirm save?"

**After explicit confirmation:**

1. Write (or overwrite) the file `personas/[id].md` in the standard format:

```
## [Persona Name]
- **ID**: [id]
- **Role**: [role]
- **Priority**: [cat1] → [cat2] → [cat3] → [cat4] → [cat5] → [cat6] → [cat7]
- **Tone**: [tone]
- **Key question**: "[key_question]"
- **Freecontext**: [freecontext or "(empty)"]
```

2. Confirm: "Persona '[name]' saved in personas/[id].md. It will be available as an option in the next /cdp:demolish."

> Never write to `personas/` without explicit user confirmation.

---

## Reference — Predefined Personas

Use these profiles in Phase 1 (action selection) and Phase 3 (cloning). For custom personas read `personas/[id].md`.

**The Target Customer**
- **Role**: the message recipient. Has little time and zero patience for corporate communication.
- **Priority**: audience-fit → hierarchy → tone → claim → objective-gap → channel → differentiation
- **Tone**: direct, practical, first person. Speaks like someone who needs to make a concrete decision.
- **Key question**: "Why should I choose you?"
- **Freecontext**: has already compared at least 3 options before arriving here. Has been disappointed in the past by similar promises that turned out to be false. Reacts badly to generic corporate communication because they recognize it immediately.

**The Competitor**
- **Role**: the marketing director of the main competitor. Knows the market better than anyone.
- **Priority**: differentiation → claim → objective-gap → hierarchy → audience-fit → channel → tone
- **Tone**: analytical, aggressive, market-oriented. Looking for the claim they can copy tomorrow morning.
- **Key question**: "What's here that I can't copy?"
- **Freecontext**: has monitored the brand's previous campaigns and knows their historical weak points. Knows where positioning has already failed. Has comparable budget and can respond with a mirror campaign in 4 weeks.

**The Journalist**
- **Role**: investigative journalist specializing in the sector. Looking for the public angle of attack.
- **Priority**: claim → differentiation → audience-fit → objective-gap → tone → hierarchy → channel
- **Tone**: skeptical, pressing. Wants proof, not promises. Looking for inconsistencies between claims and verifiable reality.
- **Key question**: "What happens if I put this to the test?"
- **Freecontext**: has already written critical pieces on brands in the sector and knows how to verify official claims. Has inside sources in the market. Their ideal headline is "Brand X promises X but the data says Y".

**The Creative Director**
- **Role**: the creative who must turn this spec into something memorable. Does not tolerate genericness.
- **Priority**: hierarchy → tone → audience-fit → differentiation → channel → claim → objective-gap
- **Tone**: demanding, visionary. Looking for the unique point of view, the creative tension, permission to be bold.
- **Key question**: "What's the most interesting thing in this brief?"
- **Freecontext**: has already worked on similar briefs for other brands in the sector and knows exactly how genericness produces mediocre work. Has seen campaigns that started from specs like this end up in the drawer. If they can't find creative tension in the brief, they can't do their job.

**The CFO**
- **Role**: financial officer. Every soft metric must translate into measurable economic impact.
- **Priority**: objective-gap → claim → channel → hierarchy → differentiation → audience-fit → tone
- **Tone**: blunt, numbers-oriented. Zero tolerance for unmeasurable objectives or undeclared ROI.
- **Key question**: "How do we measure this and what justifies the spend?"
- **Freecontext**: has already rejected budgets for similar campaigns that had no clear measurement plan. Their benchmark is the previous campaign: if the spec doesn't show how to beat that result, they won't approve. Always asks for the measurement plan before discussing creativity.

**Legal & Compliance**
- **Role**: legal officer. Every superlative is a risk. Every comparative claim is an exposure.
- **Priority**: claim → channel → differentiation → objective-gap → audience-fit → tone → hierarchy
- **Tone**: precise, formal, risk-focused. Looking for what cannot be defended in front of a disappointed customer or the regulator.
- **Key question**: "What happens if someone asks us to prove it?"
- **Freecontext**: knows the regulatory precedents in the sector and has a mental list of claims that have been challenged in the past. Must approve every headline and every comparative claim before publication. Their sign-off is the final bottleneck before go-live.
