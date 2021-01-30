#!/bin/sh

set -eux

dotdir="$HOME"/.dotfiles
readonly dotdir

cd

if [ ! -d "$dotdir" ]; then
  if command -v git > /dev/null 2>&1; then
    repo_url=https://github.com/KoyashiroKohaku/dotfiles
    readonly repo_url

    git clone "$repo_url" "$dotdir"
  elif command -v curl > /dev/null 2>&1 || command -v wget > /dev/null 2>&1; then
    archive_url=https://github.com/KoyashiroKohaku/dotfiles/archive/master.tar.gz
    readonly archive_url

    if command -v curl > /dev/null 2>&1; then
      curl -L "$archive_url"
    elif command -v wget > /dev/null 2>&1; then
      wget -O - "$archive_url"
    fi | tar -zxv

    mv -f dotfiles-master "$dotdir"
  else
    echo 'install.sh: git, curl or wget required' 1>&2
    exit 127
  fi
fi

cd "$dotdir"

# .config .cache .local .local/share .local/bin
if [ ! -d "$HOME"/.config ]; then
  mkdir -m 700 "$HOME"/.config
fi
if [ ! -d "$HOME"/.cache ]; then
  mkdir -m 700 "$HOME"/.cache
fi
if [ ! -d "$HOME"/.local ]; then
  mkdir -m 700 "$HOME"/.local
fi
if [ ! -d "$HOME"/.local/share ]; then
  mkdir -m 700 "$HOME"/.local/share
fi
if [ ! -d "$HOME"/.local/bin ]; then
  mkdir -m 700 "$HOME"/.local/bin
fi

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share

# dot files
for f in .??*; do
  [ "$f" = '.config' ] && continue
  [ "$f" = '.git' ] && continue
  [ "$f" = '.gitattributes' ] && continue
  [ "$f" = '.gitignore' ] && continue
  [ "$f" = '.local' ] && continue

  ln -fns "$dotdir"/"$f" "$HOME"/"$f"
done

# $XDG_CONFIG_HOME
for f in .config/??*; do
  ln -fns "$dotdir"/"$f" "$XDG_CONFIG_HOME"/"$(basename "$f")"
done

# $HOME/.local/bin
for f in .local/bin/??*; do
  ln -fns "$dotdir"/"$f" "$HOME"/.local/bin/"$(basename "$f")"
done

# docker
ln -fns "$dotdir"/.local/share/docker "$XDG_DATA_HOME"/docker

# wsl
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
  ln -fns "$dotdir"/.local/share/wsl "$XDG_DATA_HOME"/wsl
  "$XDG_DATA_HOME"/wsl/bin/gen-wslprofile
fi
