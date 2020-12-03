" map.rc.vim

" leader
let mapleader = "\<Space>"

" Esc
inoremap <silent> jj <ESC>
inoremap <silent> っｊ <ESC>

" move coursor in insert mode
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>

" move window
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

map <silent> tc :tablast <bar> tabnew<CR>
map <silent> tq :tabclose<CR>
map <silent> tn :tabnext<CR>
map <silent> tp :tabprevious<CR>
