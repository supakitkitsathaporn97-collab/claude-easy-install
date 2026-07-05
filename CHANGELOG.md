# Changelog

All notable changes to this project are documented here.
Format: [Keep a Changelog](https://keepachangelog.com/) · Versioning: [SemVer](https://semver.org/).

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
