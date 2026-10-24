# shellcheck shell=sh

export WASMTIME_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/wasmtime"
export PATH="$PATH":"$WASMTIME_HOME"/bin
