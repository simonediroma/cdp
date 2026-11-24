# Onboarding a Partially Written Book

You don't start a book from a blank page very often. More often there are chapters already written, an outline that half-matches them, notes, maybe a proposal sent to a publisher. This guide shows how to bring all of that into `cdp` so that onboarding **builds the spec from what you've already written** — and asks you only what the manuscript can't answer.

It works the same on **Cowork**, **Claude Code** and **cloud sessions**; the only difference is where you put the files (step 1). See [Where cdp Runs](../appendix/03-where-cdp-runs.md).

## The idea in one line

The manuscript is **evidence**; `project-spec.md` is **the book's brief** — what it must do, for whom, in what voice, against which comparable titles. Onboarding reads the evidence and drafts the brief. Demolition then attacks the brief, not your prose.

## 1. Hand over the initial artifact

Put everything you have in one project, with the manuscript as plain files:

```
my-book/
├── manuscript/
│   ├── 00-outline.md
│   ├── 01-chapter-one.md
│   ├── 02-chapter-two.md
│   └── …
├── notes/            # research, interviews, voice samples — optional
└── proposal.md       # publisher proposal or synopsis — optional, very useful
```

- **One file per chapter, in Markdown or plain text.** A single 300-page `.docx` is the worst input: Word files aren't reliably readable on every surface, and one huge file is read in pieces. Export each chapter to `.md` or `.txt` (PDF also works, but loses structure).
- **Mark the state of each chapter** in its first line — `Status: final`, `draft`, `notes only`. Onboarding treats a polished chapter and a sketch very differently, and it can't reliably tell them apart on its own.
- **Write the outline even if it's rough**, including the chapters not yet written. It's what lets onboarding see the whole book rather than the part that exists.

Where the files go, per surface:

| Surface | Where |
|---|---|
| **Cowork** | the folder you give Cowork to work in |
| **Claude Code** | the directory you start `claude` in |
| **Cloud** | a GitHub repo — **commit and push the manuscript before starting the session**; the session only sees the clone |

## 2. Run `/cdp:onboarding`

Phase 0 reads everything in the project and maps it onto the 11 sections of `project-spec.md`. For a book they read like this:

| Spec section | For a book |
|---|---|
| 1 Brand Identity | the author's identity and platform; the series, if any |
| 2 Target Audience | the primary reader — specific, not "anyone interested in…" — and a secondary one |
| 3 Objective | what the book must do for the reader, and for you (sell, establish authority, open a door) |
| 4 Value Proposition | why this book rather than the ones already on the shelf |
| 5 Message Hierarchy | the thesis, then the arc: what each part or chapter must establish |
| 6 Tone of Voice | the voice the existing chapters already have — onboarding proposes it from them |
| 7 Channels & Touchpoints | formats and route to market: print, ebook, audiobook, newsletter, serialisation |
| 8 Competitive Positioning | comparable titles and how this one differs |
| 9 Constraints | word count, deadline, publisher requirements, rights, sensitive material |
| 10 Declared Limitations | what nobody can answer yet — e.g. "the publisher hasn't confirmed the length" |
| 11 References | the manuscript itself, notes, sources |

Then it tells you what it already has and what it still needs. Expect most questions to come **with a proposed answer** drawn from the manuscript — *"I'd say the primary reader is a mid-career manager, because chapters 2 and 4 keep addressing them — right?"* — so you confirm or correct rather than write from scratch. Questions the manuscript gives no hint on come open, one at a time.

Two things specific to a book:

- **Answer about the book you're writing, not the one on the page.** If chapter 3 drifted from what you intend, say so — the spec records the intent, and the drift becomes something to fix rather than something to inherit.
- **Say "I don't know yet" freely.** Onboarding never guesses: an unanswered question goes into §10 Declared Limitations, where demolition can see it. An invented answer would be invisible.

**Conversion mode won't trigger on a manuscript.** It exists for a document that already *is* a spec — a PRD or a brief covering all 11 sections. A detailed publisher proposal can come close: if onboarding offers to convert it, accept only if the proposal still reflects the book you're writing.

At the end it shows the full draft and saves `project-spec.md` v1.0 only on your confirmation. Facts that will hold for your next book too — your author identity, your audience, your voice — are proposed for `cdp-memory.md` § Brand Facts, so the next onboarding doesn't ask again.

On a **cloud session**, ask Claude to commit and push before you close: otherwise the spec is lost with the container.

## 3. Harden the brief

From here the normal cycle applies — [Course 1, Lesson 06](../course-1-hardened-spec/06-hardening-personas-demolition-integration.md):

- **`/cdp:persona`** — create critics who would actually read this book: an acquiring editor, a reader from your primary audience, a skeptical reviewer in your field.
- **`/cdp:derisk`** — a one-pass sweep for what nobody would think to raise: market saturation, rights on quoted material, a deadline the remaining chapter count can't meet.
- **`/cdp:demolish`** — one criticism at a time against the spec: is the reader real, does the thesis survive, does the arc hold, is the differentiation true today.
- **`/cdp:integrate`** — absorbs what you accept, versions the spec, and eventually freezes it.

Demolition attacks `project-spec.md`, never the manuscript. That's the point: you find out the book's promise is weak *before* writing the remaining chapters, not after.

## 4. Write the rest against the frozen spec

A frozen spec is a brief you can write the missing chapters against — and check the existing ones against. A useful pass: ask Claude to read each written chapter against §5 (what it must establish) and §6 (the voice), and list where it diverges. The divergences are your revision list.

If the book changes direction, don't patch the chapters silently — run `/cdp:integrate` on the spec first, so the brief and the book stay the same book.

## Check your understanding

- Why does onboarding draft the spec *from* the manuscript instead of demolishing the manuscript directly?
- What goes into §10 instead of being answered — and why is that better than a plausible guess?
- On a cloud session, what has to be committed before onboarding, and what after?
