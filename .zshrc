for f in $HOME/.zsh/*.zsh; do
  source $f
done

# wsl
[[ -f $HOME/.wsl/.zshrc ]] && source $HOME/.wsl/.zshrc

typeset -U path PATH

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
