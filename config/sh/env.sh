# LANGUAGE
if locale -a 2> /dev/null | grep ja_JP.utf8 > /dev/null 2>&1; then
  export LANG=ja_JP.UTF-8
fi

# Editor
if command -v nvim >/dev/null 2>&1; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi
export CVSEDITOR="$EDITOR"
export SVN_EDITOR="$EDITOR"
export GIT_EDITOR="$EDITOR"

# Pager
export PAGER=less
if command -v delta >/dev/null 2>&1; then
  export GIT_PAGER=delta
else
  export GIT_PAGER="$PAGER"
fi

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

# bin
PATH="$HOME"/.local/bin:"$PATH"
PATH="$XDG_DATA_HOME"/docker/bin:"$PATH"
PATH="$PATH":"$XDG_DATA_HOME"/go/bin
PATH="$PATH":"$XDG_DATA_HOME"/cargo/bin
PATH="$PATH":"$XDG_DATA_HOME"/npm/bin
PATH="$PATH":"$XDG_DATA_HOME"/gem/bin
export PATH

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh

# Vim
export VIMINIT="if has('nvim') | source $XDG_CONFIG_HOME/nvim/init.vim | else | source $XDG_CONFIG_HOME/vim/vimrc | endif"

# Rust
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo

# Go
export GOPATH="$XDG_DATA_HOME"/go

# JavaScript / TypeScript
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export YARN_CONFIG="$XDG_CONFIG_HOME"/yarn/yarnrc

# Ruby
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
export SOLARGRAPH_CACHE="$XDG_CACHE_HOME"/solargraph/cache

# Docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

# Nuget
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages

# AWS
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config

# tig
if [ ! -d "$XDG_DATA_HOME"/tig ]; then
  mkdir -m 700 "$XDG_DATA_HOME"/tig
fi

# bat
if command -v bat >/dev/null 2>&1; then
  export BAT_THEME=OneHalfDark
fi

# fzf
export FZF_DEFAULT_OPTS='--height 50% --reverse --border'
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'

# anyenv
if command -v anyenv > /dev/null 2>&1; then
  eval "$(anyenv init -)"
fi
