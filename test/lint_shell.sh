#!/usr/bin/env bash

if ! builtin command -v shellcheck > /dev/null; then
  # shellcheck disable=SC2016
  echo '`shellcheck` not found' 1>&2
  exit 1
fi

shellcheck "$0"

# install.sh
shellcheck install.sh

# sh
printf '#!/usr/bin/env sh\n' | cat - profile | shellcheck -x -
for f in config/sh/*.sh; do
  printf '#!/usr/bin/env sh\n' | cat - "$f" | shellcheck -
done

# bash
printf '#!/usr/bin/env bash\n' | cat - bash_profile | shellcheck -x -
printf '#!/usr/bin/env bash\n' | cat - bashrc | shellcheck -x -

# zsh
printf '#!/usr/bin/env bash\n' | cat - zshenv | shellcheck -x -
printf '#!/usr/bin/env bash\n' | cat - config/zsh/.zshenv | shellcheck -x -
printf '#!/usr/bin/env bash\n' | cat - config/zsh/.zshrc | shellcheck -x -

# .local/bin
for f in local/bin/*; do
  shellcheck "$f"
done
