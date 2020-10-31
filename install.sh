#!/bin/bash

# dot files
for f in .??*; do
  [[ "$f" == '.config' ]] && continue
  [[ "$f" == '.git' ]] && continue
  [[ "$f" == '.gitattributes' ]] && continue
  [[ "$f" == '.gitignore' ]] && continue
  [[ "$f" == '.wsl' ]] && continue

  ln -fns "$(cd $(dirname $f) && pwd)/$(basename $f)" "$HOME/$f"
done

# $XDG_CONFIG_HOME or .config
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=$HOME/.config}

if [[ ! -d $XDG_CONFIG_HOME ]]; then
  mkdir $XDG_CONFIG_HOME
fi

for f in .config/??*; do
  ln -fns "$(cd $(dirname $f) && pwd)/$(basename $f)" "$XDG_CONFIG_HOME/$(basename $f)"
done

# wsl
if [[ -f /proc/sys/fs/binfmt_misc/WSLInterop ]]; then
  ln -fns "$(cd $(dirname .wsl) && pwd)/$(basename .wsl)" $HOME/.wsl
fi
