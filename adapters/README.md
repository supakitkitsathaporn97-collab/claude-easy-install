# SoulDrop adapters — one brain, many engines

An **adapter** is the per-engine install-and-wire layer. The brain
([`../brain/`](../brain/README.md)) is engine-independent; an adapter makes
one specific engine run it.

## Current engines

| Adapter | Tier | Status |
|---|---|---|
| [`claude-code/`](claude-code/) | Pro — smartest, needs a paid Claude plan | ✅ shipped (v0.1) |
| [`ollama/`](ollama/) | Free — 100% local, no account | ✅ shipped (v0.4) |
| `codex/` | — | 🔜 planned (v0.5) |
| `antigravity/` | — | 🔜 planned (v0.5) |
| `openclaw/` | — | 🔜 planned (v0.5) |

## The adapter contract

Every adapter MUST do these four things, in this order, and every future
adapter slots in by doing the same — no restructuring needed:

1. **Install the engine** — via the engine's OFFICIAL channel only (we never
   re-host binaries). Silent where possible; no admin rights if avoidable.
2. **Install the brain** — ensure the three brain parts exist (persona,
   memory bank, second-brain vault). If they don't, run the onboarding
   interview (human questions ONLY: name, work, goal, assistant name,
   personality, language — never a technical question).
3. **Wire the persona** — make the engine load the persona as its system
   prompt / profile on every session, plus the memory bank.
4. **Report status** — print clear bilingual (EN/VI) OK / skipped / failed
   lines. Failures are NON-BLOCKING: one friendly line + a pointer to
   another engine path, never a raw stack trace, never a stuck beginner.

Iron rules inherited from SoulDrop itself: everything automatic, zero
technical questions, non-blocking fallbacks, no secrets in the repo,
never delete a user's brain (back up first).

## Where the adapter logic lives today

The one-paste bootstraps (`install/go.ps1`, `install/go.sh`) stay
**self-contained** on purpose — a beginner pipes ONE file, and a second
download is a second failure point. So today:

- **Engine auto-detect** (Claude present → Pro; else one Free/Pro question)
  lives at the bottom of `go.ps1` / `go.sh`.
- The **claude-code adapter** logic = `Install-ClaudeEngine` /
  `install_claude_engine` inside the bootstraps (documented in
  [`claude-code/README.md`](claude-code/README.md)); its brain-wiring is the
  `souldrop` plugin (`/onboard`).
- The **ollama adapter** logic = `Install-OllamaEngine` /
  `install_ollama_engine` inside the bootstraps, plus the chat launchers
  that live HERE: [`ollama/souldrop.ps1`](ollama/souldrop.ps1) and
  [`ollama/souldrop.sh`](ollama/souldrop.sh) (downloaded onto the user's
  machine at install time).

At v0.5, when a third engine lands, the engine functions get extracted from
the bootstraps into `adapters/<engine>/install.{ps1,sh}` modules that the
bootstraps fetch — the contract above is written so that split is mechanical.
