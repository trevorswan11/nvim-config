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
let mapleader = " "

" Plugin Install
call plug#begin()

Plug 'https://github.com/vim-airline/vim-airline' " Mode status bar
Plug 'https://github.com/preservim/nerdtree' " File tree
" Plug 'https://github.com/neoclide/coc.nvim' " Autocomplete

call plug#end()
" Airline Config


" NERDTree Config
nnoremap <leader>e :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Start nerd tree on open and move to last window
autocmd VimEnter * NERDTree | wincmd p

