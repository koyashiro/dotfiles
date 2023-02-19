# .zshenv

# env
if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/env.sh ]; then
  # shellcheck source=config/sh/env.sh
  source "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/env.sh
fi

# shellcheck disable=SC2034
typeset -U path PATH

# shellcheck disable=SC2034
skip_global_compinit=1
