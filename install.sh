#!/usr/bin/env sh

set -eu

# dotfiles variables
readonly DOTDIR="$HOME"/.dotfiles
readonly REPO_URL=https://github.com/koyashiro/dotfiles
readonly ARCHIVE_URL="$REPO_URL"/archive/main.tar.gz

# XDG Base Directory variables
readonly XDG_CONFIG_HOME="$HOME"/.config
readonly XDG_DATA_HOME="$HOME"/.local/share

# dotfiles directory checking
if [ ! -d "$DOTDIR" ]; then
  # Clone repository by Git
  if command -v git >/dev/null 2>&1; then
    git clone "$REPO_URL" "$DOTDIR"
  # Download archive by curl
  elif command -v curl >/dev/null 2>&1; then
    mkdir "$DOTDIR"
    curl -fsSL "$ARCHIVE_URL" | tar -xz -C "$DOTDIR" --strip 1
  # Download archive by wget
  elif command -v wget >/dev/null 2>&1; then
    mkdir "$DOTDIR"
    wget -q -O - "$ARCHIVE_URL" | tar -xz -C "$DOTDIR" --strip 1
  else
    echo 'error: git, curl or wget required.' 1>&2
    exit 127
  fi
fi

# Create XDG Base Directories
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

# Create symbolic link
ln -fns "$DOTDIR"/profile "$HOME"/.profile
ln -fns "$DOTDIR"/bash_profile "$HOME"/.bash_profile
ln -fns "$DOTDIR"/bashrc "$HOME"/.bashrc
ln -fns "$DOTDIR"/zshenv "$HOME"/.zshenv
(
  for d in "$DOTDIR"/config/*; do
    ln -fns "$d" "$XDG_CONFIG_HOME"/"$(basename "$d")"
  done
  for f in "$DOTDIR"/local/bin/*; do
    ln -fns "$f" "$HOME"/.local/bin/"$(basename "$f")"
  done
)

# WSL
if [ -n "${WSL_INTEROP:-}" ]; then
  ln -fns "$DOTDIR"/local/share/wsl "$XDG_DATA_HOME"/wsl

  # Create `/etc/wsl.con`
  if [ ! -e /etc/wsl.conf ]; then
    if command -v sudo >/dev/null 2>&1; then
      sudo cp "$DOTDIR"/etc/wsl.conf /etc/wsl.conf
    else
      cp "$DOTDIR"/etc/wsl.conf /etc/wsl.conf
    fi
  fi
fi
