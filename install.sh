#!/bin/bash

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

export DOTDIR=$(dirname $(readlink -f $0))
echo $DOTDIR > $HOME/.dotdir

# dot files
for f in $DOTDIR/.??*; do
  [[ $(basename $f) == '.config' ]] && continue
  [[ $(basename $f) == '.git' ]] && continue
  [[ $(basename $f) == '.gitattributes' ]] && continue
  [[ $(basename $f) == '.gitignore' ]] && continue
  [[ $(basename $f) == '.local' ]] && continue

  ln -fns $f $HOME/$(basename $f)
done

# $XDG_CONFIG_HOME
[[ ! -d $XDG_CONFIG_HOME ]] && mkdir $XDG_CONFIG_HOME;:
for f in $DOTDIR/.config/??*; do
  ln -fns $f $XDG_CONFIG_HOME/$(basename $f)
done

# $XDG_DATA_HOME
[[ ! -d $XDG_DATA_HOME ]] && mkdir $XDG_DATA_HOME;:
for f in $DOTDIR/.local/share/??*; do
  ln -fns $f $XDG_DATA_HOME/$(basename $f)
done

# $HOME/bin
[[ ! -d $HOME/bin ]] && mkdir $HOME/bin;:
for f in $DOTDIR/bin/??*; do
  ln -fns $f $HOME/bin/$(basename $f)
done
