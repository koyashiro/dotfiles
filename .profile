# .profile

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share

# env
if [ -f "$XDG_CONFIG_HOME"/sh/env.sh ]; then
  # shellcheck source=config/sh/env.sh
  . "$XDG_CONFIG_HOME"/sh/env.sh
fi

# wsl
if [ -n "${WSL_INTEROP:-}" ]; then
  if [ -f "$XDG_CONFIG_HOME"/wsl/profile ]; then
    # shellcheck source=config/wsl/profile
    . "$XDG_CONFIG_HOME"/wsl/profile
  fi
fi

# rc
if [ -n "${PS1:-}" ]; then
  # shellcheck source=config/sh/alias.sh
  . "$XDG_CONFIG_HOME"/sh/alias.sh

  # shellcheck source=config/sh/function.sh
  . "$XDG_CONFIG_HOME"/sh/function.sh
fi
