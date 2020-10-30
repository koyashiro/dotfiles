#!/bin/bash

# dot files
for f in .??*; do
  [[ "$f" == '.config' ]] && continue
  [[ "$f" == '.git' ]] && continue
  [[ "$f" == '.gitattributes' ]] && continue
  [[ "$f" == '.gitconfig.user' ]] && continue
  [[ "$f" == '.wsl' ]] && continue

  ln -fns "$(cd $(dirname $f) && pwd)/$(basename $f)" "$HOME/$f"
done

# $XDG_CONFIG_HOME or .config
for f in .config/??*; do
  ln -fns "$(cd $(dirname $f) && pwd)/$(basename $f)" "${XDG_CONFIG_HOME:-$HOME/.cache}/$(basename $f)"
done

# wsl
if [[ -f /proc/sys/fs/binfmt_misc/WSLInterop ]]; then
  ln -fns "$(cd $(dirname .wsl) && pwd)/$(basename .wsl)" $HOME/.wsl
fi
