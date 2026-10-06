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

  # agents
  link_xdg_config agents/AGENTS.md

  # alacritty
  link_xdg_config alacritty/alacritty.toml

  # bash
  link_xdg_config bash/mise.bash

  # cargo-atcoder
  link_xdg_config cargo-atcoder.toml

  # claude
  link_xdg_config claude/CLAUDE.md
  link_xdg_config claude/commands
  link_xdg_config claude/settings.json

  # fontconfig
  link_xdg_config fontconfig/fonts.conf

  # git
  link_xdg_config git/config
  link_xdg_config git/ignore
  link_xdg_config git/prune-merged.sh

  # herdr
  link_xdg_config herdr/config.toml

  # mise
  link_xdg_config mise/config.aws.toml
  link_xdg_config mise/config.c.toml
  link_xdg_config mise/config.docker.toml
  link_xdg_config mise/config.github.toml
  link_xdg_config mise/config.go.toml
  link_xdg_config mise/config.js.toml
  link_xdg_config mise/config.lua.toml
  link_xdg_config mise/config.markdown.toml
  link_xdg_config mise/config.shell.toml
  link_xdg_config mise/config.toml

  # npm
  link_xdg_config npm/npmrc

  # nvim
  link_xdg_config nvim/ginit.vim
  link_xdg_config nvim/init.lua
  link_xdg_config nvim/lazy-lock.json
  link_xdg_config nvim/lua

  # peco
  link_xdg_config peco/config.json

  # readline
  link_xdg_config readline/inputrc

  # sh
  link_xdg_config sh/alias.sh
  link_xdg_config sh/env.sh
  link_xdg_config sh/function.sh
  link_xdg_config sh/git.sh

  # sqlite3
  link_xdg_config sqlite3/sqliterc

  # tig
  link_xdg_config tig/config

  # tmux
  link_xdg_config tmux/tmux.conf

  # zsh
  link_xdg_config zsh/.p10k.zsh
  link_xdg_config zsh/autoload.zsh
  link_xdg_config zsh/bindkey.zsh
  link_xdg_config zsh/completion.zsh
  link_xdg_config zsh/direnv.zsh
  link_xdg_config zsh/fzf.zsh
  link_xdg_config zsh/git.zsh
  link_xdg_config zsh/mise.zsh
  link_xdg_config zsh/setopt.zsh
  link_xdg_config zsh/zinit.zsh
  link_xdg_config zsh/zle.zsh
  link_xdg_config zsh/zstyle.zsh

  # $HOME/.local/bin
  create_symbolic_link "${DOTDIR}/shared/.local/bin/checkip" "${HOME}/.local/bin/checkip"
  create_symbolic_link "${DOTDIR}/shared/.local/bin/dname" "${HOME}/.local/bin/dname"
  create_symbolic_link "${DOTDIR}/shared/.local/bin/dump-pacman" "${HOME}/.local/bin/dump-pacman"
  create_symbolic_link "${DOTDIR}/shared/.local/bin/dump-yay" "${HOME}/.local/bin/dump-yay"
  create_symbolic_link "${DOTDIR}/shared/.local/bin/install-yay" "${HOME}/.local/bin/install-yay"
  create_symbolic_link "${DOTDIR}/shared/.local/bin/is_wsl" "${HOME}/.local/bin/is_wsl"
  create_symbolic_link "${DOTDIR}/shared/.local/bin/loading" "${HOME}/.local/bin/loading"
  create_symbolic_link "${DOTDIR}/shared/.local/bin/make-editorconfig" "${HOME}/.local/bin/make-editorconfig"
  create_symbolic_link "${DOTDIR}/shared/.local/bin/make-gitattributes" "${HOME}/.local/bin/make-gitattributes"
  create_symbolic_link "${DOTDIR}/shared/.local/bin/restore-pacman" "${HOME}/.local/bin/restore-pacman"
  create_symbolic_link "${DOTDIR}/shared/.local/bin/restore-yay" "${HOME}/.local/bin/restore-yay"
}

# Symlink an entry of shared/.config into $XDG_CONFIG_HOME, keeping its parent
# directory real so that runtime data written by apps stays out of the repo.
link_xdg_config() {
  mkdir -p "$(dirname "${XDG_CONFIG_HOME}/$1")"
  create_symbolic_link "${DOTDIR}/shared/.config/$1" "${XDG_CONFIG_HOME}/$1"
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
