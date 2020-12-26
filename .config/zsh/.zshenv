# .zshenv

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share

# env
if [ -f "$XDG_CONFIG_HOME"/sh/env.sh ]; then
  source "$XDG_CONFIG_HOME"/sh/env.sh
fi

# normalize $PATH
typeset -U path PATH
