if [ -z "${WSL_INTEROP:-}" ]; then
  return
fi

# Remove `/c/mnt/Windows/System32` from $PATH
PATH="$(echo "$PATH" | sed -e 's/:\/mnt\/c\/Windows\/System32//')"

PATH="${XDG_DATA_HOME:-$HOME/.local/share}"/wsl/bin:"$PATH"
DISPLAY="$(ipconfig.exe | awk 'BEGIN { RS="\r\n"; } /vEthernet \(WSL\):/ { target_section=1; }; (target_section && /IPv4/) { printf $NF; exit; }')":0

export PATH
export DISPLAY