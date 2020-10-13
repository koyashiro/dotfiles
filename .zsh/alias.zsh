alias ..='cd ..'

# enable color support
if [ -x /usr/bin/dircolors ]; then
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ls
alias ll='ls -alhAF'

# prompt
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# tmux
alias tmux='tmux -u'

# clear
alias clr=clear

# Neovim
type nvim >/dev/null 2>&1 && alias vim=nvim

# emacs
alias emacs=vim

# Git
alias g=git

# Docker
alias d=docker

# Docker Compose
alias dc=docker-compose

# Python
alias python=python3
alias pip=pip3
