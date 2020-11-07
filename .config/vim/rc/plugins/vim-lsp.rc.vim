" vim-lsp.rc.vim

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_text_edit_enabled = 1
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

nmap <buffer> gd <plug>(lsp-definition)
nmap <buffer> gr <plug>(lsp-references)
nmap <buffer> gi <plug>(lsp-implementation)
nmap <buffer> gt <plug>(lsp-type-definition)
nmap <buffer> <leader>rn <plug>(lsp-rename)
nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
nmap <buffer> K <plug>(lsp-hover)
