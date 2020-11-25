# sh
for f in $XDG_CONFIG_HOME/sh/*.sh; do
  if [[ ! -f $f.zwc ]] || [[ $f -nt $f.zwc ]]; then
    zcompile $f
  fi

  source $f
done

# zsh
for f in $XDG_CONFIG_HOME/zsh/*.zsh; do
  if [[ ! -f $f.zwc ]] || [[ $f -nt $f.zwc ]]; then
    zcompile $f
  fi

  source $f
done
