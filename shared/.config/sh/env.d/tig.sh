# shellcheck shell=sh

if [ ! -d "$XDG_DATA_HOME"/tig ]; then
  mkdir -m 700 "$XDG_DATA_HOME"/tig
fi
