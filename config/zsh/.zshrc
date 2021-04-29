# .zshrc

# tmux
function launch_tmux() {
  # tmux executable checking
  if ! builtin command -v tmux >/dev/null 2>&1; then
    echo 'launch_tmux: command not found: tmux' 1>&2
    return 127
  fi

  # fzf executable checking
  if ! builtin command -v fzf >/dev/null 2>&1; then
    echo 'launch_tmux: command not found: fzf' 1>&2
    return 127
  fi

  local sessions
  sessions=$(tmux list-sessions 2>/dev/null)
  if [[ -z "$sessions" ]]; then
    tmux -u new-session
    return
  fi

  local new_session
  new_session='Create New Session'
  local all_sessions
  all_sessions="${sessions}\n${new_session}:"

  local target_session
  target_session="$(echo "$all_sessions" | fzf | cut -d: -f1)"

  if [[ "$target_session" = "$new_session" ]]; then
    tmux -u new-session
  elif [[ -n "$target_session" ]]; then
    tmux -u attach-session -t "$target_session"
  else
    : # Start terminal normally
  fi
}

if [[ -z "$TMUX" && -z "$SSH_TTY" ]] && builtin command -v fzf >/dev/null 2>&1; then
  launch_tmux
fi

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
