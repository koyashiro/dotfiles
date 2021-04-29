#!/usr/bin/env sh

set -eu

readonly DOTDIR="$HOME"/.dotfiles

assert_exist() {
  if [ ! -e "$*" ]; then
    printf '[sh test] assertion failed!\n' "$*" 1>&2
    printf ' => `%s` does not exist\n' "$*" 1>&2
    exit 1
  fi
}

assert_file() {
  assert_exist "$*"
  if [ ! -f "$*" ]; then
    printf '[sh test] assertion failed!\n' "$*" 1>&2
    printf ' => `%s` is not file\n' "$*" 1>&2
    exit 1
  fi
}

assert_directory() {
  assert_exist "$*"
  if [ ! -d "$*" ]; then
    printf '[sh test] assertion failed!\n' "$*" 1>&2
    printf ' => `%s` is not directory\n' "$*" 1>&2
    exit 1
  fi
}

assert_equal() {
  if [ "$1" != "$2" ]; then
    printf '[sh test] assertion failed!\n' 1>&2
    printf ' => expected: %s\n' "$1" 1>&2
    printf ' => actual  : %s\n' "$2" 1>&2
    exit 1
  fi
}

assert_env() {
  if [ -z "$(eval "$(printf 'echo ${%s:-}' $1)")" ]; then
    printf '[sh test] assertion failed!\n'
    printf ' => `%s` is unbound variable\n' "$1" 1>&2
    exit 1
  fi
}

cd "$DOTDIR"

./install.sh

# `$HOME/.dotfiles`
assert_directory "$DOTDIR"

# `$HOME/.profile`
readonly DOT_PROFILE="$HOME"/.profile
assert_file "$HOME"/.profile
assert_equal "$(readlink -f "$HOME"/.profile)" "$DOTDIR"/profile

# `$HOME/.bash_profile`
assert_file "$HOME"/.bash_profile
assert_equal "$(readlink -f "$HOME"/.bash_profile)" "$DOTDIR"/bash_profile

# `$HOME/.bshrc`
assert_file "$HOME"/.bashrc
assert_equal "$(readlink -f "$HOME"/.bashrc)" "$DOTDIR"/bashrc

# `$HOME/.zshenv`
assert_file "$HOME"/.zshenv
assert_equal "$(readlink -f "$HOME"/.zshenv)" "$DOTDIR"/zshenv

# `$HOME/.config`
assert_directory "$HOME"/.config

# `$HOME/.cache`
assert_directory "$HOME"/.cache

# `$HOME/.local`
assert_directory "$HOME"/.local

# `$HOME/.local/share`
assert_directory "$HOME"/.local/share

# `$HOME/.bin`
assert_directory "$HOME"/.local/bin

# source profile
. $HOME/.profile

# `$XDG_CONFIG_HOME`
assert_env XDG_CONFIG_HOME
assert_equal "$XDG_CONFIG_HOME" "$HOME"/.config

# `$XDG_CACHE_HOME`
assert_env XDG_CACHE_HOME
assert_equal "$XDG_CACHE_HOME" "$HOME"/.cache

# `$XDG_DATA_HOME`
assert_env XDG_DATA_HOME
assert_equal "$XDG_DATA_HOME" "$HOME"/.local/share
