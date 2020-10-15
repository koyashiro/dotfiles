for f in $HOME/.zsh/*.zsh; do
    source $f
done

# wsl
if [[ -f $HOME/.wsl/.zshrc ]]; then
    source $HOME/.wsl/.zshrc
fi

typeset -U path PATH

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
