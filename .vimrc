" syntax
syntax enable
set smartindent
set wildmenu

" filetype
filetype on
filetype plugin indent on

" color
set background=dark
set t_Co=256
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum""]"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum""]"
set termguicolors

" encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,shift-jis
set fileformats=unix,dos,mac

" row number
set number

" cursor
set cursorline

" search
set hlsearch
set incsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" tab line
set showtabline=2

" status line
set laststatus=2
set noshowmode

" Python
let g:python3_host_prog = 'python'

" clipboard
set clipboard+=unnamedplus

" viminfo
set viminfo+=n"$XDG_DATA_HOME/vim/viminfo"

set nowritebackup
set nobackup
set autoread
set visualbell
set expandtab
set tabstop=2
set shiftwidth=2
set ignorecase
set smartcase
set wrapscan
set tw=0
set list
set listchars=tab:>-,trail:.,eol:↲,

" map
source $XDG_CONFIG_HOME/vim/rc/map.rc.vim
