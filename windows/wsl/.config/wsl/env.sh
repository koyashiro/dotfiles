# shellcheck shell=sh

if [ -z "${WSL_INTEROP:-}" ]; then
  return
fi

# Remove `/c/mnt/Windows/System32` from $PATH
PATH="$(echo "$PATH" | sed -e 's/:\/mnt\/c\/Windows\/System32//')"

PATH="${XDG_DATA_HOME:-$HOME/.local/share}"/wsl/bin:"$PATH"

export PATH
