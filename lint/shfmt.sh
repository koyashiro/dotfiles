#!/usr/bin/env sh

set -eu

DOTDIR="$(cd "$(dirname "$0")" && cd .. && pwd)"
readonly DOTDIR

cd "$DOTDIR"

# install.sh
shfmt -d -p -i 2 -bn -ci -sr install.sh

# sh
shfmt -d -p -i 2 -bn -ci -sr shared/.profile
shfmt -d -p -i 2 -bn -ci -sr shared/.config/sh/env.sh
shfmt -d -p -i 2 -bn -ci -sr shared/.config/sh/alias.sh
shfmt -d -p -i 2 -bn -ci -sr shared/.config/sh/function.sh

# bash
shfmt -d -ln bash -i 2 -bn -ci -sr shared/.bash_profile
shfmt -d -ln bash -i 2 -bn -ci -sr shared/.bashrc

# zsh
shfmt -d -i 2 -bn -ci -sr shared/.zshenv
shfmt -d -i 2 -bn -ci -sr shared/.zshrc

# local/bin
for f in "$DOTDIR"/shared/.local/bin/*; do
  shfmt -d -i 2 -bn -ci -sr "$f"
done

# wsl profile
shfmt -d -i 2 -bn -ci -sr windows/wsl/.config/wsl/env.sh

# wsl local/bin
for f in "$DOTDIR"/windows/wsl/.local/bin/*; do
  shfmt -d -i 2 -bn -ci -sr "$f"
done
