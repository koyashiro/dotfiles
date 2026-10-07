# .zshenv

# env
# Read POSIX sh files with sh semantics (unmatched globs, word splitting).
if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/env.sh ]; then
  emulate sh -c '. "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/env.sh'
fi

# shellcheck disable=SC2034
typeset -U path PATH

# shellcheck disable=SC2034
skip_global_compinit=1
