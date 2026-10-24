# shellcheck shell=sh

export NODE_REPL_HISTORY="${XDG_DATA_HOME:-$HOME/.local/share}/node/history"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/npm/npmrc"
export PATH="$PATH":"${XDG_DATA_HOME:-$HOME/.local/share}/npm/bin"
