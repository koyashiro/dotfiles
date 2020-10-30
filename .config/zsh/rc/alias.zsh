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
alias t='tmux -u'
alias tsource='tmux source-file'

# clear
alias clr=clear

# Neovim
type nvim >/dev/null 2>&1 && alias vim=nvim

# emacs
alias emacs=vim

# tree
alias tree='tree -a -I "\.git"'

# Git
alias g=git

# Docker
alias d=docker

# Docker Compose
alias dc=docker-compose
