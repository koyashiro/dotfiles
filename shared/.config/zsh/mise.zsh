if ! builtin command -v mise >&/dev/null; then
  return
fi

eval "$(mise activate zsh)"
