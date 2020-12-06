"vimrc
source $HOME/.vimrc

" viminfo
set viminfo+=n"$XDG_DATA_HOME/nvim/viminfo"

" dein
let g:lsp_type = 'coc'
source $XDG_CONFIG_HOME/nvim/dein.rc.vim

" colorscheme
colorscheme iceberg
let g:lightline.colorscheme = 'iceberg'
