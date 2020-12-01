if ! builtin command -v powerline-shell >& /dev/null; then
  exit
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
      ;;
    main|viins)
      export VIMODE='INSERT'
      ;;
    vivis|vivli)
      export VIMODE='VISUAL'
      ;;
  esac

  PS1="$(powerline-shell --shell zsh $POWERLINE_SHELL_EXITCODE)"
  zle reset-prompt
}

zle -N zle-keymap-select
zle -N zle-line-init
