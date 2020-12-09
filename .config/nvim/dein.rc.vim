if !&compatible
  set nocompatible
endif

augroup MyAutoCmd
  autocmd!
augroup END

" dein installation check {{{
let s:dein_repo_dir = $XDG_CACHE_HOME . '/dein/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
execute 'set runtimepath^=' . s:dein_repo_dir
" }}}

" begin settings {{{
if dein#load_state($XDG_CACHE_HOME . '/dein')
  call dein#begin($XDG_CACHE_HOME . '/dein')
  call dein#load_toml($XDG_CONFIG_HOME . '/nvim/dein.toml', {'lazy': 0})
  call dein#load_toml($XDG_CONFIG_HOME . '/nvim/dein_lazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
" }}}

" plugin installation check {{{
if dein#check_install()
  call dein#install()
endif
" }}}
