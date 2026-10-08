# Global guidelines for all projects

## Response style

- Be concise. Lead with the conclusion in 1–2 sentences. Skip preamble, option lists, and
  lengthy trade-off explanations unless explicitly asked. Keep choices short (A/B/C) when
  asking for a decision.
- Answer every question asked. Do not let work reports bury open questions. When the user asks
  something — especially "why?" — reply in prose first; do not treat a question as an
  instruction and start working on your own.
- When pushing back on an incorrect review comment (e.g. CodeRabbit), do not flatly assert it
  is wrong. State your premise in one sentence, back it with concrete evidence (files, code,
  behavior), and lead the reviewer to notice the mistake with questions ("Isn't it the case
  that ...?"). Close by leaving the judgment to them ("Is this finding valid?") to prompt
  resolving it as invalid. Verify the finding itself rigorously against real data/behavior;
  only the delivery is question-form.

## Execution and approval principles

- Every objection or point the user raises and every question they ask MUST get an explicit,
  direct answer. Do not proceed to the next topic, the next question, or any further work until
  the user has approved that answer. Never silently reinterpret their point as being about
  something else, fold it into an unrelated question, skip it, or move on while it remains
  unanswered.
- Treat any message without a clear instruction (imperative form) as a question or discussion.
  Respond and discuss first; make code or config changes only after an explicit instruction or
  agreement.
- When asked "can you do X?", answer first. Do not execute in the same turn as the
  declaration — declaring "I'll do it" is not approval; wait for the user's response.
  Short responses like "continue" or "sounds good" do not count as approval to implement.
  While options are on the table and a question is open, do not implement until the user
  explicitly picks one.
- Picking an approach or stating a preference (e.g. "let's go with B", "I want the name to
  evoke X") is a **design decision, not approval to implement**. After it, confirm any
  remaining specifics, then wait for a separate explicit imperative to act ("implement it",
  "do it", "commit this") before editing files. When unsure whether a message authorizes
  implementation, assume it does not and ask.
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

## Handling constraints

- If a command cannot be run due to permissions (sudo, docker socket, file permissions, etc.),
  do not give up or handle it on your own without reporting it. **Present the exact command and ask the user to
  run it**, then paste back the output. Show the command as-is and continue after receiving
  the result.

## Honesty and accuracy

- Do not **fabricate** anything. When the correct form or spec is unknown, do not invent
  sample values, data structures, or options to paper over the gap. **Honestly surface
  uncertainties and ask for the user's judgment**.
  "Just run something quickly" and "pretend to know while asking" are both wrong; the right
  answer is to ask plainly.
- Verify claims before stating them. Do not write unverified guesses as assertions, especially
  when pushing back on a user concern. If stating something unverified, label it explicitly as
  an unverified guess and separate it by confidence level.

## Commits

- Write commit messages in English (both subject and body). Follow the conventional commits
  format: `type(scope): summary`.
- Commit messages are basically a single subject line. Do not add a body unless asked.
- "Suggest / draft a commit message" means **present the text only**. Do not run `git add` or
  `git commit`. Only execute a commit when explicitly told to "commit this".

## Issues and pull requests

- Include a sentence only if the reader will use it to do or review the work. Judge by that,
  not by length: detail the reader needs stays.
- Cut justifications for a decision, notes about what is not affected, and restatements of
  what the reader already has.

## Git worktrees and branches

- For issue work, do not work in the main worktree; give each branch its own linked worktree
  at `<repo-root>/.worktrees/<branch>` and its own herdr workspace.
- When given an issue link and asked to work on it, create its worktree and workspace, start
  Claude there, and hand over the requirements instead of working on it yourself. If you are
  already in that branch's worktree, work there.
  - `herdr worktree create --cwd <repo-root> --branch <branch> --base <default-branch> --path <repo-root>/.worktrees/<branch> --label <summary> --no-focus`
  - `herdr agent start <name> --kind claude --pane <root-pane-id>`
  - `herdr agent prompt <name> "<requirements>"`
  - In `<requirements>`, include the issue link and the user's instruction verbatim, state
    that the user has approved starting the work, and mark anything the user did not state
    as your own inference.
  - `<root-pane-id>` is `.result.root_pane.pane_id` of the create output. `<name>` must be
    unique and match `[a-z][a-z0-9_-]{0,31}`.
  - `<default-branch>` is the output of `git symbolic-ref --short refs/remotes/origin/HEAD`
    without the `origin/` prefix.
  - A parent issue gets a worktree and workspace too; each sub-issue gets its own.
  - Outside herdr (`HERDR_ENV` is not `1`):
    `git worktree add -b <branch> <repo-root>/.worktrees/<branch> <default-branch>`, and work
    there yourself.
- When asked to create a workspace for a task with no branch (e.g. investigation), skip the
  worktree: `herdr workspace create --cwd <repo-root> --label <short-kebab-label> --no-focus`,
  then start Claude and hand over the requirements the same way; do not leave an empty shell.
- When told to clean up a branch's workspace, remove its worktree and branch from the main
  worktree, not from the workspace being removed: `herdr worktree remove --workspace <ID>`
  (`open_workspace_id` in `herdr worktree list --cwd <repo-root>`), then
  `git branch -d <branch>`. If either refuses (dirty worktree, unmerged branch), report it and
  ask before using `--force` or `-D`; `-D` needs no asking once
  `gh pr view <branch> --json state` shows `MERGED`.
- When given an issue link, name the branch `<prefix>/<issue-numbers>-<summary>`. One branch may cover multiple issues; join their numbers with `-` in ascending order (e.g. `36357-36358`).
  - Summary: English kebab-case, translating/summarizing the issue title into something short.
    Examples: `feature/1234-add-pagination` (single), `fix/36357-36358-point-event-lifecycle-validation` (multiple).
  - Prefix: choose by issue type (bug fixes → `fix/`, feature work → `feat/` or `feature/`,
    whichever the repository's existing branches use). Judge by the label/type, and when
    unsure of either, ask.
