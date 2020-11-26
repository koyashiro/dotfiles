function fe() {
  local selected=$(fzf-tmux --preview "bat --color=always --style=header,grid --line-range :100 {}")

  if [[ -n "$selected" ]]; then
    $EDITOR $selected
  fi
}
