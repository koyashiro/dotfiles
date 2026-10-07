# shellcheck shell=sh

export WASMER_DIR="$XDG_DATA_HOME"/wasmer
export WASMER_CACHE_DIR="$XDG_CACHE_HOME"/wasmer
export PATH="$PATH:$WASMER_DIR/bin:$WASMER_DIR/globals/wapm_packages/.bin"
