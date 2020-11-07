if has('unix') || has('mac')
  source $XDG_CONFIG_HOME/vim/vimrc
endif

if has('win32') || has('win64')
  source $HOME/_vimrc
endif
