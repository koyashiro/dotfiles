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
if command -v exa > /dev/null 2>&1; then
  alias ll='exa -alhFg --time-style iso --icons --git'
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
if command -v nvim > /dev/null 2>&1; then
  alias nvimdiff='nvim -d'
fi

# emacs
alias emacs=vim

# tree
if command -v exa > /dev/null 2>&1; then
  alias tree='exa --tree -a --git-ignore --icons --ignore-glob=".git"'
else
  alias tree='tree -a -I "\.git"'
fi

# ripgrep
alias rg='rg --hidden --glob "!.git"'

# Git
alias g=git
alias gst='git status'
alias gsts='git status --short'
alias gco='git checkout'
alias gsw='git switch'
alias gswc='git switch -c'
alias grs='git restore'
alias grs.='git restore .'
alias grss='git restore --staged'
alias grss.='git restore --staged .'
alias gbr='git branch'
alias gbrd='git branch -d'
alias gdf='git diff'
alias gdfs='git diff --staged'
alias gad='git add'
alias gad.='git add .'
alias gcm='git commit'
alias gcma='git commit --amend'
alias gft='git fetch'
alias grb='git rebase'
alias grbi='git rebase -i'
alias gmg='git merge'
alias gpl='git pull'
alias gps='git push'
alias gl='git log'
alias glp='git log -p'
alias glf='git log --pretty=fuller'
alias glg='git log --grep'
alias gsh='git show'
alias gcp='git cherry-pick'

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
alias dclf='docker compose logs --follow'

# Kubernetes
alias k='kubectl'
