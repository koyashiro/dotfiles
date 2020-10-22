for f in $HOME/.bash/*.bash; do
  source $f
done

# wsl
if [[ -f $HOME/.wsl/.zshrc ]]; then
  source $HOME/.wsl/.zshrc
fi
