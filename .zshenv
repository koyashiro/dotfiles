# .profile
if [[ -f $HOME/.profile ]]; then
  source $HOME/.profile
fi

# History file
export HISTFILE=$XDG_DATA_HOME/zsh/history

typeset -U path PATH
