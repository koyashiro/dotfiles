#!/bin/bash

# .bash_profile

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share

# env
if [[ -f "$XDG_CONFIG_HOME"/sh/env.sh ]]; then
  # shellcheck source=.config/sh/env.sh
  source "$XDG_CONFIG_HOME"/sh/env.sh
fi

# .bashrc
if [[ -n "$PS1" && -f "$HOME"/.bashrc ]]; then
  # shellcheck source=.bashrc
  source "$HOME"/.bashrc
fi
