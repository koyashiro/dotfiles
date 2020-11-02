# .profile
if [[ -f $HOME/.profile ]]; then
  source $HOME/.profile
fi

# History file
export HISTFILE=$XDG_DATA_HOME/zsh/history

# wsl
if [[ -f $HOME/.wsl/.zshenv ]]; then
  source $HOME/.wsl/.zshenv
fi

typeset -U path PATH
