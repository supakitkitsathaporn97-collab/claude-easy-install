---
description: Build (or rebuild) custom skills tailored to your work and goals — automatic, no technical questions / Tạo kỹ năng riêng cho công việc của bạn — tự động
---

Run the `forge-skills` skill from this plugin now, from Step 1:
load the user's profile and memory (never re-interview), derive 3–5
tightly-scoped candidate skills from the domain map + their stated goal,
generate each SKILL.md, run the full quality gate, install only passing
skills to `~/.claude/skills/`, then show the user what was built — in their
language, in plain words, no jargon.

Follow the skill's rules exactly — especially: no technical questions ever,
non-blocking on every failure, never install a skill that fails the gate,
and never overwrite an existing skill without the human-level "refresh it?"
question.
