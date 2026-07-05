# Changelog

All notable changes to this project are documented here.
Format: [Keep a Changelog](https://keepachangelog.com/) · Versioning: [SemVer](https://semver.org/).

## [0.5.0] — 2026-07-05

The **beginner-love** release: hand-hold everything, one-click for lazy people.
Nobody should ever have to install a tool by hand again.

### Added
- **One-click installer for Windows:** `SoulDrop-Installer.bat` at the repo
  root — download, double-click, done. It relaunches the official `go.ps1`
  with `-ExecutionPolicy Bypass` and pauses at the end so the window never
  vanishes. READMEs explain the SmartScreen "More info → Run anyway" step
  honestly (it appears for any unsigned download).
- **Git auto-install:** `claude plugin marketplace add` clones this repo with
  git, so both installers now install git themselves when it's missing —
  winget `Git.Git` on Windows; brew or Apple's Command Line Tools on macOS;
  a one-line `apt-get` hint on Linux (we never auto-sudo). Silent,
  non-blocking, one friendly line — users are never told to install git.
- **Complete beginner walkthrough** in all 5 READMEs (Vietnamese richest):
  how to open PowerShell with 4 self-made SVG step cards
  (`assets/guide/open-powershell-1..4.svg`, brand palette, simplified UI —
  no copyrighted screenshots); **two ways to use Claude** — Claude Desktop's
  built-in Code tab (`/plugin marketplace add` + `/plugin install` +
  `/onboard`, no terminal at all) vs the CLI, as a friendly Easy-vs-Power
  table; manual Ollama install with a pick-your-model-by-RAM table; and a
  "🎬 Video tutorials" slot wired for GitHub's inline-player rule (only
  `user-attachments` uploads render inline — repo `.mp4` files do not; see
  `assets/media/README.md` for the drop-zone recipe).
- README install section now has **two paths**: 🖱️ download-and-double-click
  (the .bat) and ⌨️ the one-paste command.

### Fixed
- **Ollama launchers (`adapters/ollama/souldrop.ps1` / `.sh`): model checked
  before chat.** The launcher now verifies the model exists via `/api/tags`
  and auto-pulls it with visible progress if missing — no more chatting into
  a void. After 3 consecutive chat failures it states the REAL reason
  (engine down / model missing / likely low memory) instead of repeating
  "the engine hiccuped".
- **`go.sh`:** no more raw `/dev/tty` error line when there is no usable
  terminal (CI, containers) — the engine question quietly defaults to Free.
- **`go.ps1` / `go.sh`:** no longer print "OK: Official installer finished"
  when Anthropic's installer actually failed — the failure is now caught and
  reported honestly, with the usual fix (low RAM ≈ 512 MB free needed; open
  a new terminal and re-run).

### Changed
- Future-engine mentions (Codex · Antigravity · OpenClaw) moved from
  "v0.5" to "v0.6" in READMEs and `assets/engines.svg` — this release is
  about beginners, not new engines.

## [0.4.0] — 2026-07-05

The **SoulDrop** release: rebrand + multi-engine architecture + a free tier.
"Drop a soul into any machine — your personal AI assistant, fully automatic."

### Presentation & CI (2026-07-05 — README pro redesign, no version bump)
- **README hero redesign, all 5 languages:** centered logo (dark/light
  `<picture>` swap), shields.io badge row (CI · version · license · platform ·
  languages · PRs-welcome), language switcher in the hero, **animated SVG
  terminal demo** (`assets/demo.svg` — the full install → `/onboard` →
  skill-forge flow, ~18 s CSS-animated loop that plays right on GitHub),
  engines illustration, emoji section icons, centered footer. All prose and
  install URLs unchanged — presentation only.
- **New self-made SVG assets** in `assets/`: `logo.svg` (+`-dark`/`-light`),
  `banner.svg`, `demo.svg` (animated), `engines.svg` (animated connectors,
  abstract engine shapes — no trademarked artwork).
- **CI:** `.github/workflows/validate.yml` — JSON manifest parse, `bash -n`
  on shell scripts, PowerShell AST parse on `.ps1`, and a SKILL.md
  frontmatter lint (`.github/scripts/lint-skills.mjs`). Status badge in
  every README.

### Renamed
- **Project renamed: `claude-easy-install` → `souldrop` (product name: SoulDrop).**
  Marketplace name, plugin name (`nick-starter` → `souldrop`), plugin folder
  (`plugins/nick-starter/` → `plugins/souldrop/`), install URLs, banners, and
  all five READMEs. Old GitHub URLs redirect automatically. New install:
  `claude plugin marketplace add supakitkitsathaporn97-collab/souldrop` +
  `claude plugin install souldrop@souldrop`.

### Added
- **One brain, many engines.** New `brain/` spec: the portable assistant =
  persona file + memory bank + second-brain vault, all plain markdown —
  engines are interchangeable. New `adapters/` layer with a written adapter
  contract (install engine → install brain → wire persona → report status)
  so future engines (Codex, Antigravity, OpenClaw — v0.5) slot in without
  restructuring. `adapters/claude-code/` documents the existing Pro flow.
- **FREE TIER (Ollama, local).** For people with no subscription:
  - Engine auto-detect in both bootstraps: Claude Code present → Pro path,
    zero questions; otherwise ONE bilingual human question — Free (local,
    no account) or Pro (smarter, needs a Claude plan).
  - Free path, fully automatic: installs Ollama via official channels only
    (winget `Ollama.Ollama` / Homebrew / ollama.com install.sh), detects
    system RAM and picks a fitting model (≥16 GB → `llama3.1:8b`, 8–16 GB →
    `llama3.2:3b`, <8 GB → `llama3.2:1b` with an honest "it's basic" note),
    starts the server, pulls the model with visible progress.
  - **`souldrop` chat launcher** (`adapters/ollama/souldrop.ps1` /
    `souldrop.sh` — installed to the user's machine + Desktop shortcut /
    PATH command): first run is the onboarding interview (six human
    questions: language, name, work, goal, assistant name, personality) →
    writes the universal brain (`~/souldrop-brain/persona.md` + `memory/` +
    shared `~/second-brain/` vault); every run streams chat against the
    local `/api/chat` with persona + recent memory as system prompt; saying
    "remember ..." appends to the memory bank live. PowerShell 5.1-native /
    bash+curl with python3-assisted streaming and a pure-shell fallback —
    zero extra dependencies. `-Reset`/`--reset` re-onboards (old persona
    backed up, never deleted).
  - No skill-forge on this tier (small models can't author skills reliably);
    the generic SoulDrop skills' content is folded into the persona instead.
  - Every failure on the free path = one friendly bilingual line + pointer
    to the Pro path with the referral link. Never a stuck beginner.
- NOTICE now covers Ollama (installed via official channels, never re-hosted).

### Changed
- READMEs (all 5 languages) restructured around SoulDrop: bilingual tagline,
  "Choose your engine" table (Pro / Free / coming-soon engines), per-engine
  install + next steps, "One brain, many engines" section, free-tier FAQ.
- Bumped plugin + marketplace manifests to 0.4.0.

## [0.3.0] — 2026-07-05

The "everything automatic" release. Design rule enforced everywhere: the user
answers only HUMAN questions (name, profession, goal, assistant name,
personality, language); every technical step is automatic and non-blocking —
a failure means one friendly line, never a stuck beginner or a raw error.

### Added
- **Auto skill-forge (`forge-skills`)** — at the end of `/onboard`, the
  assistant automatically derives 3–5 tightly-scoped custom skills from the
  user's profession + goal (bundled `templates/domain-map.md` heuristics +
  reasoning over their free-text goal), generates each `SKILL.md` (Anthropic
  frontmatter spec: kebab name, pushy third-person description with concrete
  triggers), runs a 9-point quality gate (frontmatter lint, dedup, max 2
  regen retries — a failing skill is never installed), installs survivors to
  `~/.claude/skills/`, and greets the user showing what it built.
  Re-runnable anytime via `/forge-skills` or "my goals changed".
- **`create-skill`** — interactive single-skill author; same quality gate as
  the forge, beginner-safe wording ("teach your assistant a new ability").
- **`leader`** — generic plan → decompose → delegate → verify → report-one-
  answer orchestration doctrine.
- **`personal`** — personal-assistant baseline: persona-first, recall-before-
  asking, save-without-being-told memory habit, honesty + safety boundaries.
- **Auto second brain** — `/onboard` now auto-creates an Obsidian-compatible
  vault at `~/second-brain` (skeleton in `templates/vault/`: `.obsidian/`
  config, 7 folders, `Home.md`, `README.md`); `/setup-vault` re-runs it.
  New generic skills: `obsidian-markdown` (wikilinks/tags/callouts
  conventions) and `obsidian-cli` (safe vault file operations).
- **Bootstrap extras (both installers, silent + non-blocking):** Step 4 tries
  Node.js LTS (winget / Homebrew) + the open-source agentmemory plugin
  (`rohitg00/agentmemory`, Apache-2.0) for semantic memory — installed from a
  stable `~/.agentmemory` CWD so its data store persists; Step 5 tries the
  free Obsidian app (winget / Homebrew cask). Any failure prints one friendly
  line ("Smart memory skipped — your assistant still remembers via files")
  and continues.
- **Referral (disclosed):** the installers show a labeled referral line for a
  free 7-day Pro trial ONLY when no Claude login is detected; one line in
  each README's Requirements. Once per surface, always labeled "referral".
- `templates/SKILL.md.tmpl` — shared output template for forge + create-skill.

### Changed
- `/onboard` interview now also captures profession ("What do you do?") and a
  free-text #1 goal — the forge's fuel; recorded in the profile's new
  "About" section and `about-me.md`. Still zero technical questions.
- `CLAUDE.md.tmpl` gained the About section (profession + goal).
- `i18n.md` gained VI/TH/KO/ZH strings for the new questions + forge intro.
- Bumped plugin + marketplace manifests to 0.3.0; READMEs (all 5 languages)
  document the auto-forge, the second brain, and the referral.
- Install command URLs unchanged.

## [0.2.0] — 2026-07-05

### Added
- **Multi-language onboarding.** `/onboard`'s language gate now offers
  English · Tiếng Việt (primary) · ไทย · 한국어 · 中文, plus an "Other" escape
  that runs the interview in any language the user names. Language is a single
  clean variable through the whole flow — questions, preview, generated
  profile, and first greeting all follow it; the profile records the chosen
  reply language.
- `skills/onboard/templates/i18n.md` — compact native interview strings for
  VI/TH/KO/ZH (English canonical in SKILL.md), so adding a language later is
  one new block + one gate option.
- Translated READMEs with a language switcher on every page:
  `README.vi.md`, `README.th.md`, `README.ko.md`, `README.zh.md`.
  `README.md` is now English-primary (Vietnamese content moved to
  `README.vi.md`). EN & VI are the primary supported onboarding languages;
  TH/KO/ZH fully supported, others best-effort.

### Changed
- Bumped plugin + marketplace manifests to 0.2.0; descriptions/keywords now
  reflect the five supported languages.
- Install scripts, commands, and URLs unchanged.

## [0.1.0] — 2026-07-05

### Added
- First MVP release.
- `install/go.ps1` / `install/go.sh` — one-paste bootstrap: calls Anthropic's
  official Claude Code installer, then adds this marketplace and installs the
  `nick-starter` plugin. Idempotent, no admin, PowerShell 5.1-compatible.
- Plugin marketplace manifest (`.claude-plugin/marketplace.json`).
- `nick-starter` plugin v0.1.0:
  - `/onboard` — bilingual (VN/EN) interview that generates a personalized
    assistant profile (`~/.claude/CLAUDE.md`) and a memory scaffold
    (`~/.claude/memory/`), with backup/merge guardrails and preview-confirm.
  - Core skills: `work-smart`, `remember`, `recall`, `learn-from-mistakes`,
    `daily-note`.
  - Templates: `CLAUDE.md.tmpl`, `MEMORY.md.tmpl`.
- Bilingual README (EN/VN), MIT LICENSE, NOTICE.

### Notes
- SessionStart auto-hint hook deliberately deferred: plugin hooks are supported,
  but a hook command that runs reliably on beginner Windows machines (no bash,
  PowerShell 5.1) needs its own testing pass. Planned for 0.2.0. The bootstrap
  script and README both tell the user to type `/onboard`.
