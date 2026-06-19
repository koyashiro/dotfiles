#!/bin/sh
# Delete local branches whose upstream is gone, cleaning up their worktrees too.

set -eu

gone=$(git for-each-ref --format '%(refname:short) %(upstream:track)' refs/heads \
  | awk '$2 == "[gone]" { print $1 }')

if [ -n "$gone" ]; then
  # Map of branch -> worktree path (only worktrees with a branch checked out).
  wt=$(git worktree list --porcelain \
    | awk '/^worktree / { p=$2 } /^branch / { sub("refs/heads/","",$2); print $2" "p }')

  for b in $gone; do
    path=$(printf '%s\n' "$wt" | awk -v b="$b" '$1==b { print $2 }')
    if [ -n "$path" ]; then
      if [ -n "$(git -C "$path" status --porcelain)" ]; then
        printf 'skip: %s has uncommitted changes (%s)\n' "$b" "$path" >&2
        continue
      fi
      git worktree remove "$path" || continue
    fi
    git branch -D "$b" || continue
  done
fi

git worktree prune
