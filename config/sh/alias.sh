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
if command -v exa >/dev/null 2>&1; then
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

# emacs
alias emacs=vim

# tree
if command -v exa >/dev/null 2>&1; then
  alias tree='exa --tree -a --git-ignore --icons --ignore-glob=".git"'
else
  alias tree='tree -a -I "\.git"'
fi

# ripgrep
alias rg='rg --hidden --glob "!.git"'

# Git
alias g=git
alias gst='git status'
alias gad='git add'
alias gad.='git add .'
alias gcm='git commit'
alias gcma='git commit --amend'
alias grs='git restore'
alias grs.='git restore .'
alias grss='git restore --staged'
alias grss.='git restore --staged .'
alias grb='git rebase'
alias grbi='git rebase -i'
alias gbr='git branch'
if command -v fzf >/dev/null 2>&1; then
  alias gbrd='fzf_git_branch_delete'
  alias gsw='fzf_git_switch'
else
  alias gbrd='git branch -d'
  alias gsw='git switch'
fi
alias gswc='git switch -c'
alias gdf='git diff'
alias gdfs='git diff --staged'
alias gsh='git show'
alias gl='git log'
alias glp='git log -p'
alias glf='git log --pretty=fuller'
alias glg='git log --grep'
alias gft='git fetch'
alias gftrb='git fetch && git rebase'
alias gpl='git pull'
alias gps='git push'

# Docker
alias d=docker

# Docker Compose
alias dc=docker-compose
