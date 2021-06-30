# .zshenv

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share

# data
if [ ! -d "$XDG_DATA_HOME"/zsh ]; then
  mkdir -m 700 "$XDG_DATA_HOME"/zsh
fi

# env
if [ -f "$XDG_CONFIG_HOME"/sh/env.sh ]; then
  # shellcheck source=config/sh/env.sh
  source "$XDG_CONFIG_HOME"/sh/env.sh
fi

# direnv
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# wsl
if [[ -n "${WSL_INTEROP:-}" ]]; then
  if [[ -f "$XDG_CONFIG_HOME"/wsl/profile ]]; then
    # shellcheck source=config/wsl/profile
    source "$XDG_CONFIG_HOME"/wsl/profile
  fi
fi

# shellcheck disable=SC2034
typeset -U path PATH

# shellcheck disable=SC2034
skip_global_compinit=1
