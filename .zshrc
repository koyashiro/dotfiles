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

# sh
for f in $XDG_CONFIG_HOME/sh/*.sh; do
  if [[ ! -f $f.zwc ]] || [[ $f -nt $f.zwc ]]; then
    zcompile $f
  fi

  source $f
done

# zsh
for f in $XDG_CONFIG_HOME/zsh/*.zsh; do
  if [[ "$f" == "$XDG_CONFIG_HOME/zsh/zinit.zsh" ]]; then
    continue
  fi

  if [[ ! -f $f.zwc ]] || [[ $f -nt $f.zwc ]]; then
    zcompile $f
  fi

  source $f
done

# zinit
if [[ -f $XDG_CONFIG_HOME/zsh/zinit.zsh ]]; then
  if [[ ! -f "$XDG_CONFIG_HOME/zsh/zinit.zsh.zwc" ]] || [[ "$XDG_CONFIG_HOME/zsh/zinit.zsh" -nt "$XDG_CONFIG_HOME/zsh/zinit.zsh" ]]; then
    zcompile "$XDG_CONFIG_HOME/zsh/zinit.zsh"
  fi

  source "$XDG_CONFIG_HOME/zsh/zinit.zsh"
fi
