function zle-keymap-select zle-line-init {
  case "$KEYMAP" in
    vicmd)
      echo -ne '\e[1 q'
      ;;
    main|viins)
      echo -ne '\e[5 q'
      ;;
    vivis|vivli)
      echo -ne '\e[1 q'
      ;;
  esac

  zle reset-prompt
  zle -R
}

zle -N zle-keymap-select
zle -N zle-line-init
