# .zshrc

# History file
if [[ ! -d "${XDG_STATE_HOME:-$HOME/.local/state}"/zsh ]]; then
  mkdir -m 700 "${XDG_STATE_HOME:-$HOME/.local/state}"/zsh
fi
export HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}"/zsh/history
export HISTSIZE=1000000
export SAVEHIST=1000000

# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}"/p10k-instant-prompt-"$(id -u -n)".zsh ]]; then
  # shellcheck disable=SC1090
  source "${XDG_CACHE_HOME:-$HOME/.cache}"/p10k-instant-prompt-"$(id -u -n)".zsh
fi

# sh rc
# Read POSIX sh files with sh semantics; functions defined there keep it too.
if [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/rc.sh ]]; then
  emulate sh -c '. "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/rc.sh'
fi

# zsh rc
for f in autoload.zsh bindkey.zsh setopt.zsh zle.zsh zstyle.zsh zinit.zsh .p10k.zsh "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/rc.d/*.zsh(N); do
  f="${f#"${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/}"
  if [[ ! -f "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/"$f".zwc ]] || [[ "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/"$f" -nt "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/"$f".zwc ]]; then
    zcompile "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/"$f"
  fi

  # shellcheck disable=SC1090
  source "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/"$f"
done
