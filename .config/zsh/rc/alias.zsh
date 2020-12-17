alias ..='cd ..'

# enable color support
if [[ -x /usr/bin/dircolors ]]; then
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# ls
if builtin command -v exa >& /dev/null; then
  alias ll='exa -alhF --icons'
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

# clear
alias clr=clear

# emacs
alias emacs=vim

# tree
if builtin command -v exa >& /dev/null; then
  alias tree='exa --tree -a --git-ignore --icons --ignore-glob=".git"'
else
  alias tree='tree -a -I "\.git"'
fi

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
if builtin command -v fzf >& /dev/null; then
  alias gbrd='fzf-git-branch-delete'
  alias gsw='fzf-git-switch'
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
