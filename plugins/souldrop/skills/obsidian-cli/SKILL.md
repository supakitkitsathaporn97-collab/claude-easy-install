---
name: obsidian-cli
description: File operations on the user's second-brain vault at ~/second-brain — create, find, move, archive, and maintain notes safely from the terminal. Use when the user asks to add a note, find a note, organize or clean up their vault, "note this down", "ghi chú lại", or references their second brain.
---

# Obsidian CLI — operate the vault safely with file tools

The vault at `~/second-brain` is plain files — use normal file tools (read,
write, glob, grep) on it. No Obsidian app or plugin needed.

## Operations

- **Capture** ("note this down"): write a small file into `00-Inbox/` with a
  descriptive title, formatted per the `obsidian-markdown` skill.
- **Daily note:** `01-Daily/YYYY-MM-DD.md` — append under today's headings;
  create from scratch if missing (pairs with the `daily-note` skill).
- **Find:** search by filename first (fast), then by content across `*.md`.
  Search the whole vault — the user won't know which folder a note is in.
- **Move/organize:** inbox items that matured → `02-Notes/` or
  `03-Projects/`; finished things → `99-Archive/`. Update any `[[wikilinks]]`
  you break by moving (grep for the old title).
- **Vault missing?** If `~/second-brain` doesn't exist, create it silently
  (the `/setup-vault` skeleton) and continue — never block on it.

## Safety rules

- **Never delete a note** — archive to `99-Archive/` instead. Deleting is a
  user-confirmed action only.
- Never touch `.obsidian/` config beyond the initial skeleton — the app owns it.
- Don't rewrite whole notes when appending will do; the user's own words in
  a note are precious — edit around them.
- After any bulk operation (moves, renames), report a one-line summary of
  what changed.
