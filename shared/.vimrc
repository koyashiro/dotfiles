" XDG Base Directory {{{
if empty($XDG_DATA_HOME) | let $XDG_DATA_HOME = expnad('$HOME/.local/share') | endif
if empty($XDG_CONFIG_HOME) | let $XDG_CONFIG_HOME = expand('$HOME/.config') | endif
if empty($XDG_CACHE_HOME) | let $XDG_CACHE_HOME = expand('$HOME/.cache') | endif

if has('nvim')
  let s:data_home = expand('$XDG_DATA_HOME/nvim')
  let s:config_home = expand('$XDG_CONFIG_HOME/nvim')
  let s:cache_home = expand('$XDG_CACHE_HOME/nvim')
  let $MYVIMRC = expand('$XDG_CONFIG_HOME/nvim/init.vim')
  let g:netrw_home = expand('$XDG_CONFIG_HOME/nvim')
else
  let s:data_home = expand('$XDG_DATA_HOME/vim')
  let s:config_home = expand('$XDG_CONFIG_HOME/vim')
  let s:cache_home = expand('$XDG_CACHE_HOME/vim')
  let $MYVIMRC = expand('$XDG_CONFIG_HOME/vim/vimrc')
  let g:netrw_home = expand('$XDG_CACHE_HOME/vim')
  if !isdirectory(s:data_home) | call mkdir(s:data_home, 'p', 0700) | endif
  if !isdirectory(s:config_home) | call mkdir(s:config_home, 'p', 0700) | endif
  if !isdirectory(s:cache_home) | call mkdir(s:cache_home, 'p', 0700) | endif
  set undodir=$XDG_DATA_HOME/vim/undo | call mkdir(&undodir, 'p', 0700)
  set directory=$XDG_DATA_HOME/vim/swap | call mkdir(&directory, 'p', 0700)
  set backupdir=$XDG_DATA_HOME/vim/backup | call mkdir(&backupdir, 'p', 0700)
  set viewdir=$XDG_DATA_HOME/vim/view | call mkdir(&viewdir, 'p', 0700)
  set viminfo+='1000,n$XDG_DATA_HOME/vim/viminfo
  set runtimepath=$XDG_DATA_HOME/vim,$VIMRUNTIME,$XDG_DATA_HOME/vim/after
endif
" }}}

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
set signcolumn=yes

" cursor
set cursorline
set whichwrap=b,s,h,l,<,>,~,[,]

" window
set splitbelow
set splitright

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

" cmd line
set cmdheight=1

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
set tabstop=4
set shiftwidth=2

" eol, tab, space
set list
set listchars=eol:↲,tab:>-,space:.,trail:.

" folding
set foldmethod=manual

" netrwhist
let g:netrw_dirhistmax = 0

" no swapfile
set noswapfile

" mouse
set mouse=a

" map {{{
" leader
let mapleader = "\<Space>"

" Indent
inoremap <S-Tab> <C-h>

" move window
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}

" yank to clipboard
set clipboard+=unnamedplus

set scrolloff=4
