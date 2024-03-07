" Set auto path
cd C:\Users\Trevor\OneDrive\Documents\CWRU\Code

" QOL Configurations
set number
set relativenumber
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop
set mouse=a
set clipboard+=unnamedplus

" QOL Mappings
let mapleader = " "
nnoremap ; :

" Plugin Install
call plug#begin()

Plug 'https://github.com/nvim-treesitter/nvim-treesitter' " TS
Plug 'https://github.com/vim-airline/vim-airline' " Mode status bar
Plug 'https://github.com/preservim/nerdtree' " File tree
Plug 'https://github.com/neoclide/coc.nvim' " COC
Plug 'https://github.com/tpope/vim-fugitive' " Git integration
Plug 'https://github.com/preservim/tagbar' " Tagbar for variables
Plug 'https://github.com/ryanoasis/vim-devicons' " Dev Icons
Plug 'http://github.com/tpope/vim-surround' " Surround
Plug 'https://github.com/tpope/vim-commentary' " Commenting
Plug 'https://github.com/ap/vim-css-color' " CSS
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Colors!
Plug 'https://github.com/junegunn/fzf.vim' " File Finder - 1
Plug 'https://github.com/junegunn/fzf' " File Finder - 2
Plug 'https://github.com/prabirshrestha/vim-lsp' " lsp - 1
Plug 'https://github.com/mattn/vim-lsp-settings' "lsp - 2

call plug#end()

" COC config
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

" Airline Config
let g:airline#extensions#tabline#enabled = 1
let g:airline_statusline_ontop=1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts=1

" NERDTree Config
nnoremap <leader>e :NERDTreeFocus<CR>
nnoremap <leader>e :NERDTree<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" Start nerd tree window
autocmd VimEnter * NERDTree | wincmd p 

" Buffer Mappings
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprev<CR>
nnoremap <leader>x :bd<CR>

" Tagbar Config
nmap <F8> :TagbarToggle<CR>

" Color scheme change
colorscheme jellybeans

" File Finder
nnoremap <leader>h :FZF<CR>

" Auto complete delimiters and other common symbols
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap ' ''<Left>
inoremap " ""<Left>
inoremap < <><Left>

" Java block comments
function! AddBlockComment()
    if &filetype == 'java'
        let col = col('.') - 1
        let line = getline('.')
        let before = strpart(line, 0, col)
        let after = strpart(line, col)
        let line = before . "/* */" . after
        call setline('.', line)
        call cursor('.', col + 3)
    endif
endfunction

autocmd FileType java inoremap <buffer> <silent> /* <Esc>:call AddBlockComment()<CR>

if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

if executable('eclipse.jdt.ls')
    " Install eclipse.jdt.ls language server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'java',
        \ 'cmd': {server_info -> ['eclipse.jdt.ls']},
        \ 'allowlist': ['java'],
        \ })
endif

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
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
