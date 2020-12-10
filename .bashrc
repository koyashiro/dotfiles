if [[ -z "$PS1" ]]; then
  return
fi

# alias
if [[ -f "$XDG_CONFIG_HOME/zsh/alias.zsh" ]]; then
  source "$XDG_CONFIG_HOME/zsh/alias.zsh"
fi
