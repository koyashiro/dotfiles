# .profile
if [[ -f $HOME/.profile ]]; then
  source $HOME/.profile
fi

# History file
if [[ ! -d $XDG_DATA_HOME/bash ]]; then
  mkdir $XDG_DATA_HOME/bash
fi
export HISTFILE=$XDG_DATA_HOME/bash/history

if [[ -f $HOME/.bashrc ]]; then
  source $HOME/.bashrc
fi
