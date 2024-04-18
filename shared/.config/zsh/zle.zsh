function zle-keymap-select() {
  _update_prompt
}

function zle-line-init() {
  _update_prompt
}

function _update_prompt() {
  case "$KEYMAP" in
    vicmd)
      echo -ne '\e[1 q'
      ;;
    main | viins)
      echo -ne '\e[5 q'
      ;;
    vivis | vivli)
      echo -ne '\e[1 q'
      ;;
  esac

  zle reset-prompt
  zle -R
}

zle -N zle-keymap-select
zle -N zle-line-init
