#!/usr/bin/env sh

set -e

usage() {
  cat << EOF
Install script for koyashiro's dotfiles.

Usage:
    install.sh [OPTIONS]

Options:
    --dry-run          Dry run
    -h, --help         Print help
EOF
}

set_envs() {
  [ -n "${XDG_CONFIG_HOME}" ] || XDG_CONFIG_HOME="${HOME}/.config"
  [ -n "${XDG_CACHE_HOME}" ] || XDG_CACHE_HOME="${HOME}/.cache"
  [ -n "${XDG_DATA_HOME}" ] || XDG_DATA_HOME="${HOME}/.local/share"
  [ -n "${XDG_STATE_HOME}" ] || XDG_STATE_HOME="${HOME}/.local/state"
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
        echo "ERROR: unexpected option '$1'" >&2
        echo >&2
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
  mkdir -p "${XDG_CONFIG_HOME}"
  mkdir -p "${XDG_CACHE_HOME}"
  mkdir -p "${XDG_DATA_HOME}"
  mkdir -p "${XDG_STATE_HOME}"
}

create_symbolic_link() {
  if [ -n "${DRY_RUN}" ]; then
    printf "\x1b[32mSkipped (dry run)\x1b[39m: \x1b[36m%s\x1b[39m -> \x1b[36m%s\x1b[39m\n" "$1" "$2"
  else
    ln -fns "$1" "$2"
    printf "\x1b[32mCreated\x1b[39m: \x1b[36m%s\x1b[39m -> \x1b[36m%s\x1b[39m\n" "$1" "$2"
  fi
}

create_symbolic_links() {
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

  (
    for src in "${DOTDIR}"/shared/.config/*; do
      dist="${XDG_CONFIG_HOME}/$(basename "${src}")"
      create_symbolic_link "${src}" "${dist}"
    done
  )
}

create_macos_symbolic_links() {
  (
    for src in "${DOTDIR}"/macos/Library/*; do
      dist="${XDG_CONFIG_HOME}/$(basename "${src}")"
      create_symbolic_link "${src}" "${dist}"
    done
  )
}

create_wsl_symbolic_links() {
  (
    for src in "${DOTDIR}"/windows/wsl/.config/*; do
      dist="${XDG_CONFIG_HOME}/$(basename "${src}")"
      create_symbolic_link "${src}" "${dist}"
    done
  )

  (
    for src in "${DOTDIR}"/windows/wsl/.local/bin/*; do
      dist="${HOME}/.local/bin/$(basename "${src}")"
      create_symbolic_link "${src}" "${dist}"
    done
  )
}

main() {
  set_envs
  parse_args "$@"

  create_xdg_base_directories_if_needed

  create_symbolic_links

  if is_macos; then
    create_macos_symbolic_links
  fi

  if is_wsl; then
    create_wsl_symbolic_links
  fi
}

main "$@"
