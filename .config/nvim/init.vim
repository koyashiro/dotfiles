"vimrc
if has('unix') || has('mac')
  source ~/.vimrc
elseif has('win32') || has('win64')
  source ~\_vimrc
endif
