#!/usr/bin/env sh

set -eu

readonly DEFAULT_DOTDIR="$HOME"/.dotfiles
if [ -z "${DOTDIR:-}" ]; then
  DOTDIR="$DEFAULT_DOTDIR"
fi

readonly DEFAULT_REPO_URL=https://github.com/koyashiro/dotfiles
if [ -z "${REPO_URL:-}" ]; then
  REPO_URL="$DEFAULT_REPO_URL"
fi

readonly DEFAULT_ARCHIVE_URL="$REPO_URL"/archive/main.tar.gz
if [ -z "${ARCHIVE_URL:-}" ]; then
  ARCHIVE_URL="$DEFAULT_ARCHIVE_URL"
fi

readonly DEFAULT_XDG_CONFIG_HOME="$HOME"/.config
if [ -z "${XDG_CONFIG_HOME:-}" ]; then
  XDG_CONFIG_HOME="$DEFAULT_XDG_CONFIG_HOME"
fi

readonly DEFAULT_XDG_DATA_HOME="$HOME"/.local/share
if [ -z "${XDG_DATA_HOME:-}" ]; then
  XDG_DATA_HOME="$DEFAULT_XDG_DATA_HOME"
fi

cat <<EOF
[install.sh] koyashiro's dotfiles <https://github.com/koyashiro/dotfiles>

[install.sh] \$(whoami)        : $(whoami)
[install.sh] \$HOME            : $HOME
[install.sh] \$DOTDIR          : $DOTDIR
[install.sh] \$REPO_URL        : $REPO_URL
[install.sh] \$ARCHIVE_URL     : $ARCHIVE_URL
[install.sh] \$XDG_CONFIG_HOME : $XDG_CONFIG_HOME
[install.sh] \$XDG_DATA_HOME   : $XDG_DATA_HOME

EOF

# dotfiles directory checking
if [ ! -d "$DOTDIR" ]; then
  # Clone repository by Git
  if command -v git >/dev/null 2>&1; then
    echo "[install.sh] git clone $REPO_URL $DOTDIR"
    git clone "$REPO_URL" "$DOTDIR"
  # Download archive by curl
  elif command -v curl >/dev/null 2>&1; then
    echo "[install.sh] mkdir $DOTDIR"
    mkdir "$DOTDIR"

    echo "[install.sh] curl -fsSL $ARCHIVE_URL | tar -xz -C $DOTDIR --strip 1"
    curl -fsSL "$ARCHIVE_URL" | tar -xz -C "$DOTDIR" --strip 1
  # Download archive by wget
  elif command -v wget >/dev/null 2>&1; then
    echo "[install.sh] mkdir $DOTDIR"
    mkdir "$DOTDIR"

    echo "[install.sh] wget -q -O - $ARCHIVE_URL | tar -xz -C $DOTDIR --strip 1"
    wget -q -O - "$ARCHIVE_URL" | tar -xz -C "$DOTDIR" --strip 1
  else
    echo '[install.sh] error: git, curl or wget required.' 1>&2
    exit 127
  fi
fi

# Create XDG Base Directories
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

# Create symbolic link
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
    echo "[install.sh] ln -fns $d $XDG_CONFIG_HOME/$(basename $d)"
    ln -fns "$d" "$XDG_CONFIG_HOME"/"$(basename "$d")"
  done
)

# WSL
if [ -n "${WSL_INTEROP:-}" ]; then
  echo "[install.sh] ln -fns $DOTDIR/local/share/wsl $XDG_DATA_HOME/wsl"
  ln -fns "$DOTDIR"/local/share/wsl "$XDG_DATA_HOME"/wsl

  # Create `/etc/wsl.con`
  if command -v sudo >/dev/null 2>&1; then
    echo "[install.sh] sudo cp $DOTDIR/etc/wsl.conf /etc/wsl.conf"
    sudo cp "$DOTDIR"/etc/wsl.conf /etc/wsl.conf
  else
    echo "[install.sh] cp $DOTDIR/etc/wsl.conf /etc/wsl.conf"
    cp "$DOTDIR"/etc/wsl.conf /etc/wsl.conf
  fi
fi
