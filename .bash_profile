# .profile
if [[ -f $HOME/.profile ]]; then
  source $HOME/.profile
fi

# History file
export HISTFILE=$XDG_DATA_HOME/bash/history

# wsl
if [[ -f $XDG_CONFIG_HOME/wsl/profile.sh ]]; then
  source $XDG_CONFIG_HOME/wsl/profile.sh
fi
