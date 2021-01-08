export ZDOTDIR="$HOME"/.config/zsh

if [[ -f "$ZDOTDIR"/.zshenv ]]; then
  # shellcheck source=.config/zsh/.zshenv
  source "$ZDOTDIR"/.zshenv
fi
