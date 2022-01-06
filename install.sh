#!/usr/bin/env sh

set -eu

DOTDIR="$(cd "$(dirname "$0")"; pwd)"

is_darwin() {
  [ "$(uname)" = Darwin ]
}

is_wsl() {
  [ -n "${WSL_INTEROP:-}" ]
}

set_variables() {
  # DISTRO
  if [ -r /etc/os-release ]; then
    # shellcheck source=/etc/os-release
    DISTRO="$(. /etc/os-release && echo "$NAME")"
  else
    DISTRO='(UNKNOWN)'
  fi

  # IS_DARWIN
  if is_darwin; then
    IS_DARWIN=true
  else
    IS_DARWIN=false
  fi

  # IS_WSL
  if is_wsl; then
    IS_WSL=true
  else
    IS_WSL=false
  fi
}

show_info() {
  cat <<EOF
[install.sh] koyashiro's dotfiles <https://github.com/koyashiro/dotfiles>

[install.sh] USER            : ${USER:-$(whoami)}
[install.sh] HOME            : $HOME
[install.sh] DOTDIR          : $DOTDIR
[install.sh] DISTRO          : $DISTRO
[install.sh] IS_DARWIN       : $IS_DARWIN
[install.sh] IS_WSL          : $IS_WSL

EOF
}

create_xdg_base_directories() {
  if [ ! -d "$HOME"/.config ]; then
    echo "[install.sh] mkdir -m 700 $HOME/.config"
    mkdir -m 700 "$HOME"/.config
  fi

  if [ ! -d "$HOME"/.cache ]; then
    echo "[install.sh] mkdir -m 700 $HOME/.cache"
    mkdir -m 700 "$HOME"/.cache
  fi

  if [ ! -d "$HOME"/.local ]; then
    echo "[install.sh] mkdir -m 700 $HOME/.local"
    mkdir -m 700 "$HOME"/.local
  fi

  if [ ! -d "$HOME"/.local/share ]; then
    echo "[install.sh] mkdir -m 700 $HOME/.local/share"
    mkdir -m 700 "$HOME"/.local/share
  fi

  if [ ! -d "$HOME"/.local/bin ]; then
    echo "[install.sh] mkdir -m 700 $HOME/.local/bin"
    mkdir -m 700 "$HOME"/.local/bin
  fi
}

set_xdg_base_directories() {
  XDG_CONFIG_HOME="$HOME/.config"
  # XDG_CACHE_HOME="$HOME/.cache"
  XDG_DATA_HOME="$HOME/.local/share"
}

create_symbolic_links() {
  echo "[install.sh] ln -fns $DOTDIR/profile $HOME/.profile"
  ln -fns "$DOTDIR"/profile "$HOME"/.profile

  echo "[install.sh] ln -fns $DOTDIR/bash_profile $HOME/.bash_profile"
  ln -fns "$DOTDIR"/bash_profile "$HOME"/.bash_profile

  echo "[install.sh] ln -fns $DOTDIR/bashrc $HOME/.bashrc"
  ln -fns "$DOTDIR"/bashrc "$HOME"/.bashrc

  echo "[install.sh] ln -fns $DOTDIR/zshenv $HOME/.zshenv"
  ln -fns "$DOTDIR"/zshenv "$HOME"/.zshenv

  (
    for d in "$DOTDIR"/config/*; do
      echo "[install.sh] ln -fns $d $XDG_CONFIG_HOME/$(basename "$d")"
      ln -fns "$d" "$XDG_CONFIG_HOME"/"$(basename "$d")"
    done
  )
}

create_wsl_symbolic_links() {
  echo "[install.sh] ln -fns $DOTDIR/local/share/wsl $XDG_DATA_HOME/wsl"
  ln -fns "$DOTDIR"/local/share/wsl "$XDG_DATA_HOME"/wsl
}

main() {
  set_variables

  show_info

  create_xdg_base_directories

  set_xdg_base_directories

  create_symbolic_links

  if [ "$IS_WSL" = true ]; then
    create_wsl_symbolic_links
  fi
}

main
