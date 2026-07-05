# SoulDrop

**English** · [Tiếng Việt](README.vi.md) · [ไทย](README.th.md) · [한국어](README.ko.md) · [中文](README.zh.md)

**Drop a soul into any machine — your personal AI assistant, fully automatic.**
*Thả một linh hồn vào bất kỳ máy nào — trợ lý AI cá nhân của bạn, tự động hoàn toàn.*

One command. A friendly interview (never a technical question). Out comes an assistant with its own name, personality, long-term memory, and a second brain — running on the engine that fits you, **paid or 100% free**.

> English and Tiếng Việt are the primary supported languages. Thai, Korean, and Chinese are fully supported; other languages work best-effort via the interview's "Other" option.

> 📸 *Screenshots coming soon*

---

## Choose your engine

SoulDrop separates the **brain** (who your assistant is — plain markdown files you own) from the **engine** (what runs it). Same soul, any engine:

| Engine | Cost | What you get |
|---|---|---|
| **Pro — [Claude Code](https://code.claude.com)** | Paid Claude plan (Pro/Max) | The smartest tier: full skills, **auto skill-forge** (it builds custom abilities for your profession), subagents |
| **Free — [Ollama](https://ollama.com) (local)** | **$0, no account** | A real assistant running 100% on your own computer: persona, memory, "remember ...", second brain. Private by default |
| Codex · Antigravity · OpenClaw | — | 🔜 coming in v0.5 |

You don't have to choose anything technical — the installer **detects Claude Code automatically**, and otherwise asks exactly one human question: *Free or Pro?*

## Install — Windows

Open **PowerShell** (press Start, type "PowerShell", Enter) and paste:

```powershell
irm https://raw.githubusercontent.com/supakitkitsathaporn97-collab/souldrop/main/install/go.ps1 | iex
```

## Install — macOS / Linux

Open **Terminal** and paste:

```bash
curl -fsSL https://raw.githubusercontent.com/supakitkitsathaporn97-collab/souldrop/main/install/go.sh | bash
```

## Then

**Pro engine (Claude):**
1. Type `claude` and press Enter, log in when the browser opens (paid plan required).
2. Type `/onboard`, pick your language, and meet your new assistant — it even forges 3–5 custom skills for your profession before saying hello.

**Free engine (local):**
1. Double-click **SoulDrop** on your Desktop (Windows) or type `souldrop` in a new terminal.
2. Answer six friendly questions (your name, your work, your goal, its name...) — done. Everything runs on your machine; nothing leaves it.

## Requirements

- Windows 10 1809+ / macOS 13+ / Ubuntu 20.04+, internet for the install
- **Free engine:** nothing else. ~2–5 GB disk for the AI model (picked automatically to fit your RAM)
- **Pro engine:** a paid Claude subscription (Pro, Max, or Team) — [claude.ai](https://claude.ai)
- **Don't have Claude yet?** Start with a free 7-day Pro trial → [claude.ai/referral/QbA1I722cA](https://claude.ai/referral/QbA1I722cA) *(referral link — supports this project)*

## One brain, many engines

The brain is **plain markdown — engines are interchangeable**: a persona file (who your assistant is), a memory bank (facts it saves, say *"remember ..."* anytime), and a second-brain note vault at `~/second-brain` shared by every engine. You can read, edit, back up, or move every file yourself. Spec: [`brain/`](brain/README.md) · adapter contract for new engines: [`adapters/`](adapters/README.md).

## What's inside the Pro plugin

| Skill | What it does |
|---|---|
| `/onboard` | The interview that creates your personalized assistant + memory + custom skills + second brain — in English, Tiếng Việt, ไทย, 한국어, 中文, or your own language |
| `forge-skills` | **Auto-builds 3–5 custom skills for your profession and goal** — runs automatically at the end of `/onboard`; re-run anytime with `/forge-skills` or "my goals changed" |
| `create-skill` | Teach your assistant one new ability by describing it — it authors and installs the skill (same quality gate as the forge) |
| `remember` | Saves facts/preferences to your assistant's long-term memory |
| `recall` | Finds things you told it before |
| `learn-from-mistakes` | Turns your corrections into permanent rules |
| `daily-note` | Simple daily journal |
| `work-smart` | Makes the assistant plan before acting and avoid wasted steps |
| `personal` | Personal-assistant baseline: consistent persona, memory habits, honesty, safety boundaries |
| `leader` | For big tasks: plan, break down, delegate, verify, report one clean answer |
| `/setup-vault` | (Re)creates the second-brain note vault at `~/second-brain` — Obsidian-ready |
| `obsidian-markdown` · `obsidian-cli` | Write and organize vault notes properly (wikilinks, tags, safe file operations) |

## What the Free engine gives you

The `souldrop` chat launcher (Desktop shortcut / terminal command): loads your assistant's soul, streams replies from a local model chosen to fit your computer (16 GB+ RAM → an 8B model, 8–16 GB → 3B, under 8 GB → 1B with an honest "it's basic" note), saves facts when you say *"remember ..."*, and writes the same second brain as the Pro tier. No skill-forge on this tier — small local models aren't reliable skill authors, so the core SoulDrop skills are folded into the persona instead. Upgrade to Pro anytime by re-running the installer; your brain comes with you.

## Your second brain

Onboarding creates a note vault at `~/second-brain` — plain markdown files your assistant reads and writes (daily notes, projects, people, ideas). Open the folder in the free [Obsidian](https://obsidian.md) app ("Open folder as vault") to browse it visually — the Pro installer even tries to install Obsidian for you, and everything still works as plain files without it. The Pro installer also tries an optional "smart memory" upgrade (the open-source [agentmemory](https://github.com/rohitg00/agentmemory) plugin); if it can't, your assistant simply keeps remembering via files.

## FAQ

**Is this official Anthropic or Ollama software?**
No. SoulDrop is an independent starter kit. It installs Claude Code and Ollama only by calling their own official installers, then adds the SoulDrop brain on top. See [NOTICE](NOTICE).

**Is the free version really free?**
Yes. The local engine (Ollama) and the models are open source and run entirely on your computer. No account, no subscription, no hidden cost — just disk space and your own hardware.

**Is the install script safe?**
Yes — and you don't have to trust us: [read `install/go.ps1`](install/go.ps1) and [`install/go.sh`](install/go.sh) yourself. They only call official installers, register this repo as a plugin marketplace, and set up the launcher. Windows SmartScreen or antivirus may warn about any script from the internet — that's normal for this install method.

**I ran it twice by accident.**
Totally fine — the script is safe to re-run. It skips whatever is already installed.

**Can I change my assistant later?**
Yes. Run `/onboard` again (Pro) or `souldrop -Reset` / `souldrop --reset` (Free) anytime. Your old profile is backed up first, never deleted.

**Does it collect my data?**
No. Everything stays on your own machine — `~/.claude/` on Pro, `~/souldrop-brain/` on Free. On the free tier not even the AI leaves your computer.

**Old links say `claude-easy-install`?**
Same project — SoulDrop is the new name since v0.4.0. Old GitHub URLs redirect automatically.

---

## License

MIT — see [LICENSE](LICENSE). Claude Code is Anthropic's software and Ollama is Ollama's, each installed via their official installers; see [NOTICE](NOTICE).
