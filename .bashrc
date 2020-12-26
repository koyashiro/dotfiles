# .bashrc

# interactive checking
if [[ -z "$PS1" ]]; then
  return
fi

# History file
export HISTFILE="$XDG_DATA_HOME"/bash/history
if [[ ! -d "$(dirname $HISTFILE)" ]]; then
  mkdir -m 700 "$(dirname "$HISTFILE")"
fi
export HISTSIZE=1000000
export SAVEHIST=1000000

# alias
if [[ -f "$XDG_CONFIG_HOME"/sh/alias.sh ]]; then
  source "$XDG_CONFIG_HOME"/sh/alias.sh
fi

# function
if [[ -f "$XDG_CONFIG_HOME"/sh/function.sh ]]; then
  source "$XDG_CONFIG_HOME"/sh/function.sh
fi
