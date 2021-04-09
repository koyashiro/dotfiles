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

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh

# Vim
export VIMINIT="if has('nvim') | source $XDG_CONFIG_HOME/nvim/init.vim | else | source $XDG_CONFIG_HOME/vim/vimrc | endif"

# Git
export GIT_EDITOR="$EDITOR"
if command -v delta >/dev/null 2>&1; then
  export GIT_PAGER=delta
else
  export GIT_PAGER="$PAGER"
fi

# tig
if [ ! -d "$XDG_DATA_HOME"/tig ]; then
  mkdir -m 700 "$XDG_DATA_HOME"/tig
fi

# bat
if command -v bat >/dev/null 2>&1; then
  export BAT_THEME=OneHalfDark
fi

# fzf
if command -v fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_OPTS='--height 50% --reverse --border'
  export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
fi

# Docker
if command -v docker >/dev/null 2>&1; then
  export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
fi

# AWS
if command -v aws >/dev/null 2>&1; then
  export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
  export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
fi

# Rust
if command -v rustup >/dev/null 2>&1; then
  export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
  export CARGO_HOME="$XDG_DATA_HOME"/cargo
  export PATH="$PATH":"$CARGO_HOME"/bin
fi

# Go
if command -v go >/dev/null 2>&1; then
  export GOPATH="$XDG_DATA_HOME"/go
  export PATH="$PATH":"$GOPATH"/bin
fi

# JavaScript / TypeScript
if command -v npm >/dev/null 2>&1; then
  export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
fi
if command -v yarn >/dev/null 2>&1; then
  export YARN_CONFIG="$XDG_CONFIG_HOME"/yarn/yarnrc
fi

# Ruby
if command -v ruby >/dev/null 2>&1; then
  export GEM_HOME="$XDG_DATA_HOME"/gem
  export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
  export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
  export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
  export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
  export SOLARGRAPH_CACHE="$XDG_CACHE_HOME"/solargraph/cache
fi

# anyenv
if [ -d "$XDG_DATA_HOME"/anyenv ]; then
  export ANYENV_ROOT="$XDG_DATA_HOME"/anyenv
  export ANYENV_DEFINITION_ROOT="$XDG_CONFIG_HOME"/anyenv/anyenv-install
  export PATH="$PATH":"$ANYENV_ROOT"/bin
  eval "$(anyenv init -)"
fi

# ~/.local/bin
if [ -d "$HOME"/.local/bin ]; then
  export PATH="$HOME"/.local/bin:"$PATH"
fi
