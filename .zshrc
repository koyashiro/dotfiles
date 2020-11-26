# tmux
function launch_tmux() {
  local sessions=$(tmux list-sessions)
  if [[ -z "$sessions" ]]; then
    tmux -u new-session
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
  if [[ ! -f $f.zwc ]] || [[ $f -nt $f.zwc ]]; then
    zcompile $f
  fi

  source $f
done
