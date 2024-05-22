if command -v rustup &>/dev/null; then
  source <(rustup completions zsh)
fi

if command -v docker &>/dev/null; then
  source <(docker completion zsh)
fi

if command -v aqua &>/dev/null; then
  source <(aqua completion zsh)
fi

if command -v volta &>/dev/null; then
  source <(volta completions zsh)
fi
