#!/usr/bin/env sh

set -eu

DOTDIR="$(cd "$(dirname "$0")" && cd .. && pwd)"
readonly DOTDIR

cd "$DOTDIR"

# install.sh
shellcheck install.sh
shellcheck test/install_test.sh

# lint
shellcheck lint/shellcheck.sh

# git
shellcheck shared/.config/git/prune-merged.sh

# sh
shellcheck --shell sh --external-source shared/.profile
shellcheck --shell sh --external-source shared/.config/sh/env.sh
shellcheck --shell sh --external-source shared/.config/sh/rc.sh
for f in "$DOTDIR"/shared/.config/sh/env.d/*.sh "$DOTDIR"/shared/.config/sh/rc.d/*.sh; do
  shellcheck --shell sh --external-source "$f"
done

# bash
shellcheck --shell bash --external-source shared/.bash_profile
shellcheck --shell bash --external-source shared/.bashrc
for f in "$DOTDIR"/shared/.config/bash/rc.d/*.bash; do
  shellcheck --shell bash --external-source "$f"
done

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
