# XDG Base Directory Specification
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# DOTDIR
export DOTDIR=$([[ -f ~/.dotdir ]] && cat $HOME/.dotdir || echo $HOME/.dotfiles)

# LANGUAGE
export LANGUAGE=ja_JP.UTF-8
export LANG="$LANGUAGE"
export LC_ALL="$LANGUAGE"
export LC_CTYPE="$LANGUAGE"

# Editor
export EDITOR="$(builtin command -v nvim >/dev/null && echo 'nvim' || echo 'vim')"
export CVSEDITOR="$EDITOR"
export SVN_EDITOR="$EDITOR"
export GIT_EDITOR="$EDITOR"

# Pager
export PAGER=less

# Less
export LESS='-fiMRfx4X'
export LESSCHARSET='utf-8'
export LESSKEY=$XDG_CONFIG_HOME/less/lesskey
export LESSHISTFILE=$XDG_CACHE_HOME/less/history

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[00;44;37m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# bin
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/bin:$PATH"
export PATH

# History file and its size
export HISTFILE=$XDG_DATA_HOME/sh/history
export HISTSIZE=1000000
export SAVEHIST=1000000

export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export CARGO_HOME=$XDG_DATA_HOME/cargo
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export DOCKER_CONFIG=$XDG_CONFIG_HOME/docker

# wsl
[[ is_wsl ]] && source $XDG_CONFIG_HOME/wsl/profile
