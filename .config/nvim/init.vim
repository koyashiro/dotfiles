if empty($XDG_CONFIG_HOME)
  let $XDG_CONFIG_HOME = expand('$HOME/.config')
endif

if empty($MYVIMRC) | let $MYVIMRC = expand('<sfile>:p') | endif

if file_readable($XDG_CONFIG_HOME . '/vim/vimrc')
  source $XDG_CONFIG_HOME/vim/vimrc
elseif file_readable($HOME . '/.vimrc')
  source $HOME/.vimrc
elseif file_readable($HOME . '/_vimrc')
  source $HOME/_vimrc
endif
