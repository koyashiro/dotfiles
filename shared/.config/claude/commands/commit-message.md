---
description: Suggest a Conventional Commits message for the current changes
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git log:*)
---

## Context

Status:

!`git status --short`

Diff (staged):

!`git diff --cached`

Diff (unstaged):

!`git diff`

Recent commits (style reference for type/scope/wording):

!`git log --oneline -15`

## Task

Propose a commit message for the diff above.

- Target the staged diff if it is non-empty; otherwise use the unstaged diff.
- Use Conventional Commits format `type(scope): summary` in English.
- Match the existing type/scope conventions and wording seen in the recent commits.
- Add a body only when it adds real value (the "why" or non-obvious context).
- If two or three distinct framings are reasonable, offer them as alternatives.
- Present the message(s) as text only. Do NOT run `git add` or `git commit`.
- If there is no diff, say there are no changes to describe.
