---
name: doctor
description: Checks the health of the whole SoulDrop install — engine, plugin, profile, memory, second brain, optional extras — auto-fixes what it can, and prints one friendly health card. Use when the user types /doctor, says "something broke", "it's not working", "check my assistant", "kiểm tra trợ lý", "trợ lý bị lỗi", "ตรวจสอบผู้ช่วย", "어시스턴트 확인", "检查助手" — even if they can't describe what's wrong.
---

# Doctor — check everything, fix what you can, report in plain words

The user thinks something is broken (or just wants reassurance). Check every
part of their SoulDrop setup, silently repair what is safely repairable, and
give them ONE short health card in their language. They are a beginner:
**no jargon, no file paths, no raw errors, no YAML** — ever.

Golden rules:

- **Read-mostly, repair-safely.** Auto-fixes are limited to re-running
  idempotent installs and recreating missing scaffolding. NEVER delete,
  overwrite, or "reset" the user's brain files (profile, memory, vault) —
  those are theirs.
- **Non-blocking.** A check that itself errors = mark it "couldn't check",
  move on. The card always prints.
- **Speak `LANG`** (the profile's language / the session language).
  The card below is the English canon; translate naturally.

## Step 0 — Read the install manifest

Read `~/.souldrop/installed.json` (written by the installer): it carries the
SoulDrop version, the engine, the install date, and which optional extras the
installer actually added. Use it to (a) print the version in the card header
— **"SoulDrop v0.6.0"**, prominently, first line — and (b) know whether
checks 7–9 were ever supposed to be on. Manifest missing = not an error:
print the plugin's own version instead and check everything live.

## Step 1 — Run the checks

Run each check; record ✅ (good), 🔧 (was broken, fixed it), or ⚠️ (needs
the user / couldn't fix). Use quiet shell calls; never show raw output.

| # | Check | How | Auto-fix if failing |
|---|---|---|---|
| 1 | Engine alive | `claude --version` exits 0 | none — ⚠️ with "re-run the installer" line |
| 2 | SoulDrop plugin | `claude plugin list` contains `souldrop` | `claude plugin marketplace update souldrop` then `claude plugin install souldrop@souldrop` |
| 3 | Profile exists | `~/.claude/CLAUDE.md` exists and is non-empty | none — ⚠️ suggest `/onboard` (their memory is safe either way) |
| 4 | Memory bank | `~/.claude/memory/MEMORY.md` exists | recreate the empty scaffold from this plugin's onboard templates (`${CLAUDE_PLUGIN_ROOT}/skills/onboard/templates/MEMORY.md.tmpl`) — only when MISSING, never touch an existing one |
| 5 | Custom toolkit | `~/.claude/skills/` has ≥1 skill folder | none — ⚠️ suggest saying "build me skills" |
| 6 | Second brain | `~/second-brain/Home.md` exists | re-copy ONLY missing pieces from `${CLAUDE_PLUGIN_ROOT}/templates/vault/` (same fill-gaps rule as /setup-vault) |
| 7 | Documents pack | `claude plugin list` contains `document-skills` | re-run: `claude plugin marketplace add anthropics/skills` (or `marketplace update anthropic-agent-skills`), then `claude plugin install document-skills@anthropic-agent-skills` |
| 8 | Browsing power | `claude mcp get chrome-devtools` exits 0 | only if Chrome is installed (Windows: App Paths registry key or standard chrome.exe locations; macOS: `/Applications/Google Chrome.app`): `claude mcp add chrome-devtools --scope user -- npx chrome-devtools-mcp@latest`. No Chrome → report as "off (no Chrome)" — that is NOT a failure |
| 9 | Free engine (only if `~/souldrop/config.txt` or `~/.souldrop/config.txt` exists) | Ollama answers on `http://127.0.0.1:11434/api/version` and the model in config.txt appears in `ollama list` | try starting `ollama serve`; missing model → `ollama pull <model>` only after telling the user it's a download and they say yes |

Checks 7–9 are OPTIONAL features: when absent AND unfixable, report them as
"off" with one upbeat line about what turning them on would add — not as
failures. The card's overall verdict counts only checks 1–6.

## Step 2 — The health card

Print ONE compact card. Shape (adapt to `LANG`, keep it this short):

> **SoulDrop v0.6.0 — health check / kiểm tra sức khỏe**
>
> - ✅ Engine running (Claude Code)
> - ✅ SoulDrop installed
> - 🔧 Documents pack — was missing, reinstalled it
> - ✅ Your profile & memory — safe and intact
> - ✅ Second brain — 42 notes
> - ⚠️ Browsing — off (no Chrome on this machine; install Chrome anytime to unlock it)
>
> **Verdict: all good — nothing for you to do. / Kết luận: mọi thứ ổn — bạn
> không cần làm gì cả.**

Verdict rules: all 1–6 ✅/🔧 → "all good". Any ⚠️ in 1–6 → verdict names the
ONE most important next step in plain words ("run the install command again —
here it is", "type /onboard"), never a list of chores. If you fixed things,
say so in one proud, plain sentence.

## Step 3 — When the engine itself is broken (check 1 fails)

You may be running on a half-broken install. Keep calm, keep it short:
tell them their memories and profile are safe as plain files, and give them
the ONE re-run line for their OS (the same install command from the README) —
re-running is always safe.

Never mention: CLAUDE.md, YAML, frontmatter, MCP, npm, registry keys, exit
codes. Say "profile", "memory", "documents pack", "browsing power" instead.
