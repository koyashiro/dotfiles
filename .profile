# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share

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
if [ ! -d "$XDG_CONFIG_HOME"/less ]; then
  mkdir "$XDG_CONFIG_HOME"/less
fi
if [ ! -d "$XDG_CACHE_HOME"/less ]; then
  mkdir "$XDG_CACHE_HOME"/less
fi
export LESS='-fiMRfFx4X'
export LESSCHARSET='utf-8'
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[00;44;37m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# bin
PATH="$HOME"/.local/bin:"$PATH"
PATH="$XDG_DATA_HOME"/docker/bin:"$PATH"
PATH="$HOME"/bin:"$PATH"
PATH="$PATH":"$XDG_DATA_HOME"/go/bin
PATH="$PATH":"$XDG_DATA_HOME"/cargo/bin
PATH="$PATH":"$XDG_DATA_HOME"/npm/bin
export PATH

# History file and its size
export HISTFILE="$XDG_DATA_HOME"/sh/history
export HISTSIZE=1000000
export SAVEHIST=1000000

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh

export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export YARN_CONFIG="$XDG_CONFIG_HOME"/yarn/yarnrc
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config

# wsl
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
  . "$XDG_CONFIG_HOME"/wsl/profile
fi

# fzf
export FZF_DEFAULT_OPTS='--height 50% --reverse --border'
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'

# wget
alias wget=wget\ --hsts-file="$XDG_CACHE_HOME"/wget/wget-hsts
