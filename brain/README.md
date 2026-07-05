# The SoulDrop Brain — one brain, many engines

> **The brain is plain markdown — engines are interchangeable.**
> Não bộ là markdown thuần — động cơ AI nào cũng thay được.

SoulDrop separates **who your assistant is** (the brain) from **what runs it**
(the engine). The brain is nothing but plain-text markdown files on your own
disk. Swap the engine — Claude Code, local Ollama, or a future one — and the
same assistant wakes up: same name, same personality, same memories, same notes.

## The portable format (three parts)

| Part | What it is | Written by |
|---|---|---|
| **Persona** | One markdown file: the assistant's name, personality, language, who you are, your goal, and its behavior rules | The onboarding interview |
| **Memory bank** | A folder of markdown files, one fact per line, timestamped — the assistant's long-term memory | Onboarding + "remember ..." in chat |
| **Second brain** | An Obsidian-compatible note vault (Inbox / Daily / Notes / Projects / People / Resources / Archive) | Onboarding; grows with use |

## Where each engine keeps it

| | Persona | Memory bank | Second brain |
|---|---|---|---|
| **Claude Code (Pro)** | `~/.claude/CLAUDE.md` | `~/.claude/memory/` | `~/second-brain/` |
| **Ollama (Free)** | `~/souldrop-brain/persona.md` | `~/souldrop-brain/memory/` | `~/second-brain/` |

The second brain is **already shared** between engines. Persona + memory live
in each engine's native home today; a sync/migrate step between engine homes
is planned for v0.5 alongside the next adapters (Codex, Antigravity, OpenClaw).

## Rules of the brain

1. **Plain markdown only.** No databases, no proprietary formats, no lock-in.
   You can read every file yourself, edit it, back it up, or move it to a new
   machine by copying folders.
2. **The persona is the soul.** An engine must load it as its system prompt /
   profile before anything else.
3. **Memory is append-only.** New facts are added with a date; nothing is
   silently rewritten. Corrections are new lines.
4. **Never delete a brain.** Re-onboarding backs up the old persona first
   (`persona.md.<timestamp>.bak` on the free tier, backup-then-merge on Pro).
5. **Private by default.** The brain stays on your machine. No engine may
   upload it anywhere as part of SoulDrop.

## Templates

`templates/persona.md.tmpl` is the canonical persona shape every adapter's
onboarding must produce (the Claude adapter's richer `CLAUDE.md.tmpl` in
`plugins/souldrop/skills/onboard/templates/` is a superset of it).
