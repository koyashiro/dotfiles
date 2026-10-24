case "$TERM" in
  xterm-color | *-256color)
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
  *)
    PS1='\u@\h:\w\$ '
    ;;
esac

case "$TERM" in
  xterm* | rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
esac
