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

" Python
let g:python3_host_prog = 'python'

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

" folding
set foldmethod=marker

" mouse
set mouse=a

" map {{{
" leader
let mapleader = "\<Space>"

" Esc
inoremap <silent> jj <ESC>
inoremap <silent> っｊ <ESC>

" move window
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}

" vim-plug variables {{{
if has('nvim')
  let s:vim_plug_path = expand(stdpath('data') . '/site/autoload/plug.vim')
  let s:plugged_path = expand(stdpath('data') . '/plugged')
else
  if has('unix') || has('mac')
    let s:vim_plug_path = expand('~/.vim/autoload/plug.vim')
    let s:plugged_path = expand('~/.vim/plugged')
  elseif has('win32') || has('win64')
    let s:vim_plug_path = expand('~/vimfiles/autoload/plug.vim')
    let s:plugged_path = expand('~/vimfiles/plugged')
  endif
endif
let s:vim_plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
" }}}

" download vim-plug {{{
if !filereadable(s:vim_plug_path)
  echo 'download vim-plg to ' . s:vim_plug_path
  if has('unix') || has('mac')
    call system('curl -fLo ' . s:vim_plug_path . ' --create-dirs ' . s:vim_plug_url)
  elseif has('win32') || has('win64')
    echo 'download vim-plg to ' . s:vim_plug_path
    call system('powershell.exe -Command "iwr -useb ' . s:vim_plug_url . ' | ni -Force ' . s:vim_plug_path . '"')
  endif
endif
" }}}

" vim-plug plugins {{{
call plug#begin(s:plugged_path)
" colorscheme
Plug 'joshdick/onedark.vim'
Plug 'cocopon/iceberg.vim'
Plug 'ghifarit53/tokyonight-vim'

" status line {{{
Plug 'itchyny/lightline.vim'
let g:lightline = {
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \   ],
  \   'right': [
  \     [ 'lineinfo' ],
  \     [ 'percent' ],
  \     [ 'fileformat', 'fileencoding', 'devicons_filetype' ],
  \   ],
  \ },
  \ 'component_function': {
  \   'devicons_filetype': 'LightLineFileType',
  \   'gitbranch': 'LightLineGitBranch',
  \ },
  \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
  \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
  \ }

function! LightLineFileType()
  let l:file_type_icon = WebDevIconsGetFileTypeSymbol()
  return l:file_type_icon . ' ' . &filetype
endfunction

function! LightLineGitBranch()
  let l:branch_name = FugitiveHead()
  if strlen(l:branch_name)
    return "\ue0a0 " . l:branch_name
  else
    return ''
  endif
endfunction
" }}}

" filer
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
nnoremap <C-t> :NERDTreeToggle<CR>
Plug 'ryanoasis/vim-devicons'

" japanese documentation
Plug 'vim-jp/vimdoc-ja'

" surround
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
nnoremap <C-p> :<C-u>GFiles<CR>

" easy motion
Plug 'easymotion/vim-easymotion'

" lsp {{{
Plug 'prabirshrestha/vim-lsp'
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gs <plug>(lsp-document-symbol-search)
  nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gy <plug>(lsp-type-definition)
  nmap <buffer> <leader>rn <plug>(lsp-rename)
  nmap <buffer> [g <plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)
  inoremap <buffer> <expr><c-f> lsp#scroll(+4)
  inoremap <buffer> <expr><c-d> lsp#scroll(-4)

  let g:lsp_format_sync_timeout = 1000

  autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
Plug 'mattn/vim-lsp-settings'
" }}}

" completion
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : "\<CR>"

" snippet
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'prabirshrestha/asyncomplete-neosnippet.vim'
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
smap <expr> <Tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"

" EditorConfig
Plug 'editorconfig/editorconfig-vim'

" syntax
Plug 'sheerun/vim-polyglot'
Plug 'cespare/vim-toml'
Plug 'elzr/vim-json'

" git
if executable('git')
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
endif

" Markdown
if executable('node') && executable('yarn')
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install', 'for': 'markdown' }
else
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }
endif

" Emmet
Plug 'mattn/emmet-vim', { 'for': 'html' }
call plug#end()
" }}}

try
  colorscheme tokyonight
  let g:lightline.colorscheme = 'tokyonight'
catch
  echo 'colorscheme is not exists.'
endtry

try
  call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
    \ 'name': 'neosnippet',
    \ 'priority': -1,
    \ 'allowlist': ['*'],
    \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
    \ }))

  function! s:sort_by_priority_preprocessor(options, matches) abort
    let l:items = []

    for [l:source_name, l:matches] in items(a:matches)
      for l:item in l:matches['items']
        if stridx(l:item['word'], a:options['base']) == 0
          let l:item['priority'] =
            \ get(asyncomplete#get_source_info(l:source_name),'priority',0)
          call add(l:items, l:item)
        endif
      endfor
    endfor

    let l:items = sort(l:items, { a, b -> b['priority'] - a['priority'] })

    call asyncomplete#preprocess_complete(a:options, l:items)
  endfunction

  let g:asyncomplete_preprocessor = [function('s:sort_by_priority_preprocessor')]
catch
endtry
