function install_powerline_shell() {
  if builtin command -v pip3 >& /dev/null; then
    echo 'zsh: install `powerline-shell` by `pip3`.'
    pip3 install powerline-shell

    if [[ "$?" == '0' ]]; then
      echo 'zsh: `powerline-shell` is installed.'
    fi
  elif builtin command -v pip >& /dev/null; then
    if [[ "$(pip --version)" =~ '\(python 3\.[0-9]\)' ]]; then
      echo 'zsh: install `powerline-shell` by `pip`.'
      pip install powerline-shell

      if [[ "$?" == '0' ]]; then
        echo 'zsh: `powerline-shell` installed.'
      fi
    fi
  fi
}

if ! builtin command -v powerline-shell >& /dev/null; then
  echo 'zsh: `powerline-shell is not installed.`'

  # install `powerline-shell`
  install_powerline_shell

  if ! builtin command -v powerline-shell >& /dev/null; then
    return
  fi
fi

function powerline_precmd() {
  POWERLINE_SHELL_EXITCODE=$?
  PS1="$(powerline-shell --shell zsh $POWERLINE_SHELL_EXITCODE)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
  install_powerline_precmd
fi

export VIMODE='INSERT'
function zle-keymap-select zle-line-init {
  case "$KEYMAP" in
    vicmd)
      export VIMODE='NORMAL'
      echo -ne '\e[1 q'
      ;;
    main|viins)
      export VIMODE='INSERT'
      echo -ne '\e[5 q'
      ;;
    vivis|vivli)
      export VIMODE='VISUAL'
      echo -ne '\e[1 q'
      ;;
  esac

  PS1="$(powerline-shell --shell zsh $POWERLINE_SHELL_EXITCODE)"
  zle reset-prompt
}

zle -N zle-keymap-select
zle -N zle-line-init
