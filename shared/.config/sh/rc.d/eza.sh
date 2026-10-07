# shellcheck shell=sh

if command -v eza >/dev/null 2>&1; then
  alias ll='eza -alhg -F always --time-style iso --icons --git'
  alias tree='eza --tree -a --git-ignore --icons --ignore-glob=".git"'
fi
