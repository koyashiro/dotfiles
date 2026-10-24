autoload -Uz colors && colors
autoload -Uz run-help
autoload -Uz add-zsh-hook
if [[ ! -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" ]]; then
  mkdir -m 700 "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
fi
autoload -Uz compinit && compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compdump"
autoload -Uz is-at-least
