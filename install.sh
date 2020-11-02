#!/bin/bash

export DOTDIR=$(dirname $(readlink -f build.sh))
echo $DOTDIR > $HOME/.dotfir

# dot files
for f in $DOTDIR/.??*; do
  [[ $(basename $f) == '.config' ]] && continue
  [[ $(basename $f) == '.git' ]] && continue
  [[ $(basename $f) == '.gitattributes' ]] && continue
  [[ $(basename $f) == '.gitignore' ]] && continue

  ln -fns $f $HOME/$(basename $f)
done

# $XDG_CONFIG_HOME or .config
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=$HOME/.config}
[[ ! -d $XDG_CONFIG_HOME ]] && mkdir $XDG_CONFIG_HOME
for f in $DOTDIR/.config/??*; do
  [[ $(basename $f) == 'wsl' ]] && continue

  ln -fns $f $XDG_CONFIG_HOME/$(basename $f)
done

# $HOME/bin
[[ ! -d $HOME/bin ]] && mkdir $HOME/bin
for f in $DOTDIR/bin/??*; do
  ln -fns $f $HOME/bin/$(basename $f)
done

# wsl
if [[ -f /proc/sys/fs/binfmt_misc/WSLInterop ]]; then
  ln -fns $DOTDIR/.config/wsl $XDG_CONFIG_HOME/wsl
fi
