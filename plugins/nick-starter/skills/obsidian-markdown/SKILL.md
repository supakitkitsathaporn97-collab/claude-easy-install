---
name: obsidian-markdown
description: Obsidian-flavored markdown conventions for writing notes in the user's second-brain vault — wikilinks, tags, frontmatter, callouts. Use whenever writing or editing notes inside ~/second-brain, or when the user mentions Obsidian, wikilinks, "link my notes", or their vault.
---

# Obsidian Markdown — write notes the vault understands

When writing into `~/second-brain` (or any Obsidian vault), use Obsidian's
dialect so notes connect instead of piling up.

## Conventions

- **Wikilinks:** link related notes with `[[Note title]]` — Obsidian builds
  the graph from these. Link liberally; a link to a note that doesn't exist
  yet is fine (it marks something worth writing).
  - Link to a section: `[[Note title#Heading]]` · alias: `[[Note|shown text]]`
- **Tags:** `#tag` inline or in frontmatter. Few and consistent beats many:
  reuse tags that already exist in the vault (grep before inventing).
- **Frontmatter** (optional, top of file):

  ```yaml
  ---
  tags: [project, client-x]
  created: 2026-07-05
  ---
  ```

- **Callouts** for emphasis: `> [!note]`, `> [!tip]`, `> [!warning]` —
  first line after `>` is the title.
- **Embeds:** `![[Other note]]` shows another note inline; `![[image.png]]`
  for attachments (attachments live in `05-Resources/attachments`).

## Placement rules (matches the vault skeleton)

- Quick capture → `00-Inbox/` · daily notes → `01-Daily/YYYY-MM-DD.md`
- Evergreen ideas → `02-Notes/` · projects → `03-Projects/<project>.md`
- People → `04-People/<name>.md` · references/links → `05-Resources/`
- Done/retired → move to `99-Archive/`, don't delete.

## Style

- One idea per note, descriptive title (the title IS the link text).
- Start each note with one plain sentence saying what it is.
- End with a `Related: [[a]] · [[b]]` line when relatives exist.
- Filenames: the note title as typed (Obsidian allows spaces); avoid
  `/ \ : * ? " < > |`.
