#!/bin/bash

if ! builtin command -v shellcheck > /dev/null; then
  # shellcheck disable=SC2016
  echo '`shellcheck` not found' 1>&2
  exit 1
fi

shellcheck -x .profile
shellcheck -x .bash_profile
shellcheck -x .bashrc
shellcheck .config/sh/env.sh
shellcheck .config/sh/alias.sh
shellcheck .config/sh/function.sh
