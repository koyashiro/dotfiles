# shellcheck shell=bash

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
export HISTCONTROL=ignoreboth

# sh rc
if [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/rc.sh ]]; then
  # shellcheck source=shared/.config/sh/rc.sh
  source "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/rc.sh
fi

# bash rc
for f in "${XDG_CONFIG_HOME:-$HOME/.config}"/bash/rc.d/*.bash; do
  # shellcheck disable=SC1090
  [[ -f "$f" ]] && source "$f"
done
