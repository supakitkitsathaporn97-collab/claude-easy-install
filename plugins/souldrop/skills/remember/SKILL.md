---
name: remember
description: Save a fact, preference, or decision to the user's persistent memory at ~/.claude/memory/ and index it in MEMORY.md. Use when the user says "remember this", "nhớ nhé", "save this", "don't forget", or shares something clearly worth keeping long-term.
---

# Remember — save a fact to memory

Persist one fact so future sessions know it.

## Steps

1. **Distill** the fact to its useful core — what future-you needs, not the
   whole conversation. If the user said "remember I prefer short answers",
   the memory is the preference, not the sentence.
2. **Check for an existing memory** that covers the same topic: scan
   `~/.claude/memory/MEMORY.md` (create the folder + index from scratch if
   missing). If one exists → update THAT file instead of creating a duplicate.
3. **Write** a new small file `~/.claude/memory/<short-kebab-slug>.md`:

   ```markdown
   # <Short title>

   <The fact, 1-5 lines. Concrete. Include dates as absolute dates.>
   ```

4. **Index it**: append one line to the right section of `MEMORY.md`:
   `- [Short title](<slug>.md) — one-line hook`
5. **Confirm** to the user in one short line what was saved (and where, if
   they ask). If it replaced/updated an old memory, say so.

## Rules

- One fact per file. Small files, strong index.
- Never store secrets (passwords, API keys, card numbers) — refuse politely
  and suggest a password manager.
- Convert relative dates ("next Friday") to absolute dates before saving.
