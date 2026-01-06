# shellcheck shell=sh

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state

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

# Readline
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

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

# direnv
if command -v direnv >/dev/null 2>&1; then
  export DIRENV_LOG_FORMAT=''
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

# kubernetes
export KUBECONFIG="$XDG_CONFIG_HOME"/kube
export KUBECACHEDIR="$XDG_CACHE_HOME"/kube

# AWS CLI
if command -v aws >/dev/null 2>&1; then
  export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
  export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
fi

# Redis
export REDISCLI_HISTFILE="$XDG_DATA_HOME"/redis/rediscli_history
export REDISCLI_RCFILE="$XDG_CONFIG_HOME"/redis/redisclirc

# Rust
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export PATH="$PATH":"$CARGO_HOME"/bin

# Go
export GOPATH="$XDG_DATA_HOME"/go
export PATH="$PATH":"$GOPATH"/bin

# JavaScript / TypeScript
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node/history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export TS_NODE_HISTORY="$XDG_DATA_HOME"/ts-node/history
export PATH="$PATH":"$XDG_DATA_HOME"/npm/bin
export DENO_INSTALL_ROOT="$XDG_DATA_HOME"/deno
if [ ! -d "$DENO_INSTALL_ROOT" ]; then
  mkdir -m 700 "$DENO_INSTALL_ROOT"
fi
export PATH="$PATH":"$DENO_INSTALL_ROOT"/bin

# Volta
export VOLTA_HOME="$XDG_DATA_HOME"/volta
export PATH="$PATH":"$VOLTA_HOME"/bin

# Wasmtime
export WASMTIME_HOME="$XDG_DATA_HOME"/wasmtime
export PATH="$PATH":"$WASMTIME_HOME"/bin

# Wasmer
export WASMER_DIR="$XDG_DATA_HOME"/wasmer
export WASMER_CACHE_DIR="$XDG_CACHE_HOME"/wasmer
export PATH="$PATH:$WASMER_DIR/bin:$WASMER_DIR/globals/wapm_packages/.bin"

# Homebrew
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/coreutils/libexec/gnubin:"$PATH"

# aqua
export AQUA_GLOBAL_CONFIG="$XDG_CONFIG_HOME"/aquaproj-aqua/aqua.yaml
export PATH="$XDG_DATA_HOME"/aquaproj-aqua/bin:"$PATH"

# Kubernetes
export KUBECONFIG="$XDG_CONFIG_HOME/kube"
export KUBECACHEDIR="$XDG_CACHE_HOME/kube"

# Ansible
export ANSIBLE_HOME="${XDG_CONFIG_HOME}/ansible"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible.cfg"
export ANSIBLE_GALAXY_CACHE_DIR="${XDG_CACHE_HOME}/ansible/galaxy_cache"

# wsl
if [ -n "${WSL_INTEROP:-}" ]; then
  if [ -f "$XDG_CONFIG_HOME"/wsl/env.sh ]; then
    # shellcheck source=windows/wsl/.config/wsl/env.sh
    . "$XDG_CONFIG_HOME"/wsl/env.sh
  fi
fi

# $HOME/.local/bin
export PATH="$HOME"/.local/bin:"$PATH"
