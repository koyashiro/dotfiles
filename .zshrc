# sh
for f in $XDG_CONFIG_HOME/sh/*.sh; do
  source $f
done

# zsh
for f in $XDG_CONFIG_HOME/zsh/*.zsh; do
  source $f
done
