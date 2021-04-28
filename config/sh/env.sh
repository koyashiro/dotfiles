# Language
if locale -a 2>/dev/null | grep ja_JP.utf8 >/dev/null 2>&1; then
  export LANG=ja_JP.UTF-8
fi

# Editor
if command -v nvim >/dev/null 2>&1; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

# Pager
export PAGER=less

# Less
if [ ! -d "${XDG_CONFIG_HOME:-$HOME/.config}"/less ]; then
  mkdir -m 700 "${XDG_CONFIG_HOME:-$HOME/.config}"/less
fi
if [ ! -d "${XDG_CACHE_HOME:-$HOME/.cache}"/less ]; then
  mkdir -m 700 "${XDG_CACHE_HOME:-$HOME/.cache}"/less
fi
export LESS='-fiMRfFx4X'
export LESSCHARSET='utf-8'
export LESSKEY="${XDG_CONFIG_HOME:-$HOME/.config}"/less/lesskey
export LESSHISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}"/less/history

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

# zsh
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}"/zsh

# Vim
export VIMINIT="if has('nvim') | source ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/init.vim | else | source ${XDG_CONFIG_HOME:-~/.config}/vim/vimrc | endif"

# Git
export GIT_EDITOR="$EDITOR"
if command -v delta >/dev/null 2>&1; then
  export GIT_PAGER=delta
else
  export GIT_PAGER="$PAGER"
fi

# brew
if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# tig
if [ ! -d "${XDG_DATA_HOME:-$HOME/.local/share}"/tig ]; then
  mkdir -m 700 "${XDG_DATA_HOME:-$HOME/.local/share}"/tig
fi

# fzf
if command -v fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_OPTS='--height 50% --reverse --border'
  export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
fi

# AWS CLI
if command -v aws >/dev/null 2>&1; then
  export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
  export AWS_SHARED_CREDENTIALS_FILE="$XDG_DATA_HOME"/aws/credentials
fi

# Docker
if command -v docker >/dev/null 2>&1; then
  export DOCKER_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"/docker
fi

# AWS
if command -v aws >/dev/null 2>&1; then
  export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME:-$HOME/.config}"/aws/credentials
  export AWS_CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}"/aws/config
fi

# Rust
if command -v rustup >/dev/null 2>&1; then
  export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"/rustup
  export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"/cargo
  export PATH="$PATH":"$CARGO_HOME"/bin
fi

# Go
if command -v go >/dev/null 2>&1; then
  export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}"/go
  export PATH="$PATH":"$GOPATH"/bin
fi

# JavaScript / TypeScript
if command -v npm >/dev/null 2>&1; then
  export NODE_REPL_HISTORY="${XDG_DATA_HOME:-$HOME/.local/share}"/node/history
  export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"/npm/npmrc
  export TS_NODE_HISTORY="${XDG_DATA_HOME:-$HOME/.local/share}"/ts-node/history
  export PATH="$PATH":"${XDG_DATA_HOME:-$HOME/.local/share}"/npm/bin
fi
if command -v yarn >/dev/null 2>&1; then
  export YARN_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"/yarn/yarnrc
fi

# Ruby
if command -v ruby >/dev/null 2>&1; then
  export GEM_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"/gem
  export GEM_SPEC_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}"/gem
  export BUNDLE_USER_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"/bundle
  export BUNDLE_USER_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}"/bundle
  export BUNDLE_USER_PLUGIN="${XDG_DATA_HOME:-$HOME/.local/share}"/bundle
  export SOLARGRAPH_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}"/solargraph/cache
  export PATH="$PATH":"$GEM_HOME"/bin
fi

# anyenv
if [ -d "${XDG_DATA_HOME:-$HOME/.local/share}"/anyenv ]; then
  export ANYENV_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}"/anyenv
  export ANYENV_DEFINITION_ROOT="${XDG_CONFIG_HOME:-$HOME/.config}"/anyenv/anyenv-install
  export PATH="$PATH":"$ANYENV_ROOT"/bin
  eval "$(anyenv init -)"
fi

# $HOME/.local/bin
if [ -d "$HOME"/.local/bin ]; then
  export PATH="$HOME"/.local/bin:"$PATH"
fi
