# Adapter: Ollama (Free tier)

The gem for people with **no subscription**: a personal AI assistant that
runs 100% on their own computer. No account, no cost, private by default.

## How it fulfills the [adapter contract](../README.md)

1. **Install the engine** — official channels only: winget `Ollama.Ollama`
   (Windows), Homebrew (macOS), `https://ollama.com/install.sh` (Linux).
   Then picks a model sized to the machine's RAM — detected automatically:

   | RAM | Model | Note |
   |---|---|---|
   | ≥ 16 GB | `llama3.1:8b` | strong all-rounder (~4.9 GB) |
   | 8–16 GB | `llama3.2:3b` | good lightweight (~2 GB) |
   | < 8 GB | `llama3.2:1b` | smallest usable (~1.3 GB) — honestly labeled "basic" |

   Logic: `Install-OllamaEngine` in `install/go.ps1`,
   `install_ollama_engine` in `install/go.sh`.
2. **Install the brain** — the launcher's FIRST RUN is the onboarding
   interview (six human questions: language, name, work, goal, assistant
   name, personality) → writes `~/souldrop-brain/persona.md`,
   `~/souldrop-brain/memory/`, and the shared `~/second-brain/` vault.
3. **Wire the persona** — every chat turn sends persona + the last 60
   memory lines as the system prompt to the local API (`/api/chat`,
   streaming). Saying "remember ..." appends to the memory bank live.
4. **Report status** — bilingual lines; any failure (no winget, pull fails,
   engine won't start) = one friendly line + pointer to the Pro path.

## Files here

| File | Purpose |
|---|---|
| `souldrop.ps1` | Chat launcher, Windows — PowerShell 5.1-native, zero dependencies, streaming |
| `souldrop.sh` | Chat launcher, macOS/Linux — bash + curl; uses python3 for perfect streaming when present, pure-shell fallback otherwise |

The bootstrap downloads the right launcher to the user's machine
(`%USERPROFILE%\souldrop\` + Desktop shortcut + `souldrop` command on
Windows; `~/.souldrop/` + `~/.local/bin/souldrop` on macOS/Linux).

## Deliberate limits of this tier

- **No skill-forge** — small local models can't reliably author skills.
  Instead, the generic SoulDrop skills' *content* (personal conventions,
  work-smart, memory habits) is folded into the persona itself.
- Honest about model size: the persona instructs the assistant to admit
  hard tasks are beyond it and mention the Pro engine instead of guessing.
