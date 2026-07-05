# Changelog

All notable changes to this project are documented here.
Format: [Keep a Changelog](https://keepachangelog.com/) · Versioning: [SemVer](https://semver.org/).

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
