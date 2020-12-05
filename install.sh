#!/usr/bin/env bash

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

dotdir=$(cd $(dirname "$0");pwd)

# dot files
for f in $dotdir/.??*; do
  [[ $(basename $f) == '.config' ]] && continue
  [[ $(basename $f) == '.git' ]] && continue
  [[ $(basename $f) == '.gitattributes' ]] && continue
  [[ $(basename $f) == '.gitignore' ]] && continue
  [[ $(basename $f) == '.local' ]] && continue

  ln -fns $f $HOME/$(basename $f)
done

# $XDG_CONFIG_HOME
[[ ! -d $XDG_CONFIG_HOME ]] && mkdir $XDG_CONFIG_HOME;:
for f in $dotdir/.config/??*; do
  ln -fns $f $XDG_CONFIG_HOME/$(basename $f)
done

# $XDG_DATA_HOME
[[ ! -d $XDG_DATA_HOME ]] && mkdir $XDG_DATA_HOME;:
for f in $dotdir/.local/share/??*; do
  ln -fns $f $XDG_DATA_HOME/$(basename $f)
done

# $HOME/bin
[[ ! -d $HOME/bin ]] && mkdir $HOME/bin;:
for f in $dotdir/bin/??*; do
  ln -fns $f $HOME/bin/$(basename $f)
done
