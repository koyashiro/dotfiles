# shellcheck shell=sh

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state

# Locale
export LANG="${LANG:-en_US.UTF-8}"

# Editor
if command -v nvim >/dev/null 2>&1; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

# Apps
for f in "$XDG_CONFIG_HOME"/sh/env.d/*.sh; do
  # shellcheck disable=SC1090
  [ -f "$f" ] && . "$f"
done
unset f

# Homebrew
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/coreutils/libexec/gnubin:"$PATH"

# wsl
if [ -n "${WSL_INTEROP:-}" ]; then
  if [ -f "$XDG_CONFIG_HOME"/wsl/env.sh ]; then
    # shellcheck source=windows/wsl/.config/wsl/env.sh
    . "$XDG_CONFIG_HOME"/wsl/env.sh
  fi
fi

# $HOME/.local/bin
export PATH="$HOME"/.local/bin:"$PATH"
