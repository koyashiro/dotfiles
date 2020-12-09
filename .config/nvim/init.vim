"vimrc
source $HOME/.vimrc

" viminfo
set viminfo&
set viminfo+=n"$XDG_DATA_HOME/nvim/viminfo"

" dein
source $XDG_CONFIG_HOME/nvim/dein.rc.vim

" colorscheme
colorscheme iceberg
let g:lightline.colorscheme = 'iceberg'
