# .profile
if [[ -f $HOME/.profile ]]; then
  source $HOME/.profile
fi

# History file
export HISTFILE=$XDG_DATA_HOME/bash/history

# wsl
if [[ -f $HOME/.wsl/.zshenv ]]; then
  source $HOME/.wsl/.zshenv
fi
