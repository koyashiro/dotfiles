function fzf-git-switch() {
  if [[ $# -ne 0 ]]; then
    git switch "$@"
    return
  fi

  local -r branches=$(git branch | grep -v '\*')
  local -r selected=$(echo $branches | fzf --prompt='SWITCH> ' | cut -b 3-)

  if [[ -z "$selected" ]]; then
    return
  fi

  git switch $selected
}

function fzf-git-branch-d() {
  if [[ $# -ne 0 ]]; then
    git branch -d "$@"
    return
  fi

  local -r branches=$(git branch | grep -v '\*')
  local -r selected=$(echo $branches | fzf --prompt='DELETE> ' | cut -b 3-)

  if [[ -z "$selected" ]]; then
    return
  fi

  git branch -d $selected
}
