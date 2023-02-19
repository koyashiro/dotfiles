#!/usr/bin/env sh

set -eu

DOTDIR="$(cd "$(dirname "$0")" && cd .. && pwd)"
readonly DOTDIR

cd "$DOTDIR"

# install.sh
shellcheck install.sh

# sh
shellcheck --shell sh --external-source shared/.profile
shellcheck --shell sh --external-source shared/.config/sh/env.sh
shellcheck --shell sh --external-source shared/.config/sh/alias.sh
shellcheck --shell sh --external-source shared/.config/sh/function.sh

# bash
shellcheck --shell bash --external-source shared/.bash_profile
shellcheck --shell bash --external-source shared/.bashrc

# local/bin
for f in "$DOTDIR"/shared/.local/bin/*; do
  shellcheck "$f"
done

# wsl env
shellcheck --shell sh windows/wsl/.config/wsl/env.sh

# wsl local/bin
for f in "$DOTDIR"/windows/wsl/.local/bin/*; do
  shellcheck "$f"
done
