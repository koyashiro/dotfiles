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

create_directory_if_does_not_exist() {
  printf "\x1b[32mChecking\x1b[39m directory: \x1b[36m%s\x1b[39m\n" "$1"
  if [ ! -d "$1" ]; then
    printf "  Directory does not exist: \x1b[34m%s\x1b[39m\n" "$1"

    printf "  \x1b[32mCreating\x1b[39m directory: \x1b[36m%s\x1b[39m\n" "$1"
    mkdir -m 700 "$1"
    printf "    Created: \x1b[34m%s\x1b[39m\n" "$1"
  else
    printf "  Directory exists: \x1b[34m%s\x1b[39m\n" "$1"
  fi
}

create_xdg_base_directories() {
  create_directory_if_does_not_exist "$HOME/.config"

  create_directory_if_does_not_exist "$HOME/.cache"

  create_directory_if_does_not_exist "$HOME/.local"

  create_directory_if_does_not_exist "$HOME/.local/share"

  create_directory_if_does_not_exist "$HOME/.local/bin"

  echo
}

set_xdg_base_directories() {
  XDG_CONFIG_HOME="$HOME/.config"
  # XDG_CACHE_HOME="$HOME/.cache"
  XDG_DATA_HOME="$HOME/.local/share"
}

create_symbolic_link() {
  printf "\x1b[32mCreating\x1b[39m symbolic link: \x1b[36m%s\x1b[39m -> \x1b[36m%s\x1b[39m\n" "$1" "$2"
  ln -fns "$1" "$2"
  printf "  Created: \x1b[34m%s\x1b[39m\n" "$2"
}

create_symbolic_links() {
  create_symbolic_link "$DOTDIR/.profile" "$HOME/.profile"

  create_symbolic_link "$DOTDIR/.bash_profile" "$HOME/.bash_profile"

  create_symbolic_link "$DOTDIR/.bashrc" "$HOME/.bashrc"

  create_symbolic_link "$DOTDIR/.zshenv" "$HOME/.zshenv"

  (
    for src in "$DOTDIR"/.config/*; do
      dist="$XDG_CONFIG_HOME"/"$(basename "$src")"
      create_symbolic_link "$src" "$dist"
    done
  )
}

create_wsl_symbolic_links() {
  create_symbolic_link "$DOTDIR/.local/share/wsl" "$XDG_DATA_HOME/wsl"
}

main() {
  set_variables

  create_xdg_base_directories

  set_xdg_base_directories

  create_symbolic_links

  if [ "$IS_WSL" = true ]; then
    create_wsl_symbolic_links
  fi
}

main
