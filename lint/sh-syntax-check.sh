#!/usr/bin/env sh

set -eu

DOTDIR="$(cd "$(dirname "$0")" && cd .. && pwd)"
readonly DOTDIR

cd "$DOTDIR"

# Check syntax with sh -n (read commands without executing them)
for f in install.sh test/install_test.sh lint/*.sh \
  shared/.profile shared/.config/sh/env.sh shared/.config/sh/rc.sh \
  shared/.config/sh/env.d/*.sh shared/.config/sh/rc.d/*.sh \
  shared/.config/git/prune-merged.sh windows/wsl/.config/wsl/env.sh; do
  sh -n "$f"
done

for f in shared/.local/bin/* windows/wsl/.local/bin/*; do
  case "$(head -n 1 "$f")" in
    *bash*) ;;
    *) sh -n "$f" ;;
  esac
done
