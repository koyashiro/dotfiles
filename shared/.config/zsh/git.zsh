# gsw / gwsw / gbrd / gbrD: complete local branch names
_git_local_branches() {
  local -a branches
  branches=("${(@f)$(git branch --format='%(refname:short)' 2>/dev/null)}")
  compadd -a branches
}
compdef _git_local_branches gsw gwsw gbrd gbrD

# gwr / gwrf: complete worktree paths
_git_worktrees() {
  local -a worktrees
  worktrees=("${(@f)$(git worktree list --porcelain 2>/dev/null | awk '/^worktree / { if (seen) print $2; seen = 1 }')}")
  compadd -a worktrees
}
compdef _git_worktrees gwr gwrf
