# .profile

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share

# env
if [ -f "$XDG_CONFIG_HOME"/sh/env.sh ]; then
  . "$XDG_CONFIG_HOME"/sh/env.sh
fi

# rc
if [[ -n "$PS1" ]]; then
  # alias
  source "$XDG_CONFIG_HOME"/sh/alias.sh

  # function
  source "$XDG_CONFIG_HOME"/sh/function.sh
fi
