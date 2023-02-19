# shellcheck shell=sh

# env
if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/env.sh ]; then
  # shellcheck source=shared/.config/sh/env.sh
  . "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/env.sh
fi

# rc
if [ -n "${PS1:-}" ]; then
  # shellcheck source=shared/.config/sh/alias.sh
  . "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/alias.sh

  # shellcheck source=shared/.config/sh/function.sh
  . "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/function.sh
fi
