if ! shopt -oq posix && [[ -f /usr/share/bash-completion/bash_completion ]]; then
  # shellcheck disable=SC1091
  source /usr/share/bash-completion/bash_completion
fi
