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

" lsp
if executable("nodejs") || executable("node")
  let s:lsp = "coc.nvim"
else
  let s:lsp = "vim-lsp"
endif

" map {{{
" leader
let mapleader = "\<Space>"

" Esc
inoremap <silent> jj <ESC>
inoremap <silent> っｊ <ESC>

" Indent
inoremap <S-Tab> <C-h>

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
  \     [ 'lsp_diagnostic_status','lsp_status', 'fileformat', 'fileencoding', 'devicons_filetype' ],
  \   ],
  \ },
  \ 'component_function': {
  \   'lsp_diagnostic_status': 'LightLineLSPDiagnosticStatus',
  \   'lsp_status': 'LightLineLSPStatus',
  \   'devicons_filetype': 'LightLineFileType',
  \   'gitbranch': 'LightLineGitBranch',
  \ },
  \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
  \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
  \ }

function! LightLineLSPDiagnosticStatus()
  let l:error_sign = ''
  let l:warning_sign = '⚠︎'

  if s:lsp == 'coc.nvim'
	  let l:info = get(b:, 'coc_diagnostic_info', {})
	  if empty(info)
      let l:info = { 'error': 0, 'warning': 0 }
    endif

	  let msgs = []
    call add(msgs, l:error_sign . ' ' . info['error'])
    call add(msgs, l:warning_sign . ' ' . info['warning'])

	  return join(msgs, ' ')
  elseif s:lsp == 'vim-lsp'
    try
      let l:counts = lsp#get_buffer_diagnostics_counts()
    catch
      return ''
    endtry

    let l:error_count = l:counts.error
    let l:warning_count = l:counts.warning

    return l:error_sign . ' ' . l:error_count . ' ' . l:warning_sign . ' ' . l:warning_count
  else
    return ''
  endif
endfunction

function! LightLineLSPStatus()
  if s:lsp == 'coc.nvim'
	  return get(g:, 'coc_status', '')
  else
    return ''
  endif
endfunction

if s:lsp == 'vim-lsp'
  augroup LightLineUpdateOnLSP
    autocmd!
    autocmd User lsp_diagnostics_updated call lightline#update()
  augroup END
endif

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
nnoremap <C-p> :<C-u>Files<CR>

" easy motion
Plug 'easymotion/vim-easymotion'

" coc.nvim {{{
if s:lsp == 'coc.nvim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  inoremap <silent><expr> <c-space> coc#refresh()

  inoremap <silent><expr> <Tab> pumvisible()
    \ ? coc#_select_confirm()
    \ : "\<Tab>"

  inoremap <silent><expr> <cr> pumvisible()
    \ ? coc#_select_confirm()
    \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  nnoremap <silent> K :call <SID>show_documentation()<CR>
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  nmap <leader>rn <Plug>(coc-rename)

  command! -nargs=0 Format :call CocAction('format')

  let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-yaml',
    \ 'coc-tsserver',
    \ 'coc-prettier',
    \ 'coc-eslint',
    \ 'coc-deno',
    \ 'coc-python',
    \ 'coc-html',
    \ 'coc-emmet',
    \ 'coc-sh',
    \ 'coc-vimlsp',
    \ 'coc-omnisharp',
    \ 'coc-go',
    \ 'coc-rust-analyzer',
    \ 'coc-solargraph',
    \ 'coc-markdownlint',
    \ ]
endif
" }}}

" asyncomplete {{{
if s:lsp == 'vim-lsp'
  Plug 'prabirshrestha/asyncomplete.vim'
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : "\<CR>"
  imap <c-space> <Plug>(asyncomplete_force_refresh)

  Plug 'prabirshrestha/asyncomplete-lsp.vim'

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
    autocmd! BufWritePre *.js,*.json,*.ts,*.rs,*.go call execute('LspDocumentFormatSync')

    let g:lsp_diagnostics_float_cursor = 1
    let g:lsp_diagnostics_signs_priority = 11
    let g:lsp_diagnostics_virtual_text_prefix = '    : '
  endfunction

  augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  augroup END

  let g:lsp_diagnostics_signs_error = {'text': ''}
  let g:lsp_diagnostics_signs_warning = {'text': ''}
  let g:lsp_diagnostics_signs_information = {'text': ''}
  let g:lsp_diagnostics_signs_hint = {'text': 'ﯦ'}

  Plug 'mattn/vim-lsp-settings'
endif
" }}}

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
