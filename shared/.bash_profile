# shellcheck shell=bash

# env
if [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/env.sh ]]; then
  # shellcheck source=shared/.config/sh/env.sh
  source "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/env.sh
fi

# .bashrc
if [[ -n "${PS1:-}" && -f "$HOME"/.bashrc ]]; then
  # shellcheck source=shared/.bashrc
  source "$HOME"/.bashrc
fi
