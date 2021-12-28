let g:ale_disable_lsp = 1
call plug#begin('~/.config/.nvim/plugged')
" plugins between begin() and end()
" Utility
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/fzf'
" Git Support
Plug 'tpope/vim-fugitive'
" Theme/ Interface
Plug 'gruvbox-community/gruvbox'
" Plug 'preservim/vim-colors-pencil'
Plug 'vim-airline/vim-airline'
" dev env
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Olical/conjure', { 'for': 'clojure' }
" other 
Plug 'dense-analysis/ale'
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
call plug#end()

" basics
filetype plugin indent on
set number
"
" search down into subfolders- 
" tab completion for all file related tasks
set path+=**

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

" Theme and Styling
set termguicolors
" colorscheme gruvbox
colorscheme gruvbox

let mapleader=" "
let maplocalleader=","
inoremap jk <ESC>

" Searching
set ignorecase
set smartcase

" save undo trees in files
set undofile
set undodir=~/.config/nvim/undo

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

" statusbar
let g:airline_powerline_fonts = 1

function! TogBG()
    let &background = ( &background == "dark"? "light" : "dark" )
    if exists("g:colors_name")
        exe "colorscheme " . g:colors_name
    endif
endfunction
silent! map <F6> :call TogBG()<CR>

set re=0 " new regex engine
let g:ale_linters = { 
            \'clojure': ['clj-kondo'], 
            \'python': ['flake8', 'autopep8'], 
            \}

" lint on save only
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 0


" Map movement through errors without wrapping.
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)


"""""""""" COC """""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""

"" Use `[g` and `]g` to navigate diagnostics
"" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

"" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

"" Applying codeAction to the selected region.
"" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
"" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

"" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
