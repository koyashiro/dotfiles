# shellcheck shell=sh

export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export PATH="$PATH":"$GOPATH"/bin
