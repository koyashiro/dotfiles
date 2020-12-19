"vimrc
source $HOME/.vimrc

" dein
source $XDG_CONFIG_HOME/nvim/dein.rc.vim

" colorscheme
try
  colorscheme onedark
  let g:lightline.colorscheme = 'onedark'
  set cmdheight=1
catch
endtry
