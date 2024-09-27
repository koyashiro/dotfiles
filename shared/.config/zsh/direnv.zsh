if ! builtin command -v direnv >&/dev/null; then
  return
fi

eval "$(direnv hook zsh)"
