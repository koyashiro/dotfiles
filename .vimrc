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

" bindings
let mapleader = "\<Space>"
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
inoremap <silent> jj <ESC>

" Python
if has('unix') || has('mac')
  let g:python3_host_prog = substitute(system('builtin command -v python3'), '\n', '', '')
endif

if has('win32') || has('win64')
  let g:python3_host_prog = substitute(system('where python'), '\n', '', '')
endif

set nowritebackup
set nobackup
set ambiwidth=double
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

" dein
source ~/.vim/rc/dein.rc.vim
