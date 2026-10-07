# shellcheck shell=sh

export DENO_INSTALL_ROOT="$XDG_DATA_HOME"/deno
if [ ! -d "$DENO_INSTALL_ROOT" ]; then
  mkdir -m 700 "$DENO_INSTALL_ROOT"
fi
export PATH="$PATH":"$DENO_INSTALL_ROOT"/bin
