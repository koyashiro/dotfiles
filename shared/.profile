# shellcheck shell=sh

# env
if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/env.sh ]; then
  # shellcheck source=shared/.config/sh/env.sh
  . "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/env.sh
fi

# rc
if [ -n "${PS1:-}" ] && [ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/rc.sh ]; then
  # shellcheck source=shared/.config/sh/rc.sh
  . "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/rc.sh
fi
