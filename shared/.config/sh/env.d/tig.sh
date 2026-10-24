# shellcheck shell=sh

if [ ! -d "${XDG_DATA_HOME:-$HOME/.local/share}/tig" ]; then
  mkdir -m 700 "${XDG_DATA_HOME:-$HOME/.local/share}/tig"
fi
