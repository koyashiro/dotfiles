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
set ignorecase
set smartcase
set wrapscan

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

" hel and decimal
set nrformats=hex

" don't create backup
set nowritebackup
set nobackup

" auto refresh changed content
set autoread

" disable beeping
set visualbell t_vb=
set noerrorbells

" tab
set expandtab
set tabstop=2
set shiftwidth=2

" eol, tab, space
set list
set listchars=eol:↲,tab:>-,space:.,trail:.

" map
source $XDG_CONFIG_HOME/vim/rc/map.rc.vim
