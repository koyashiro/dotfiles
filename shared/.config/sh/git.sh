# shellcheck shell=sh

# Aliases
alias g='git'
alias gst='git status'
alias gsts='git status --short'
alias gco='git checkout'
alias gswc='git switch -c'
alias grs='git restore'
alias grs.='git restore .'
alias grss='git restore --staged'
alias grss.='git restore --staged .'
alias gbr='git branch'
alias gdf='git diff'
alias gdfs='git diff --staged'
alias gad='git add'
alias gad.='git add .'
alias gcm='git commit'
alias gcma='git commit --amend'
alias gft='git fetch'
alias grb='git rebase'
alias grbi='git rebase -i'
alias gmg='git merge'
alias gpl='git pull'
alias gps='git push'
alias gl='git log'
alias glp='git log -p'
alias glf='git log --pretty=fuller'
alias glg='git log --grep'
alias gsh='git show'
alias gcp='git cherry-pick'
alias gwsl='git worktree list'

# Scoping convention (POSIX sh has no `local`):
# - Functions that don't change the shell's state wrap their body in a `( )`
#   subshell, so working variables are auto-contained and need no `unset`.
# - Functions that must affect the caller's shell (i.e. `cd`) cannot use a
#   subshell, so they prefix working variables with `_` and `unset` them by
#   hand to avoid leaking into the interactive shell.

# git switch: switch branches.
# No arg -> pick a branch with fzf.
gsw() {
  (
    if [ $# -gt 0 ]; then
      git switch "$@"
      return
    fi
    branch=$(git branch --format='%(refname:short)' | fzf --prompt='SWITCH> ') || return
    [ -z "$branch" ] && return
    git switch -- "$branch"
  )
}

# git branch -d: delete branches. No arg -> pick (multi) with fzf.
gbrd() {
  (
    if [ $# -gt 0 ]; then
      git branch -d "$@"
      return
    fi
    branches=$(_git_pick_branches) || return
    [ -z "$branches" ] && return
    # shellcheck disable=SC2086
    git branch -d -- $branches
  )
}

# git branch -D: force-delete branches. No arg -> pick (multi) with fzf.
gbrD() {
  (
    if [ $# -gt 0 ]; then
      git branch -D "$@"
      return
    fi
    branches=$(_git_pick_branches) || return
    [ -z "$branches" ] && return
    # shellcheck disable=SC2086
    git branch -D -- $branches
  )
}

# git worktree switch: register a branch as a worktree and cd into it.
# No arg -> pick a branch with fzf.
# Cannot use a subshell here because it must `cd` the caller's shell, so the
# working variable is `_`-prefixed and unset by hand (see convention above).
gwsw() {
  _wt=$(_git_worktree_resolve "$@")
  if [ -n "$_wt" ]; then
    cd "$_wt" || true
  fi
  unset _wt
}

# git worktree switch -c: create a branch, register it as a worktree, cd into it.
gwswc() {
  _wt=$(_git_worktree_resolve -c "$@")
  if [ -n "$_wt" ]; then
    cd "$_wt" || true
  fi
  unset _wt
}

# git worktree remove: remove worktrees. No arg -> pick (multi) with fzf.
gwsr() {
  (
    if [ $# -gt 0 ]; then
      git worktree remove "$@"
      return
    fi
    _git_pick_worktrees | while IFS= read -r wt; do
      git worktree remove "$wt"
    done
  )
}

# git worktree remove -f: force-remove worktrees. No arg -> pick (multi) with fzf.
gwsrf() {
  (
    if [ $# -gt 0 ]; then
      git worktree remove -f "$@"
      return
    fi
    _git_pick_worktrees | while IFS= read -r wt; do
      git worktree remove -f "$wt"
    done
  )
}

# Pick local branches (multi) with fzf, excluding the current branch.
_git_pick_branches() {
  current=$(git branch --show-current)
  git branch --format='%(refname:short)' | grep -vFx "$current" | fzf -m --prompt='DELETE> '
}

# Resolve (and create if missing) a worktree for a branch under
# <repo>/.worktrees/<branch>, then print its path. All git/fzf output goes to
# stderr so the path is the only thing on stdout. Pass -c to create the branch.
# With no branch given, pick one with fzf.
_git_worktree_resolve() {
  (
    create=0
    while [ $# -gt 0 ]; do
      case $1 in
        -c)
          create=1
          shift
          ;;
        --)
          shift
          break
          ;;
        *) break ;;
      esac
    done
    branch=$1

    common=$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null) || return 1
    root=$(dirname "$common")

    if [ -z "$branch" ]; then
      if [ "$create" = 1 ]; then
        echo 'branch name required' >&2
        return 1
      fi
      branch=$(git branch --format='%(refname:short)' | fzf --prompt='WORKTREE> ')
      [ -z "$branch" ] && return 1
    fi

    # If the branch is already checked out in a worktree (including the main
    # working tree, e.g. the default branch), just switch into it.
    existing=$(git worktree list --porcelain | awk -v b="refs/heads/$branch" '
      /^worktree / { p = $2 }
      $0 == ("branch " b) { print p; exit }')
    if [ -n "$existing" ]; then
      echo "$existing"
      return 0
    fi

    wtpath=$root/.worktrees/$branch

    if [ ! -d "$wtpath" ]; then
      if [ "$create" = 1 ]; then
        git worktree add -b "$branch" "$wtpath" 1>&2 || return 1
      else
        git worktree add "$wtpath" "$branch" 1>&2 || return 1
      fi
    fi

    echo "$wtpath"
  )
}

# Pick worktree paths (multi) with fzf, excluding the main working tree.
_git_pick_worktrees() {
  git worktree list --porcelain 2>/dev/null \
    | awk '/^worktree / { if (seen) print $2; seen = 1 }' \
    | fzf -m --prompt='REMOVE> '
}
