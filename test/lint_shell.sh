#!/bin/bash

if ! builtin command -v shellcheck > /dev/null; then
  # shellcheck disable=SC2016
  echo '`shellcheck` not found' 1>&2
  exit 1
fi

# sh
printf '#!/bin/sh\n' | cat - .profile | shellcheck -x -
for f in .config/sh/*.sh; do
  printf '#!/bin/sh\n' | cat - "$f" | shellcheck -
done

# bash
printf '#!/bin/bash\n' | cat - .bash_profile | shellcheck -x -
printf '#!/bin/bash\n' | cat - .bashrc | shellcheck -x -

# zsh
printf '#!/bin/bash\n' | cat - .zshenv | shellcheck -x -
printf '#!/bin/bash\n' | cat - .config/zsh/.zshenv | shellcheck -x -
printf '#!/bin/bash\n' | cat - .config/zsh/.zshrc | shellcheck -x -

# .local/bin
for f in .local/bin/*; do
  shellcheck "$f"
done
