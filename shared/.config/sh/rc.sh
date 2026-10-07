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
alias ll='ls -alhAF'

# prompt
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# tree
alias tree='tree -a -I "\.git"'

# Apps
for f in "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/rc.d/*.sh; do
  # shellcheck disable=SC1090
  [ -f "$f" ] && . "$f"
done
unset f
