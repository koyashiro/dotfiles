# .bashrc

# interactive checking
if [[ -z "$PS1" ]]; then
  return
fi

# History file
if [[ ! -d "${XDG_STATE_HOME:-$HOME/.local/state}"/bash ]]; then
  mkdir -m 700 "${XDG_STATE_HOME:-$HOME/.local/state}"/bash
fi
export HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}"/bash/history
export HISTSIZE=1000000
export SAVEHIST=1000000

# alias
if [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/alias.sh ]]; then
  # shellcheck source=config/sh/alias.sh
  source "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/alias.sh
fi

# function
if [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/function.sh ]]; then
  # shellcheck source=config/sh/function.sh
  source "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/function.sh
fi
