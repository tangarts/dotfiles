call plug#begin('~/.vim/plugged')
" plugins between begin() and end()
" Utility
Plug 'scrooloose/nerdtree'
" Generic programming support
Plug 'vim-syntastic/syntastic'
" Git Support
Plug 'tpope/vim-fugitive'
" Theme/ Interface
Plug 'gruvbox-community/gruvbox'
Plug 'vim-airline/vim-airline'
" dev env
Plug 'tpope/vim-fireplace'
" other 
Plug 'junegunn/goyo.vim'
"Plug 'dpelle/vim-LanguageTool'
"Plug 'dense-analysis/ale'
call plug#end()

" basics
syntax on
set encoding=utf-8
filetype plugin indent on

set showcmd
set number
set ruler

" search down into subfolders- 
" tab completion for all file related tasks
set path+=**

" Display all matching files when tab complete
set wildmenu

" access system clipboard
set clipboard=unnamed 

" split screen opens to the right and below
set splitright splitbelow

" shortcutting split navigation, saves a keypress
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Whitespace
set softtabstop=4
set shiftwidth=4
set expandtab
" set smarttab
set autoindent

" Enable folding (press za)
set foldmethod=indent
set foldlevel=99

set cursorline " Enable highlighting of the current line

" Theme and Styling
set termguicolors
let g:gruvbox_contrast_light='hard'
colorscheme gruvbox

let mapleader=" "
inoremap jk <ESC>

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" save undo trees in files
set undofile
set undodir=~/.vim/undo

" number of undo saved
set undolevels=10000 

set clipboard^=unnamedplus

" Word Processor mode - writing
function! WordProcessorMode()
        setlocal formatoptions=1
        setlocal noexpandtab
        map j gj
        map k gk
        setlocal spell spelllang=en_gb
        set complete+=s
        set formatprg=par
        setlocal wrap
        setlocal linebreak
endfunction
map <leader>w :call WordProcessorMode()<CR>

" statusbard
set laststatus=2
let g:airline_powerline_fonts = 1

" let g:languagetool_jar='$XDG_DATA_HOME/LanguageTool-5.3/languagetool-commandline.jar'
" let g:languagetool_disable_rules='WORD_CONTAINS_UNDERSCORE,CURRENCY,ARROWS,EN_QUOTES'
