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
nnoremap <leader>11 :LspDocumentFormat<CR>
vnoremap ; :
vnoremap <Leader>pa :s/\\/\//g<CR>

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
Plug 'https://github.com/uiiaoo/java-syntax.vim' " java syntax
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin' " NERDTree git

call plug#end()

" COC config
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

" Airline Config
let g:airline#extensions#tabline#enabled = 1
let g:airline_statusline_ontop=1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1

" NERDTree Config
nnoremap <leader>e :NERDTreeFocus<CR>
nnoremap <leader>e :NERDTree<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" Start nerd tree window
autocmd VimEnter * NERDTree | wincmd p 

" Show git status
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeGitStatusNodeColorization = 1
let g:NERDTreeColorMapCustom = {
    \ "Staged"    : "#0ee375",  
    \ "Modified"  : "#d9bf91",  
    \ "Renamed"   : "#51C9FC",  
    \ "Untracked" : "#FCE77C",  
    \ "Unmerged"  : "#FC51E6",  
    \ "Dirty"     : "#FFBD61",  
    \ "Clean"     : "#87939A",   
    \ "Ignored"   : "#808080"   
    \ }
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
               \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

" Bind .. to previous directory
autocmd FileType nerdtree nnoremap <buffer> <leader>.. :call NERDTreeGoUp()<CR>

function! NERDTreeGoUp()
    let l:current_path = expand('%:p:h')
    execute 'cd ' . l:current_path
    NERDTreeFind
endfunction

" Buffer Mappings
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprev<CR>
nnoremap <leader>x :bd<CR>

" Tagbar Config
nmap <F8> :TagbarToggle<CR>

" Color scheme change
colorscheme sonokai 

" File Finder - first one is full dir, second is code dir
" nnoremap <leader>h :FZF ~<CR>
nnoremap <leader>h :cd C:\Users\Trevor\OneDrive\Documents\CWRU\Code<CR>:FZF<CR>

" Auto complete delimiters and other common symbols
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap ' ''<Left>
inoremap " ""<Left>

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
    
    " refer to doc to add more commands
endfunction

" call s:on_lsp_buffer_enabled only for languages that has the server registered.
augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
