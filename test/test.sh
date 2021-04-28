#!/usr/bin/env sh

set -e

readonly DOTDIR="$HOME"/.dotfiles

cd "$DOTDIR"

sh ./install.sh

# `$HOME/.dotfiles`
if [ ! -d "$DOTDIR" ]; then
  echo '`'"$DOTDIR"'`' is not exists 1>&2
  exit 1
fi

# `$HOME/.profile`
if [ ! -f "$HOME"/.profile ]; then
  echo '`'"$HOME"/.profile'`' is not exists 1>&2
  exit 1
fi

# `$HOME/.bash_profile`
if [ ! -f "$HOME"/.bash_profile ]; then
  echo '`'"$HOME"/.bash_profile'`' is not exists 1>&2
  exit 1
fi

# `$HOME/.bshrc`
if [ ! -f "$HOME"/.bashrc ]; then
  echo '`'"$HOME"/.bashrc'`' is not exists 1>&2
  exit 1
fi

# `$HOME/.zshenv`
if [ ! -f "$HOME"/.zshenv ]; then
  echo '`'"$HOME"/.zshenv'`' not exists 1>&2
  exit 1
fi

. $HOME/.profile

# `$XDG_CONFIG_HOME`
if [ -z "$XDG_CONFIG_HOME" ]; then
  echo parameter '`$XDG_CONFIG_HOME' is not set 1>&2
  exit 1
fi

# `$XDG_CACHE_HOME`
if [ -z "$XDG_CACHE_HOME" ]; then
  echo parameter '`$XDG_CACHE_HOME' is not set 1>&2
  exit 1
fi

# `$XDG_DATA_HOME`
if [ -z "$XDG_DATA_HOME" ]; then
  echo parameter '`$XDG_DATA_HOME' is not set 1>&2
  exit 1
fi
