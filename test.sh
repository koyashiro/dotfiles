#!/usr/bin/env bash

if ! builtin command -v shellcheck > /dev/null; then
  # shellcheck disable=SC2016
  echo '`shellcheck` not found' 1>&2
  exit 1
fi

shellcheck "$0"

for f in test/*; do
  echo "$f"
  shellcheck "$f"
  "$f"
done
