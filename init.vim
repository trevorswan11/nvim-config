" QOL Configurations
set number
set relativenumber
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=0
set mouse=a
set clipboard+=unnamedplus
set autochdir

" QOL Mappings
let mapleader = " "
nnoremap ; :
vnoremap ; :
vnoremap <Leader>pa :s/\\/\//g<CR>
nnoremap <Leader>e :Ex<CR>

" Plugin Install
call plug#begin()

Plug 'https://github.com/nvim-treesitter/nvim-treesitter' " TS
Plug 'https://github.com/vim-airline/vim-airline' " Airline
Plug 'https://github.com/vim-airline/vim-airline-themes' " Airline theme
Plug 'https://github.com/ryanoasis/vim-devicons' " Dev Icons
Plug 'http://github.com/tpope/vim-surround' " Surround
Plug 'https://github.com/prabirshrestha/vim-lsp' " lsp - 1
Plug 'https://github.com/mattn/vim-lsp-settings' " lsp - 2
Plug 'https://github.com/folke/tokyonight.nvim' " Colors!

call plug#end()

" Airline Config
let g:airline#extensions#tabline#enabled = 1
let g:airline_statusline_ontop=1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'

" Buffer Mappings
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprev<CR>
nnoremap <leader>x :bd<CR>

" Color scheme change
colorscheme tokyonight-moon

" LSP Config
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

" call s:on_lsp_buffer_enabled only for languages that has the server registered.
augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
