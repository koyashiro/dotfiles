if [[ -z "$PS1" ]]; then
  return
fi

# tmux
function launch_tmux() {
  local sessions=$(tmux list-sessions >& /dev/null)
  if [[ -z "$sessions" ]]; then
    tmux -u new-session
    return
  fi

  local new_session='Create New Session'
  local all_sessions="$sessions\n$new_session:"

  local target_session="$(echo $all_sessions | fzf | cut -d: -f1)"

  if [[ "$target_session" = "$new_session" ]]; then
    tmux -u new-session
  elif [[ -n "$target_session" ]]; then
    tmux -u attach-session -t "$target_session"
  else
    : # Start terminal normally
  fi
}

if [[ -z "$TMUX" ]]; then
  launch_tmux
fi

# zsh
for f in $ZDOTDIR/rc/*.zsh; do
  if [[ "$f" == "$ZDOTDIR/rc/zinit.zsh" ]]; then
    continue
  fi

  if [[ ! -f $f.zwc ]] || [[ $f -nt $f.zwc ]]; then
    zcompile $f
  fi

  source $f
done

# zinit
if [[ -f $ZDOTDIR/rc/zinit.zsh ]]; then
  if [[ ! -f "$ZDOTDIR/rc/zinit.zsh.zwc" ]] || [[ "$ZDOTDIR/rc/zinit.zsh" -nt "$ZDOTDIR/rc/zinit.zsh" ]]; then
    zcompile "$ZDOTDIR/rc/zinit.zsh"
  fi

  source "$ZDOTDIR/rc/zinit.zsh"
fi
