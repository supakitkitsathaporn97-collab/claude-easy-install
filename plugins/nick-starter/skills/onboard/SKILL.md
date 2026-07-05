---
name: onboard
description: Guided interview (English, Tiếng Việt, ไทย, 한국어, 中文 — or any language the user names) that creates the user's own personalized AI assistant — asks their name, goals, the assistant's name and personality, then writes ~/.claude/CLAUDE.md and a memory scaffold. Use when the user types /onboard, asks to "set up my assistant", "create my AI", "tạo trợ lý", "cài đặt trợ lý", "สร้างผู้ช่วย", "어시스턴트 만들기", "创建助手", or when they appear to be brand new with no personalized CLAUDE.md.
---

# Onboard — build the user's personal AI assistant

You are about to run a short, friendly interview and then **write real files** that
turn this generic Claude Code install into the user's own named, personalized
assistant with persistent memory.

Golden rules for this whole flow:

- **Never invent facts.** Only write what the user actually answered.
- **Never overwrite anything without explicit confirmation** (Step 1 handles this).
- Use the `AskUserQuestion` tool for every question that has natural options
  (max 4 options per question; free-text "Other" is added automatically).
- Keep it warm and simple — the user is very likely a complete beginner.
  No jargon. Never mention "CLAUDE.md" or "frontmatter" during the interview;
  say "your assistant's profile" instead.
- One question round at a time. Do not dump all questions at once.

## Step 0 — Language gate (ALWAYS FIRST)

Supported interview languages: **English** and **Tiếng Việt** (primary), plus
**ไทย, 한국어, 中文** (fully supported) — and any other language the user names.

Ask with `AskUserQuestion` (options cap at 4, so the gate is two-tier):

> Question: "Which language would you like to use? / Bạn muốn dùng tiếng nào? /
> คุณอยากใช้ภาษาอะไร? / 어떤 언어를 사용하시겠어요? / 你想使用哪种语言?"
> Options: "English", "Tiếng Việt", "ไทย · 한국어 · 中文 …"

- If they pick the third option, ask one follow-up `AskUserQuestion`:
  Options: "ไทย", "한국어", "中文". The automatic free-text "Other" (on either
  question) covers any other language — ask them to name it if unclear, then
  proceed in it. Whatever language they type via "Other" IS the answer.

Set **`LANG` = the chosen language**. From here on, everything happens in
`LANG`: every question, every option label, the preview, the generated profile,
and the first greeting. Treat `LANG` as a single clean variable — there are no
per-language branches in the flow itself.

The English strings written in this file are canonical. For Tiếng Việt, ไทย,
한국어, and 中文, load `templates/i18n.md` (relative to this skill's directory)
after the gate and use the matching block as your base wording. For any other
language, translate the English strings naturally — same warmth, never
word-for-word.

## Step 1 — Safety check on existing setup

Check whether `~/.claude/CLAUDE.md` already exists (home directory: `$HOME` on
Mac/Linux, `%USERPROFILE%` on Windows — resolve it, don't guess).

- If it does NOT exist → continue to Step 2.
- If it EXISTS → read it. Then ask with `AskUserQuestion`:
  - "You already have an assistant profile. What would you like to do?"
  - Options:
    1. **Start fresh (keep a backup)** — back up the old file to
       `~/.claude/CLAUDE.md.backup-YYYY-MM-DD-HHmm` first, then replace it.
    2. **Update it** — run the interview, then merge: keep any custom sections
       the user added, replace the identity/personality/goals sections.
    3. **Cancel** — stop, change nothing, tell them how to re-run (`/onboard`).
- Never delete the old file. Backups always.

## Step 2 — The interview

Run these rounds with `AskUserQuestion`, in order. `AskUserQuestion` supports up
to 4 questions per call — group them as shown (2 calls + 1 free-text ask), so the
interview feels quick, not like a form.

**Round A — about the user** (one AskUserQuestion call, 2 questions):

1. *Your name* — has no natural options, so ask it as plain free text BEFORE the
   call, or as an "Other"-driven question with example options. Prefer plain
   conversation: "First — what should your assistant call you?"
2. *What do you mainly want help with?* (multiSelect: true)
   - Options: "Work & documents", "Content & social media", "Coding & tech",
     "Study & research" (+ Other for anything else, e.g. business, personal life)
3. *How should your assistant talk to you?*
   - Options: "Short & direct", "Friendly & warm", "Professional & formal",
     "Playful & fun"

**Round B — about the assistant** (free text + one AskUserQuestion call):

4. *Name your assistant* — plain free text: "Now the fun part — give your
   assistant a name. Anything you like." If they can't decide, offer 3 varied
   suggestions but never pick for them.
5. *Main jobs* (multiSelect: true) — "What should NAME own as its main jobs?"
   - Options tailored from their Round A answers, e.g.: "Draft & polish writing",
     "Research & summarize", "Organize files & plans", "Debug & explain code"
6. *Reply language* —
   - Options: `LANG` (the interview language — skip this option if `LANG` is
     English), "English", "Match whatever language I write in"

If any answer is unclear, ask one short follow-up. Do not re-ask what they
already told you.

## Step 3 — Generate the files

Read the template at `templates/CLAUDE.md.tmpl` (relative to this skill's
directory) and fill every `{{placeholder}}` from the interview answers. Rules:

- Write the profile in `LANG` (the interview language). Fill
  `{{reply_language}}` with the Round B answer — the profile must record the
  chosen reply language and instruct the assistant to reply in it by default.
- Personality section must reflect their communication choice with 3-4 concrete
  behavioral lines (e.g. "Short & direct" → "Concise by default. No filler, no
  flattery. Expand only when asked.").
- Capabilities section lists ONLY the jobs they selected, one line each with a
  concrete example of how the assistant helps.
- Do not add capabilities, rules, or personality traits they didn't ask for.

Write these files:

1. `~/.claude/CLAUDE.md` — the filled profile (respecting the Step 1 choice:
   fresh-with-backup, or merge).
2. `~/.claude/memory/MEMORY.md` — from `templates/MEMORY.md.tmpl`. If it already
   exists, leave it alone and only append the new index line from step 3.
3. `~/.claude/memory/about-me.md` — the first real memory: a short file recording
   the interview answers (their name, goals, preferences, assistant name, date).
   Add one index line for it to `MEMORY.md`.

## Step 4 — Preview & confirm

BEFORE writing `~/.claude/CLAUDE.md`, show the user a short preview:
the assistant's name, personality summary, its main jobs, and reply language —
in plain words, not raw file contents (offer to show the full file if they want).

Ask with `AskUserQuestion`: "Shall I save this?" — Options: "Yes, save it",
"Change something" (loop back to just the part they want changed), "Cancel".

Only write files after "Yes".

## Step 5 — First hello

After saving, greet the user **as their new assistant, by its new name, in their
chosen language, in its chosen personality**. Example shape (adapt, don't copy):

> "Xin chào Minh, mình là Linh 👋 Từ giờ mình là trợ lý riêng của bạn.
> Mình sẽ giúp bạn viết nội dung và tóm tắt tài liệu. Cứ nói chuyện với mình
> như bình thường — mình nhớ được những gì quan trọng. Bắt đầu nhé?"

Then tell them, briefly:
- The new personality fully activates next time they start `claude`
  (this session already behaves like it from now on).
- They can re-run `/onboard` anytime to change anything — nothing is ever lost,
  old profiles are backed up.
- Useful starter commands: `/remember` (save a fact), `/recall` (find one),
  `/daily-note` (journal today).

## Re-running

This skill is fully re-runnable. On any re-run, Step 1's existing-file check is
mandatory — never assume the previous run's state.
