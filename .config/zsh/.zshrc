# .zshrc

# History file
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}"/zsh/history
if [[ ! -d "$(dirname "$HISTFILE")" ]]; then
  mkdir -m 700 "$(dirname "$HISTFILE")"
fi
export HISTSIZE=1000000
export SAVEHIST=1000000

# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}"/p10k-instant-prompt-"$(id -u -n)".zsh ]]; then
  # shellcheck disable=SC1090
  source "${XDG_CACHE_HOME:-$HOME/.cache}"/p10k-instant-prompt-"$(id -u -n)".zsh
fi

# sh rc
for f in "${XDG_CONFIG_HOME:-$HOME/.config}"/sh/*.sh; do
  if [[ ! -f "$f".zwc ]] || [[ "$f" -nt "$f".zwc ]]; then
    zcompile "$f"
  fi

  # shellcheck disable=SC1090
  source "$f"
done

# zsh rc
for f in autoload.zsh bindkey.zsh fzf.zsh setopt.zsh zle.zsh zstyle.zsh zinit.zsh .p10k.zsh; do
  if [[ ! -f "$ZDOTDIR"/"$f".zwc ]] || [[ "$ZDOTDIR"/"$f" -nt "$ZDOTDIR"/"$f".zwc ]]; then
    zcompile "$ZDOTDIR"/"$f"
  fi

  # shellcheck disable=SC1090
  source "$ZDOTDIR"/"$f"
done
