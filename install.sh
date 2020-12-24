#!/usr/bin/env bash

# .config .cache .local .local/share .local/bin
if [[ ! -d "$HOME"/.config ]]; then
  mkdir -m 700 "$HOME"/.config
fi
if [[ ! -d "$HOME"/.cache ]]; then
  mkdir -m 700 "$HOME"/.cache
fi
if [[ ! -d "$HOME"/.local ]]; then
  mkdir -m 700 "$HOME"/.local
fi
if [[ ! -d "$HOME"/.local/share ]]; then
  mkdir -m 700 "$HOME"/.local/share
fi
if [[ ! -d "$HOME"/.local/bin ]]; then
  mkdir -m 700 "$HOME"/.local/bin
fi

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share

readonly dotdir=$(cd $(dirname "$0");pwd)

# dot files
for f in "$dotdir"/.??*; do
  [[ $(basename "$f") == '.config' ]] && continue
  [[ $(basename "$f") == '.git' ]] && continue
  [[ $(basename "$f") == '.gitattributes' ]] && continue
  [[ $(basename "$f") == '.gitignore' ]] && continue
  [[ $(basename "$f") == '.local' ]] && continue

  ln -fns $f "$HOME"/$(basename $f)
done

# $XDG_CONFIG_HOME
for f in "$dotdir"/.config/??*; do
  ln -fns $f "$XDG_CONFIG_HOME"/$(basename "$f")
done

# $HOME/.local/bin
for f in "$dotdir"/.local/bin/??*; do
  ln -fns "$f" "$HOME"/.local/bin/$(basename "$f")
done

# docker
ln -fns "$dotdir"/.local/share/docker "$XDG_DATA_HOME"/docker

# wsl
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
  ln -fns "$dotdir"/.local/share/wsl "$XDG_DATA_HOME"/wsl
  "$XDG_DATA_HOME"/wsl/bin/gen-wslprofile
fi
