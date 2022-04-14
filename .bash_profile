# .bash_profile

# env
if [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/env.sh ]]; then
  # shellcheck source=config/sh/env.sh
  source "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/env.sh
fi

# .bashrc
if [[ -n "${PS1:-}" && -f "$HOME"/.bashrc ]]; then
  # shellcheck source=bashrc
  source "$HOME"/.bashrc
fi
