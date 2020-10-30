for f in $ZDOTDIR/rc/*.zsh; do
  source $f
done

# wsl
if [[ -f $HOME/.wsl/.zshrc ]]; then
  source $HOME/.wsl/.zshrc
fi

typeset -U path PATH
