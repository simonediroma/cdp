# Course 2 — Video Prompts (HeyGen)

One entry per lesson. Each gives you the three inputs HeyGen needs: **script** (avatar narration), **on-screen text** (slide bullets synced to the script), and **scene** (background/template). Duration is estimated at ~150 words/minute spoken pace — check against your avatar's actual pacing before finalizing.

**Course-wide scene defaults** (see `minicourse/README.md`): same avatar as Course 1, blueprint/terminal-style slide background, blue accent on command and file names, slightly higher energy register than Course 1 ("let's build").

---

## 01-prd-to-boilerplate

**Estimated duration:** ~65s (≈165 words)

**Script:**
> "This is the step the bare manifesto doesn't have at all. Spec-to-code turns a hardened PRD into an actual build plan — but first it asks: is this spec frozen? No open decisions? If not, it stops. A moving spec produces macros that change mid-build, and that costs more than waiting. Once frozen: it analyzes the PRD, extracts flows and users, chooses a stack if this is greenfield, and runs Deploy Discovery — its own lesson coming up. Then it decomposes into macros through a guided four-step process, and prints the proposed table for your confirmation before generating a single file. Each macro gets sized, ordered by dependency, and risk-leveled. Anything genuinely unspecifiable gets marked spike-pending instead of guessed at."

**On-screen text (synced):**
- "Gate: is the spec frozen?"
- "Analyze → decompose → confirm table → generate"
- "⏳ SPIKE PENDING = don't guess, mark it"

**Scene:** blueprint background; a macro table (M0, M1, M2...) builds row by row in blue monospace, with one row flashing amber and labeled "⏳ SPIKE PENDING."

---

## 02-deploy-discovery

**Estimated duration:** ~60s (≈150 words)

**Script:**
> "A loose architectural definition for a new project could get away with one silent line: pick the simplest stack, flag it as an assumption. But budget, provider, region, domain — those aren't the kind of thing that should default quietly. Deploy Discovery is the hardened version of that decision: before macros get decomposed, the plugin proposes a concrete setup — platform, strategy, a rough monthly cost — based on your stack and PRD. Then it refines with you: is there a budget ceiling? An existing or preferred provider? Any region or compliance constraint? A custom domain? You confirm the final decision in one sentence before anything else proceeds. That decision then decides whether a dedicated deploy macro even gets triggered, and it becomes the actual setup guide you'll follow later."

**On-screen text (synced):**
- "Propose → refine → confirm"
- "Budget · Provider · Region · Domain"
- "Feeds M_deploy and docs/deploy-setup.md"

**Scene:** blueprint background; a proposal card appears ("Railway — PaaS — ~$5-20/mo"), then four small question chips (budget/provider/region/domain) tick off one by one.

---

## 03-anatomy-of-the-output

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "Same content, two shapes. Claude Code gets CLAUDE.md, CLAUDE_MEMORY.md, one prompt file per macro, and HANDOFF.md. Cursor gets three always-active rule files plus one glob-activated rule per macro — open a macro's files, and its rule activates automatically. Two files are genuinely identical either way: docs/architecture.md and docs/deploy-setup.md. Every macro prompt is self-contained: what to read first, a single-responsibility objective, binary acceptance criteria, exact test and build commands, and a Pre-PR Gate scaled to risk. Neither track is the 'real' one — pick whichever tool you actually use."

**On-screen text (synced):**
- "CLAUDE.md ←→ .cursor/rules/*.mdc"
- "Identical either way: architecture.md, deploy-setup.md"
- "Gate scales with risk: LOW → HIGH"

**Scene:** blueprint background; a split screen, left labeled "Claude Code" right labeled "Cursor," both showing the same file icons converging in the middle on the two shared docs.

---

## 04-the-agent-skills-rules

**Estimated duration:** ~65s (≈165 words)

**Script:**
> "The plugin's own reference file calls these gates \"Osmani behaviors\" — a person's name where a repo name belongs, never explained, never cited. The confirmed source is Addy Osmani's agent-skills plugin, so that's what this course calls them from here: the agent-skills rules. What matters isn't the name, it's the five behaviors themselves and the loops they actually run. Doubt-driven review: claim, doubt, reconcile, capped at 3 cycles — and if the doubt won't resolve by then, that's the rule telling you to stop and ask a human, not keep looping. TDD: red, green, refactor. Incremental implementation: no more than 100 lines without running tests. And here's the honest part — not every one of these is generated as consistently as the reference file promises. Cursor's rules quietly drop the safety-valve sentences Claude Code keeps. TDD leaks into low-risk macros that shouldn't have it. Frontend macros have no template at all yet. Know this before you trust the boilerplate blindly."

**On-screen text (synced):**
- "Not \"Osmani\" — the agent-skills repo"
- "CLAIM → DOUBT → RECONCILE, capped at 3"
- "Not everywhere it's promised — check what you actually got"

**Scene:** blueprint background; five gate icons light up one by one (5-axis, TDD, doubt, security, shipping), one (FRONTEND) stays grey/unlit while the others glow, a magnifying glass hovers over the unlit one.

---

## 05-executing-the-plan

**Estimated duration:** ~55s (≈140 words)

**Script:**
> "Clone, set up your env file, run the install command from HANDOFF or SETUP. Then one phrase: 'what's the next task?' in Claude Code, or 'next task' in Cursor's Composer. You get session status, a plan of up to five steps, and one concrete first command. Work the macro fully — Doubt-Driven Review first if it's high risk, then TDD, then the Pre-PR Gate. Memory updates once, immediately after, not at some vague later point. One branch, one PR, per task — never straight to main. And notice: both tools deliberately refuse to fire that trigger on a request like 'explain this file.' Read-only questions just get answered — no ritual, no memory update."

**On-screen text (synced):**
- "\"what's the next task?\" / \"next task\""
- "One macro fully, one branch, one PR"
- "Read-only requests: no trigger, no update"

**Scene:** blueprint background; a terminal cursor types the trigger phrase, a plan with 3 numbered steps appears, then a branch/PR icon locks in at the end.

---

## 06-shipping-m-deploy

**Estimated duration:** ~60s (≈150 words)

**Script:**
> "Every other macro ends with a review scaled to risk. M_deploy ends with something different: the Shipping checklist, because 'does the code work' isn't the question anymore — 'is this actually live and safe' is. Seven checks: deployment follows the setup guide step by step, every environment variable is set on the platform itself, not just locally, no secret sits in the repo, the health check responds from the public URL, the domain resolves if one was decided, the rollback procedure has actually been tried once, not just written down, and the real cost matches the budget you agreed to. Only after all seven pass does the familiar 5-axis review even apply — to the deploy config itself. Nothing here re-decides anything. It verifies the macro did exactly what you already confirmed."

**On-screen text (synced):**
- "7-point Shipping checklist, not the usual 5-axis"
- "Env vars on the platform. Rollback tried, not just written."
- "Verifies the decision. Doesn't re-decide it."

**Scene:** blueprint background; seven checklist items tick off one by one in blue, the seventh (cost) flashes amber if unresolved, then a URL bar appears with a green "live" dot.

---

## 07-exercise

**Estimated duration:** ~50s (≈125 words)

**Script:**
> "Pick something small and real — one core flow, one real user, big enough to survive a demolition round without it being ceremony. Then walk the whole loop: onboard, persona, at least three demolish-and-integrate cycles, spec-to-code, Deploy Discovery answered for real — an actual budget, not a placeholder — then execute every macro through to M_deploy's full Shipping checklist. Done doesn't mean it built. Done means you can hand someone a URL, right now, on a device that isn't the one you built it on, and it does the one thing your spec said it would do."

**On-screen text (synced):**
- "One real flow. One real user."
- "Full loop → spec-to-code → M_deploy"
- "Done = a URL you can hand someone, right now"

**Scene:** blueprint background; the full loop diagram from Course 1 replays start to finish, ending on a browser window showing a live URL.
