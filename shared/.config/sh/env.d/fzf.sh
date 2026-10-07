# shellcheck shell=sh

if command -v fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_OPTS='--height 50% --reverse --border'
  if command -v rg >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
  fi
fi
