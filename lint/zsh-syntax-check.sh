#!/usr/bin/env sh

set -eu

DOTDIR="$(cd "$(dirname "$0")" && cd .. && pwd)"
readonly DOTDIR

cd "$DOTDIR"

# Check syntax with zsh -n (read commands without executing them)
for f in shared/.zshenv shared/.zshrc shared/.config/zsh/.p10k.zsh shared/.config/zsh/*.zsh shared/.config/zsh/rc.d/*.zsh; do
  zsh -n "$f"
done
