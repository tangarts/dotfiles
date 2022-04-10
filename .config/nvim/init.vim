let g:ale_disable_lsp = 1
call plug#begin('~/.config/nvim/plugged')
" Utility
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/fzf.vim'
" Git Support
Plug 'tpope/vim-fugitive'
" Theme/ Interface
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
    let &background = ( &background == "dark"? "light" : "dark" )
    if exists("g:colors_name")
        exe "colorscheme " . g:colors_name
    endif
endfunction
silent! map <F6> :call TogBG()<CR>

map <leader>n :NERDTreeToggle<CR>
" Replace ex mode with gq
map Q gq


" statusbar
let g:airline_powerline_fonts = 1
let g:airline#extensions#wordcount#filetypes = '\vasciidoc|help|mail|markdown|vimwiki|org|rst|tex|text'

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

let g:ale_linters = { 
            \'clojure': ['clj-kondo'], 
            \'python': ['flake8', 'mypy', 'pylint', 'pyright'],
            \'markdown' : ['vale']
            \}

" Map movement through errors without wrapping.
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

"" ========================================
"" =========== COC ========================
"" ========================================

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
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

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
