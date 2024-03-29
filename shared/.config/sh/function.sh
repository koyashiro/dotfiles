# shellcheck shell=sh

fzf_git_switch() {
  (
    if [ $# -ne 0 ]; then
      git switch "$@"
      return
    fi

    branches=$(git branch | grep -v '\*')
    selected=$(echo "$branches" | fzf --prompt='SWITCH> ' | cut -b 3-)

    if [ -z "$selected" ]; then
      return
    fi

    git switch "$selected"
  )
}

fzf_git_branch_delete() {
  (
    if [ $# -ne 0 ]; then
      git branch -d "$@"
      return
    fi

    branches=$(git branch | grep -v '\*')
    selecteds=$(echo "$branches" | fzf -m --prompt='DELETE> ' | cut -b 3-)

    if [ -z "$selecteds" ]; then
      return
    fi

    # shellcheck disable=SC2086
    git branch -d $selecteds
  )
}

pull_all_docker_image() {
  docker images | tail -n +2 | awk -v 'OFS=:' '{print $1,$2}' | xargs -P0 -L1 docker pull
}
