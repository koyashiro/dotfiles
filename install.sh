#!/bin/bash

dotpath=$HOME/dotfiles

for f in .??*; do
    [[ "$f" == '.git' ]] && continue
    [[ "$f" == '.editorconfig' ]] && continue
    [[ "$f" == '.gitattributes' ]] && continue
    [[ "$f" == '.gitconfig.user' ]] && continue

    ln -fs "$(cd $(dirname $f) && pwd)/$(basename $f)" "$HOME/$f"
done
