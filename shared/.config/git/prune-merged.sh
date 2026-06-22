#!/bin/sh
# Delete local branches already merged into the default branch, including
# squash and rebase merges, cleaning up their worktrees too.

set -eu

# Refresh remote state so squash commits landed on the remote are visible and
# stale remote-tracking refs are dropped.
git fetch --prune --quiet

# Determine the default branch to compare against. Prefer the remote's pointer
# so detection works even when the local default branch is behind.
default=$(git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null | sed 's@^origin/@@') || default=
if [ -z "$default" ]; then
  for c in main master; do
    if git show-ref --verify --quiet "refs/remotes/origin/$c"; then
      default=$c
      break
    fi
  done
fi
if [ -z "$default" ]; then
  for c in main master; do
    if git show-ref --verify --quiet "refs/heads/$c"; then
      default=$c
      break
    fi
  done
fi
if [ -z "$default" ]; then
  echo "prune-merged: cannot determine the default branch" >&2
  exit 1
fi
if git show-ref --verify --quiet "refs/remotes/origin/$default"; then
  target="origin/$default"
else
  target="$default"
fi

# Map of branch -> worktree path (only worktrees with a branch checked out).
wt=$(git worktree list --porcelain \
  | awk '/^worktree / { p=$2 } /^branch / { sub("refs/heads/","",$2); print $2" "p }')

# Branch checked out in the main working tree (cannot be deleted from here).
current=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) || current=

git for-each-ref --format '%(refname:short)' refs/heads | while IFS= read -r b; do
  # Never touch the default branch or the branch we are standing on.
  [ "$b" = "$default" ] && continue
  [ "$b" = "$current" ] && continue

  # Is the branch's content already in the target? Rebuild it as a single
  # commit on top of its merge-base and let git cherry match it by patch-id,
  # which detects squash and rebase merges (plain ancestry would miss them).
  base=$(git merge-base "$target" "$b") || continue
  tree=$(git rev-parse "$b^{tree}") || continue
  tmp=$(git commit-tree "$tree" -p "$base" -m _) || continue
  case "$(git cherry "$target" "$tmp")" in
    -*) ;;         # already merged -> delete
    *) continue ;; # has unmerged changes (or no diff) -> keep
  esac

  # Remove its worktree first, if any, unless it has local changes.
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

git worktree prune
