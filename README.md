# Claude Code Easy Install

**English** · [Tiếng Việt](README.vi.md) · [ไทย](README.th.md) · [한국어](README.ko.md) · [中文](README.zh.md)

**One command → Claude Code installed → your own personal AI assistant, in your language.**

> English and Tiếng Việt are the primary supported onboarding languages. Thai, Korean, and Chinese are fully supported in `/onboard` and these docs; other languages work best-effort via the interview's "Other" option.

> 📸 *Screenshots coming soon*

---

## What is this?

Most Claude Code starter kits give you files to edit by hand. This one **interviews you** and writes your setup for you:

1. Installs [Claude Code](https://code.claude.com) using **Anthropic's official installer** (we never re-host their software).
2. Installs the `nick-starter` plugin from this repo.
3. You type `/onboard` → a friendly interview asks your name, what you need help with, your assistant's **name** and **personality** → it writes a personalized profile and sets up a persistent memory ("second brain") for your assistant.

No Node.js, no Git, no admin rights required.

## Install — Windows

Open **PowerShell** (press Start, type "PowerShell", Enter) and paste:

```powershell
irm https://raw.githubusercontent.com/supakitkitsathaporn97-collab/claude-easy-install/main/install/go.ps1 | iex
```

## Install — macOS / Linux

Open **Terminal** and paste:

```bash
curl -fsSL https://raw.githubusercontent.com/supakitkitsathaporn97-collab/claude-easy-install/main/install/go.sh | bash
```

## Then

1. Type `claude` and press Enter.
2. Log in when the browser opens — **a paid Claude plan (Pro or Max) is required**.
3. Type `/onboard`, pick your language, and meet your new assistant.

## Requirements

- Windows 10 1809+ / macOS 13+ / Ubuntu 20.04+
- Internet connection
- A paid Claude subscription (Pro, Max, or Team) — [claude.ai](https://claude.ai)

## What's inside the plugin

| Skill | What it does |
|---|---|
| `/onboard` | The interview that creates your personalized assistant + memory — in English, Tiếng Việt, ไทย, 한국어, 中文, or your own language |
| `remember` | Saves facts/preferences to your assistant's long-term memory |
| `recall` | Finds things you told it before |
| `learn-from-mistakes` | Turns your corrections into permanent rules |
| `daily-note` | Simple daily journal |
| `work-smart` | Makes the assistant plan before acting and avoid wasted steps |

## FAQ

**Is this official Anthropic software?**
No. This is an independent starter kit. It installs Claude Code by calling Anthropic's own official installer, then adds a plugin on top. Claude Code itself belongs to Anthropic.

**Is the install script safe?**
Yes — and you don't have to trust us: [read `install/go.ps1`](install/go.ps1) and [`install/go.sh`](install/go.sh) yourself. They only (1) call Anthropic's official installer, (2) register this repo as a plugin marketplace, (3) install the plugin. Windows SmartScreen or antivirus may show a warning for any script from the internet — that's normal for this install method.

**I ran it twice by accident.**
Totally fine — the script is safe to re-run. It skips whatever is already installed.

**Can I change my assistant later?**
Yes. Run `/onboard` again anytime. Your old profile is backed up first, never deleted.

**Does it collect my data?**
No. Everything the interview writes stays in `~/.claude/` on your own machine.

---

## License

MIT — see [LICENSE](LICENSE). Claude Code itself is Anthropic's software, installed via their official installer; see [NOTICE](NOTICE).
