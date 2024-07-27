#!/usr/bin/env sh

set -e

usage() {
  cat <<EOF
Install script for koyashiro's dotfiles.

Usage:
    install.sh [OPTIONS]

Options:
    --dry-run          Dry run
    -h, --help         Print help
EOF
}

set_envs() {
  export XDG_CONFIG_HOME="${HOME}/.config"
  export XDG_CACHE_HOME="${HOME}/.cache"
  export XDG_DATA_HOME="${HOME}/.local/share"
  export XDG_STATE_HOME="${HOME}/.local/state"
  DOTDIR="$(cd "$(dirname "$0")" && pwd)"
}

get_os() {
  case "$(uname)" in
    Linux)
      echo 'Linux'
      ;;
    Darwin)
      echo 'macOS'
      ;;
    CYGWIN* | MINGW* | MSYS*)
      echo 'Windows'
      ;;
    *)
      echo 'Unknown'
      ;;
  esac
}

is_macos() {
  [ "$(get_os)" = 'macOS' ]
}

is_wsl() {
  [ -n "${WSL_INTEROP}" ]
}

parse_args() {
  while [ -n "$1" ]; do
    case "$1" in
      --dry-run)
        DRY_RUN='1'
        ;;
      --help | -h)
        usage
        exit
        ;;
      *)
        printf "\x1b[31mERROR:\x1b[39m unexpected option '\x1b[33m%s\x1b[39m'\n\n" "$1" >&2
        usage >&2
        exit 1
        ;;
    esac

    shift
  done
}

create_xdg_base_directory_if_needed() {
  mkdir -p "$1"
  chmod 700 "$1"
}

create_xdg_base_directories_if_needed() {
  create_xdg_base_directory_if_needed "${HOME}/.config"
  create_xdg_base_directory_if_needed "${HOME}/.cache"
  create_xdg_base_directory_if_needed "${HOME}/.local"
  create_xdg_base_directory_if_needed "${HOME}/.local/share"
  create_xdg_base_directory_if_needed "${HOME}/.local/state"
  create_xdg_base_directory_if_needed "${HOME}/.local/bin"
}

create_symbolic_link() {
  if [ -n "${DRY_RUN}" ]; then
    printf "  \x1b[35mSkipped (dry run):\x1b[39m \x1b[36m%s\x1b[39m -> \x1b[36m%s\x1b[39m\n" "$1" "$2"
  else
    ln -fns "$1" "$2"
    printf "  \x1b[32mCreated:\x1b[39m \x1b[36m%s\x1b[39m -> \x1b[36m%s\x1b[39m\n" "$1" "$2"
  fi
}

install_shared_dotfiles() {
  printf "Install \x1b[33mshared\x1b[39m dotfiles:\n"

  # sh
  create_symbolic_link "${DOTDIR}/shared/.profile" "${HOME}/.profile"

  # bash
  create_symbolic_link "${DOTDIR}/shared/.bash_profile" "${HOME}/.bash_profile"
  create_symbolic_link "${DOTDIR}/shared/.bashrc" "${HOME}/.bashrc"

  # zsh
  create_symbolic_link "${DOTDIR}/shared/.zshenv" "${HOME}/.zshenv"
  create_symbolic_link "${DOTDIR}/shared/.zshrc" "${HOME}/.zshrc"

  # vim
  create_symbolic_link "${DOTDIR}/shared/.vimrc" "${HOME}/.vimrc"

  # $HOME/.config/
  (
    for src in "${DOTDIR}"/shared/.config/*; do
      dist="${XDG_CONFIG_HOME}/$(basename "${src}")"
      create_symbolic_link "${src}" "${dist}"
    done
  )

  # $HOME/.local/bin
  (
    for src in "${DOTDIR}"/shared/.local/bin/*; do
      dist="${HOME}/.local/bin/$(basename "${src}")"
      create_symbolic_link "${src}" "${dist}"
    done
  )
}

install_macos_dotfiles() {
  printf "Install \x1b[33mmacOS\x1b[39m dotfiles:\n"

  # $HOME/.config/
  (
    for src in "${DOTDIR}"/macos/.config/*; do
      dist="${XDG_CONFIG_HOME}/$(basename "${src}")"
      create_symbolic_link "${src}" "${dist}"
    done
  )

  # $HOME/Library/
  (
    for src in "${DOTDIR}"/macos/Library/*; do
      dist="${HOME}/Library/$(basename "${src}")"
      create_symbolic_link "${src}" "${dist}"
    done
  )
}

install_wsl_dotfiles() {
  printf "Install \x1b[33mwsl\x1b[39m dotfiles:\n"

  # $HOME/.config
  (
    for src in "${DOTDIR}"/windows/wsl/.config/*; do
      dist="${XDG_CONFIG_HOME}/$(basename "${src}")"
      create_symbolic_link "${src}" "${dist}"
    done
  )

  # $HOME/.local/bin
  (
    for src in "${DOTDIR}"/windows/wsl/.local/bin/*; do
      dist="${HOME}/.local/bin/$(basename "${src}")"
      create_symbolic_link "${src}" "${dist}"
    done
  )
}

main() {
  create_xdg_base_directories_if_needed
  set_envs
  parse_args "$@"

  install_shared_dotfiles

  if is_macos; then
    install_macos_dotfiles
  fi

  if is_wsl; then
    install_wsl_dotfiles
  fi
}

main "$@"
