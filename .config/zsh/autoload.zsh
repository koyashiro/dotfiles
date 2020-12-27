autoload -Uz colors && colors
autoload -Uz run-help
autoload -Uz add-zsh-hook
autoload -Uz compinit && compinit -d "$XDG_DATA_HOME"/zsh/compdump
autoload -Uz is-at-least
