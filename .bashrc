for f in ${XDG_CONFIG_HOME:-$HOME/.config}/bash/*.bash; do
  source $f
done

# wsl
if [[ -f $HOME/.wsl/.zshrc ]]; then
  source $HOME/.wsl/.zshrc
fi
