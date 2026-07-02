if command -v rustup &>/dev/null; then
  source <(rustup completions zsh)
fi

if command -v docker &>/dev/null; then
  source <(docker completion zsh)
fi

if command -v mise &>/dev/null; then
  source <(mise completion zsh)
fi
