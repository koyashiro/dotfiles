# shellcheck shell=sh

export REDISCLI_RCFILE="${XDG_CONFIG_HOME:-$HOME/.config}/redis/redisclirc"
export REDISCLI_HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/redis/history"
