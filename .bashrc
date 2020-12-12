if [[ -z "$PS1" ]]; then
  return
fi

# alias
if [[ -f "$ZDOTDIR"/rc/alias.zsh ]]; then
  source "$ZDOTDIR"/rc/alias.zsh
fi
