" dein
source $XDG_CONFIG_HOME/nvim/dein.rc.vim

"vimrc
source $HOME/.vimrc


" colorscheme
try
  colorscheme onedark
  let g:lightline.colorscheme = 'onedark'
catch
endtry
