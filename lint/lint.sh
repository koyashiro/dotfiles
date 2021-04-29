#!/usr/bin/env sh

readonly DOTDIR="$HOME"/.dotfiles

cd "$DOTDIR"

# install.sh
shellcheck install.sh

# sh
shellcheck --shell sh --external-source profile
shellcheck --shell sh --external-source config/sh/env.sh
shellcheck --shell sh --external-source config/sh/alias.sh
shellcheck --shell sh --external-source config/sh/function.sh

# bash
shellcheck --shell bash --external-source bash_profile
shellcheck --shell bash --external-source bashrc

# zsh
shellcheck --shell bash --external-source zshenv
shellcheck --shell bash --external-source config/zsh/.zshenv
shellcheck --shell bash --external-source config/zsh/.zshrc
