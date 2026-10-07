#!/usr/bin/env sh

set -eu

DOTDIR="$(cd "$(dirname "$0")" && cd .. && pwd)"
readonly DOTDIR

cd "$DOTDIR"

# Check syntax with bash -n (read commands without executing them)
for f in shared/.bash_profile shared/.bashrc shared/.config/bash/rc.d/*.bash; do
  bash -n "$f"
done

for f in shared/.local/bin/* windows/wsl/.local/bin/*; do
  case "$(head -n 1 "$f")" in
    *bash*) bash -n "$f" ;;
  esac
done
