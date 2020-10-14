" syntax
syntax enable
set smartindent
set wildmenu

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

set laststatus=2

set nowritebackup
set nobackup
set ambiwidth=double
set autoread
set visualbell
let g:molokai_original = 1
set expandtab
set tabstop=2
set shiftwidth=2
set ignorecase
set smartcase
set wrapscan
set tw=0
set list
set listchars=tab:>-,trail:.

"dein Scripts-----------------------------
if !&compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('$HOME/.cache/dein')
  call dein#begin('$HOME/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('$HOME/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " vimdoc-ja
  call dein#add('vim-jp/vimdoc-ja')

  " molokai
  call dein#add('tomasr/molokai')
  colorscheme molokai

  " status line
  call dein#add('itchyny/lightline.vim')
  let g:lightline = {
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
    \ }

  " You can specify revision/branch/tag.
  call dein#add('Shougo/deol.nvim', { 'rev': '01203d4c9' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------
