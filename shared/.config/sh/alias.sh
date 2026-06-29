# shellcheck shell=sh

alias ..='cd ..'
alias renv='. ${XDG_CONFIG_HOME:-$HOME/.config}/sh/env.sh'

# enable color support
if [ -x /usr/bin/dircolors ]; then
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# ls
if command -v eza >/dev/null 2>&1; then
  alias ll='eza -alhg -F always --time-style iso --icons --git'
else
  alias ll='ls -alhAF'
fi

# prompt
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# tmux
alias tmux='tmux -u'
alias t='tmux -u'
alias tsource='tmux source-file'

# neovim
if command -v nvim >/dev/null 2>&1; then
  alias nvimdiff='nvim -d'
fi

# emacs
alias emacs=vim

# tree
if command -v eza >/dev/null 2>&1; then
  alias tree='eza --tree -a --git-ignore --icons --ignore-glob=".git"'
else
  alias tree='tree -a -I "\.git"'
fi

# ripgrep
alias rg='rg --hidden --glob "!.git"'

# sqlite3
alias sqlite3='sqlite3 -init "$XDG_CONFIG_HOME"/sqlite3/sqliterc'

# Docker
alias d=docker

# Docker Compose
alias dc='docker compose'
alias dcb='docker compose build'
alias dcu='docker compose up'
alias dcud='docker compose up --detach'
alias dcd='docker compose down'
alias dcr='docker compose run --rm'
alias dce='docker compose exec'
alias dcp='docker compose pull'
alias dcl='docker compose logs'
alias dclf='docker compose logs --follow --tail 50'

# Kubernetes
alias k='kubectl'
