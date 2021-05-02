#!/usr/bin/env sh

readonly DOTDIR="$HOME"/.dotfiles

cd "$DOTDIR"

# install.sh
shfmt -d install.sh

# sh
shfmt -d -p -i 2 profile
shfmt -d -p -i 2 config/sh/env.sh
shfmt -d -p -i 2 config/sh/alias.sh
shfmt -d -p -i 2 config/sh/function.sh

# bash
shfmt -d -ln bash -i 2 bash_profile
shfmt -d -ln bash -i 2 bashrc

# zsh
shfmt -d -i 2 zshenv
shfmt -d -i 2 config/zsh/.zshenv
shfmt -d -i 2 config/zsh/.zshrc

# local/bin
for f in "$DOTDIR"/local/bin/*; do
  shfmt -d -i 2 "$f"
done
