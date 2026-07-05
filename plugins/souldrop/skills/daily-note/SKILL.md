---
name: daily-note
description: Simple daily journal — create or append to today's note in ~/.claude/memory/journal/. Use when the user says "daily note", "journal this", "ghi nhật ký", "log today", or wants to jot down what happened or plan the day.
---

# Daily note — a simple journal

## Steps

1. Get today's real date (run a date command — never guess).
2. The note lives at `~/.claude/memory/journal/YYYY-MM-DD.md`
   (create the `journal/` folder on first use).
3. If today's file doesn't exist, create it:

   ```markdown
   # YYYY-MM-DD (Weekday)

   ## Notes

   ## Done

   ## Tomorrow
   ```

4. **Append** the user's entry under the fitting section with a `- HH:MM` time
   prefix. Never rewrite or reorder earlier entries — a journal is append-only.
5. Confirm in one short line.

## Extras (on request only)

- "What did I do this week?" → read the last 7 daily files and summarize.
- End-of-day recap → offer one line for "Done" and one for "Tomorrow".
- If something in the note is clearly a long-term fact ("switched my main
  project to X"), offer to save it properly with the `remember` skill too.
