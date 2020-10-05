autoload -Uz colors && colors

autoload -Uz run-help

autoload -Uz add-zsh-hook

autoload -Uz compinit && compinit -u
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

autoload -Uz is-at-least

setopt auto_cd
