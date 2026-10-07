if ! command -v direnv >/dev/null 2>&1; then
  return
fi

eval "$(direnv hook bash)"
