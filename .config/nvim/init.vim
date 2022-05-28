let g:ale_disable_lsp = 1
call plug#begin('~/.config/nvim/plugged')
" Utility
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/fzf.vim'
" Git Support
Plug 'tpope/vim-fugitive'
" Theme/Interface
Plug 'gruvbox-community/gruvbox'
Plug 'preservim/vim-colors-pencil'
Plug 'vim-airline/vim-airline'
" dev env
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Olical/conjure', { 'for': 'clojure' }
Plug 'tpope/vim-dispatch'
Plug 'clojure-vim/vim-jack-in'
" Only in Neovim:
Plug 'radenling/vim-dispatch-neovim'
" other 
Plug 'dense-analysis/ale'
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'vimwiki/vimwiki'

call plug#end()

" basics
filetype plugin indent on
set title
set number
set mouse=a
" Searching
set ignorecase
set smartcase
" search down into subfolders- 
" tab completion for all file related tasks
set path+=**
set rtp+=/opt/homebrew/opt/fzf
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

" Enable folding (press za)
set foldmethod=indent
set foldlevel=99

set cursorline " Enable highlighting of the current line
set termguicolors
" colorscheme gruvbox
colorscheme pencil

let mapleader=" "
let maplocalleader=","
inoremap jk <ESC>
" save undo trees in files
set undofile
set undodir=~/.config/nvim/undo
" number of undo saved
set undolevels=1000
" Replace ex mode with gq
map Q gq

" Word Processor mode - writing
function! WordProcessorMode()
        setlocal formatoptions=1
        setlocal noexpandtab
        map j gj
        map k gk
        setlocal spell spelllang=en_gb
        set complete+=s
        set thesaurus+=/Users/nehe/.config/nvim/thesaurus/mthesaur.txt
        set formatprg=par
        setlocal wrap
        setlocal linebreak
        inoremap . .<C-g>u
        inoremap ! !<C-g>u
        inoremap ? ?<C-g>u
        inoremap : :<C-g>u
    endfunction
map <leader>p :call WordProcessorMode()<CR>


function! TogBG()
    let &background = ( &background == "dark" ? "light" : "dark" )
    if exists("g:colors_name")
        exe "colorscheme " . g:colors_name
    endif
endfunction
silent! map <F6> :call TogBG()<CR>

map <leader>n :NERDTreeToggle<CR>

" statusbar
let g:airline_powerline_fonts = 1
let g:airline#extensions#wordcount#filetypes = '\vasciidoc|help|mail|markdown|vimwiki|org|rst|tex|text'

" vimwiki
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{
            \ 'syntax': 'markdown', 
            \ 'ext': '.md',
            \ 'path': '$HOME/Documents/', 
            \ 'template_path': '$HOME/.pandoc/',
            \ 'template_default':'Github',
            \ 'template_ext':'.html5',
            \ 'path_html': '$HOME/Documents/_site',
            \ 'custom_wiki2html': '$HOME/Documents/wiki2html.sh',
            \ 'auto_tags': 1,
            \ 'links_space_char' : '_',
            \ }]
let g:vimwiki_folding='expr'

" ale
let g:ale_linters = { 
            \'clojure': ['clj-kondo'], 
            \'python': ['flake8', 'mypy', 'pylint', 'pyright'],
            \'markdown' : ['vale']
            \}

" Map movement through errors without wrapping.
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)
