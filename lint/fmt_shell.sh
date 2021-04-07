#!/usr/bin/env bash

if ! builtin command -v shfmt > /dev/null; then
  # shellcheck disable=SC2016
  echo '`shfmt` not found' 1>&2
  exit 1
fi

shellcheck -x .profile
shellcheck -x .bash_profile
shellcheck -x .bashrc
shellcheck .config/sh/env.sh
shellcheck .config/sh/alias.sh
shellcheck .config/sh/function.sh
