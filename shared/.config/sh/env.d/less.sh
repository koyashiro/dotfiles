# shellcheck shell=sh

# Pager
export PAGER=less

# Less
if [ ! -d "$XDG_CONFIG_HOME"/less ]; then
  mkdir -m 700 "$XDG_CONFIG_HOME"/less
fi
if [ ! -d "$XDG_CACHE_HOME"/less ]; then
  mkdir -m 700 "$XDG_CACHE_HOME"/less
fi
export LESS='-fiMRfFx4X'
export LESSCHARSET='utf-8'
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history

# LESS man page colors (makes Man pages more readable).
LESS_TERMCAP_mb=$(printf "\e[01;31m")
LESS_TERMCAP_md=$(printf "\e[01;31m")
LESS_TERMCAP_me=$(printf "\e[0m")
LESS_TERMCAP_se=$(printf "\e[0m")
LESS_TERMCAP_so=$(printf "\e[00;44;37m")
LESS_TERMCAP_ue=$(printf "\e[0m")
LESS_TERMCAP_us=$(printf "\e[01;32m")
export LESS_TERMCAP_mb
export LESS_TERMCAP_md
export LESS_TERMCAP_me
export LESS_TERMCAP_se
export LESS_TERMCAP_so
export LESS_TERMCAP_ue
export LESS_TERMCAP_us
