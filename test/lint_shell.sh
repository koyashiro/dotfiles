#!/bin/bash

if ! builtin command -v shellcheck > /dev/null; then
  # shellcheck disable=SC2016
  echo '`shellcheck` not found' 1>&2
  exit 1
fi

# sh
echo '#!/bin/sh\n' | cat - .profile | shellcheck -x -
for f in .config/sh/*.sh; do
  echo '#!/bin/sh\n' | cat - "$f" | shellcheck -
done

# bash
echo '#!/bin/bash\n' | cat - .bash_profile | shellcheck -x -
echo '#!/bin/bash\n' | cat - .bashrc | shellcheck -x -

# zsh
echo '#!/bin/bash\n' | cat - .zshenv | shellcheck -x -
echo '#!/bin/bash\n' | cat - .config/zsh/.zshenv | shellcheck -x -
echo '#!/bin/bash\n' | cat - .config/zsh/.zshrc | shellcheck -x -
