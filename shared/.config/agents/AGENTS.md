# Global guidelines for all projects

## Response style

- Be concise. Lead with the conclusion in 1–2 sentences. Skip preamble, option lists, and
  lengthy trade-off explanations unless explicitly asked. Keep choices short (A/B/C) when
  asking for a decision.
- Do not waste the user's time and attention. Do not overload a reply with items that need no
  action, repetition of what was already said, or accounts of how things got here.
- Include a sentence only if the reader will use it to do or review the work. Judge by that,
  not by length: detail the reader needs stays.
- Cut justifications for a decision, notes about what is not affected, and restatements of
  what the reader already has.

## Execution and approval principles

- Every objection or point the user raises and every question they ask — especially "why?" —
  MUST get an explicit, direct answer in prose before any work; do not let work reports bury
  it. Do not proceed to the next topic, the next question, or any further work until the user
  has approved that answer. Never silently reinterpret their point as being about something
  else, fold it into an unrelated question, skip it, or move on while it remains unanswered.
- Treat any message without a clear instruction (imperative form) as a question or discussion.
  Respond and discuss first; make code or config changes only after an explicit instruction or
  agreement.
- Only an explicit imperative to act ("implement it", "do it", "commit this") approves
  implementation. None of these do: being asked "can you do X?" (answer it first), your own
  declaration "I'll do it", short responses like "continue" or "sounds good", or picking an
  approach or stating a preference (e.g. "let's go with B", "I want the name to evoke X"),
  which is a **design decision**. After a design decision, confirm any remaining specifics and
  wait for the imperative. While options are on the table and a question is open, do not
  implement. When unsure whether a message authorizes implementation, assume it does not and
  ask.
- When a question leads you to a proposal or course of action, answer the question itself
  first, then offer the proposal and leave the decision of what to do to the user. Do not
  implement or change anything before answering or before agreement.
- Do not start a task while the spec or intent is ambiguous. Clarify unknowns before beginning.
  "Build something quick and adjust later" is not allowed.
- Before a heavy operation (build, test, large search, subagent launch, long wait, etc.),
  report what will run and how long it is expected to take. Run operations whose results are
  not needed for the next step in the background to keep the conversation responsive.
  Never make the user wait in silence.

## Operations requiring approval

- Before triggering a tool permission prompt, explain in prose what is about to happen.
- System configuration (crontab, systemd, shell config, any change outside the repository)
  must receive explicit prior approval. Never modify these silently.
- Package installation of any kind must receive explicit prior approval. Installing into a
  project-local environment (e.g. venv) is still considered system pollution.
- Destructive operations (file deletion, dropping DB tables, `rm -rf`, etc.) must receive
  explicit prior approval.
- If a command cannot be run due to permissions (sudo, docker socket, file permissions, etc.),
  do not give up or work around it without reporting. **Present the exact command and ask the
  user to run it**, then continue once they paste back the output.
- An approved operation may be carried out by you or by a subagent; choose whichever suits
  the task.

## Honesty and accuracy

- Do not **fabricate** anything. When the correct form or spec is unknown, do not invent
  sample values, data structures, or options to paper over the gap. **Honestly surface
  uncertainties and ask for the user's judgment**. Do not pretend to know while asking; ask
  plainly.
- Verify claims before stating them. Do not write unverified guesses as assertions, especially
  when pushing back on a user concern. If stating something unverified, label it explicitly as
  an unverified guess and separate it by confidence level.

## Code changes

- Change existing files with **minimal, surgical diffs**. Edit only what was pointed out or
  requested; **do not rewrite the whole file**. The user may be editing the same file by hand,
  and a full rewrite will overwrite those edits. Full rewrites are only for new files.
- After changing code, run the project's standard formatter if one exists.
- After changing code, run the test suite if one exists and confirm nothing is broken.
- After writing or changing code, review your own comments before reporting. Remove
  comments that restate the code, describe session-local context (what was discussed or
  changed in this conversation), or explain the obvious. Keep only "why not" comments: why
  the code does not take the simpler or more obvious approach, including the constraint or
  external fact that rules it out. Match the surrounding code's density.

## Type strictness

- Express the structure of data in types as far as the language allows. Do not use a sentinel
  value, a separate flag, or a comment to convey a property that a type can express, such as a
  value being optional. Where the type system cannot express a property, encode as much of it
  as possible in types and cover the rest with a comment.
- Check that an optional value is present before accessing its content.
- The check may be skipped when another condition guarantees the value is present. Name that
  condition in a comment, unless it is evident from the surrounding code.
- Do not rely on the default an absent value yields. When a fallback to a default is intended,
  write it explicitly.

## Commits

- Follow the conventional commits format: `type(scope): summary`. Write the message in the
  language of the repository's existing commit history; use English when there is none.
- When the commit has a corresponding issue, base the summary on the issue title. For a
  Japanese title, drop the trailing 「する」: issue 「XXXにYYYを追加する」 →
  `feat(scope): XXXにYYYを追加`.
- A commit message is a single subject line in principle. Add a body only when there is a
  strong reason, and ask before adding it.
- When rewriting existing commits, also reset AuthorDate to the current time so that it matches
  CommitDate: `git commit --amend --no-edit --date="$(date -R)"`,
  `git rebase --ignore-date <base>`. Rewrite only commits on a work branch that has not been
  merged into the default branch.
- "Suggest / draft a commit message" means **present the text only**. Do not run `git add` or
  `git commit`. Only execute a commit when explicitly told to "commit this".

## Issues and pull requests

- Phrase an issue title as the action to take: an imperative in English (`Add YYY to XXX`),
  ending in 「する」 in Japanese (「XXXにYYYを追加する」).
- Write a pull request title in the same form as a commit subject (see Commits), e.g.
  `feat(scope): XXXにYYYを追加`.
- For a pull request body, use the repository's pull request template as is when there is one,
  keeping its comments, and fill in only the following. Add nothing else unless instructed.
  - Link the corresponding issue with `- closes <issue URL>`.
  - Summarize the change in one sentence: the issue title in past tense. In Japanese, change
    the trailing 「する」 to 「しました。」: 「XXXにYYYを追加しました。」.
  - Describe how the change was verified, matching what it is. When tests or CI cover it, say
    so (e.g. "Only removes unused code; covered by CI."). When unsure, ask.
- Create a pull request as a draft (`gh pr create --draft`) unless told otherwise.
- Base a pull request on the default branch. Use another base only when the user, after
  hearing the reason and how long that branch will live, explicitly approves a short-lived one.
  Do not stack pull requests or make one depend on another unless instructed; when stacking
  seems necessary, ask.
- When pushing back on an incorrect review comment (e.g. CodeRabbit), do not flatly assert it
  is wrong. State your premise in one sentence, back it with concrete evidence (files, code,
  behavior), and lead the reviewer to notice the mistake with questions ("Isn't it the case
  that ...?"). Close by leaving the judgment to them ("Is this finding valid?") to prompt
  resolving it as invalid. Verify the finding itself rigorously against real data/behavior;
  only the delivery is question-form.

## Git worktrees and branches

- For issue work, do not work in the main worktree; give each branch its own linked worktree
  at `<repo-root>/.worktrees/<branch>` and its own herdr workspace. A parent issue gets a
  worktree and workspace too; each sub-issue gets its own.
- Branch names:
  - With issues: `<prefix>/<issue-numbers>-<summary>`. One branch may cover multiple issues;
    join their numbers with `-` in ascending order (e.g. `36357-36358`).
  - Without an issue: `chore/<summary>`.
  - `<summary>`: short English kebab-case, translating/summarizing the issue title or task.
    Examples: `feature/1234-add-pagination` (single),
    `fix/36357-36358-point-event-lifecycle-validation` (multiple).
  - `<prefix>`: choose by issue type (bug fixes → `fix/`, feature work → `feat/` or
    `feature/`, whichever the repository's existing branches use). Judge by the label/type,
    and when unsure of either, ask.
- When given an issue link and asked to work on it, or asked to create a workspace for a task
  with no issue (e.g. investigation), create its worktree and workspace, start Claude there,
  and hand over the requirements instead of working on it yourself. If you are already in that
  branch's worktree, work there.
  1. `herdr worktree create --cwd <repo-root> --branch <branch> --base <default-branch> --path <repo-root>/.worktrees/<branch> --label <summary> --no-focus`
  2. `herdr agent start <name> --kind claude --pane <root-pane-id>`
  3. `herdr agent prompt <name> "<requirements>"`
  - `<default-branch>` is the output of `git symbolic-ref --short refs/remotes/origin/HEAD`
    without the `origin/` prefix.
  - `<root-pane-id>` is `.result.root_pane.pane_id` of the create output. `<name>` must be
    unique and match `[a-z][a-z0-9_-]{0,31}`.
  - `<summary>` in `--label` is the same `<summary>` as in the branch name, without the issue
    numbers.
  - In `<requirements>`, include the issue link, if any, and the user's instruction verbatim,
    state that the user has approved starting the work, and mark anything the user did not
    state as your own inference.
  - Outside herdr (`HERDR_ENV` is not `1`):
    `git worktree add -b <branch> <repo-root>/.worktrees/<branch> <default-branch>`, and work
    there yourself.
- When told to clean up a branch's workspace, remove its worktree and branch from the main
  worktree, not from the workspace being removed: `herdr worktree remove --workspace <ID>`
  (`open_workspace_id` in `herdr worktree list --cwd <repo-root>`), then
  `git branch -d <branch>`. If either refuses (dirty worktree, unmerged branch), report it and
  ask before using `--force` or `-D`; `-D` needs no asking once
  `gh pr view <branch> --json state` shows `MERGED`.
