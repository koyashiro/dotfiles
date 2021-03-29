if empty($XDG_CONFIG_HOME)
  let $XDG_CONFIG_HOME = expand('~/.config')
endif

if file_readable($XDG_CONFIG_HOME . '/vim/vimrc')
  source $HOME . '/.config/vim/vimrc'
elseif file_readable($HOME . '/.vimrc')
  source $HOME . '/.vimrc'
endif
