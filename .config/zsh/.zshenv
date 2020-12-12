# .profile
if [[ -f "$HOME"/.profile ]]; then
  source "$HOME"/.profile
fi

# History file
if [[ ! -d "$XDG_DATA_HOME"/zsh ]]; then
  mkdir "$XDG_DATA_HOME"/zsh
fi
export HISTFILE="$XDG_DATA_HOME"/zsh/history

typeset -U path PATH
