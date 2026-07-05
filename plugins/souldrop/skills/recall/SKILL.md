---
name: recall
description: Find and use facts from the user's persistent memory at ~/.claude/memory/. Use when the user asks "what did I tell you about...", "do you remember...", "bạn còn nhớ...", or when a task clearly depends on previously saved preferences or decisions.
---

# Recall — find it in memory

## Steps

1. **Index first**: read `~/.claude/memory/MEMORY.md` and scan the one-line
   hooks for matches. This is usually enough to find the right file.
2. **Open only the matching file(s)** — not the whole folder.
3. If the index has no match, grep the memory folder for a keyword before
   concluding it isn't there.
4. **Answer with the fact**, and mention when it was saved if the file says.
   If the memory might be stale (old date, changed circumstances), say so and
   offer to update it.
5. If nothing is found: say plainly "I don't have that saved" and offer to
   remember it now (use the `remember` skill).

## Rules

- Memory reflects what was true when written — verify before acting on
  anything time-sensitive.
- Never fabricate a memory. "Not saved" is a valid answer.
