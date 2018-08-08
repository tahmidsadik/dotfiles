set ruler
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set laststatus=2
set encoding=utf-8
set showcmd
set number
set smartindent
set autoindent

set linespace=3
set wrap
set textwidth=80
set incsearch
set hlsearch
set ignorecase
set smartcase
set mousehide

set cursorline
" set cursorcolumn

" set the title of the current file we are editing
set title

" Ale setup. Must be declared before plug initializes
let g:ale_lint_on_save = 0
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 0
let g:ale_fix_on_save = 1


call plug#begin('~/.vim/plugged')

" Ansi escape for nicer documentation
Plug 'powerman/vim-plugin-AnsiEsc'

" Editor config for vim
Plug 'editorconfig/editorconfig-vim'

" git stuff
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" terminal management
Plug 'mklabs/split-term.vim'

" Async linting
Plug 'w0rp/ale'
"Async completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    let g:deoplete#enable_at_startup = 1
    inoremap <expr><tab> pumvisible() ? "<c-n>" : "\<tab>"

"clojure plugins
Plug 'https://github.com/guns/vim-clojure-static.git', { 'for': 'clojure' }
Plug 'https://github.com/tpope/vim-fireplace.git', { 'for': 'clojure' }
Plug 'https://github.com/jpalardy/vim-slime.git', { 'for': 'clojure' }
Plug 'https://github.com/kien/rainbow_parentheses.vim.git', { 'for': 'clojure' }

" elixir stuff
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'

"jade support
Plug 'https://github.com/digitaltoad/vim-jade.git'

"nerdtree Plug 'https://github.com/scrooloose/nerdtree.git', { 'on':  'NERDTreeToggle' } 
"YCM
"Scala and play 2 syntax highlighting
Plug 'derekwyatt/vim-scala'
Plug 'git://github.com/othree/html5.vim.git'
Plug 'https://github.com/gre/play2vim.git'
Plug 'mattn/emmet-vim'

" elm-lang
Plug 'ElmCast/elm-vim'

"Javascript plugs
" Plug 'pangloss/vim-javascript'
" Plug 'mxw/vim-jsx'
" Plug 'https://github.com/othree/yajs.vim.git'
" Plug 'https://github.com/othree/javascript-libraries-syntax.vim.git'
" Plug 'https://github.com/othree/es.next.syntax.vim.git'
" Plug 'flowtype/vim-flow'
" Plug 'gavocanov/vim-js-indent'

"Utilities
Plug 'https://github.com/tpope/vim-surround.git'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }

"tcomment plugin
Plug 'https://github.com/tomtom/tcomment_vim.git'
"Multiple Cursors
Plug 'https://github.com/terryma/vim-multiple-cursors.git'

"colorschemes
Plug 'https://github.com/matthewtodd/vim-twilight.git'
Plug 'https://github.com/jnurmine/Zenburn.git'
Plug 'https://github.com/vim-scripts/xoria256.vim.git'
Plug 'https://github.com/nanotech/jellybeans.vim.git'
Plug 'https://github.com/morhetz/gruvbox.git'
Plug 'https://github.com/zeis/vim-kolor.git'
Plug 'https://github.com/tomasr/molokai.git'
Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'https://github.com/nathanaelkane/vim-indent-guides.git'
Plug 'ayu-theme/ayu-vim'
Plug 'fneu/breezy'
Plug 'dim13/smyck.vim'

" Status line
" Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'powerline/powerline'


" Auto close parens 
Plug 'jiangmiao/auto-pairs'

"linters
"Plug 'flowtype/vim-flow'
"Plug 'benekastah/neomake'

"Distraction free mode
Plug 'https://github.com/junegunn/goyo.vim.git'
Plug 'https://github.com/junegunn/limelight.vim.git'

call plug#end()
filetype plugin indent on
syntax on

let mapleader =","
" set runtimepath^=~/.vim/bundle/ctrlp.vim

" indent settings by file type
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType elixir setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
tmap <C-k> :IExHide<CR>

"tab options
nmap <C-n> :tabnew<cr>

"switching between panes
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <leader>t :Mix test<cr>
nmap <leader>l :Mix dialyzer<cr>
nmap <leader>1 :tabn<cr>
nmap <leader>2 :tabp<cr>
nmap <leader><tab> :b#<cr>
"vimrc sorcing
nmap <leader>ev :tabedit $MYVIMRC<CR>

set bg=dark
let ayucolor="mirage"
colorscheme ayu
set foldenable

imap <leader><tab> <C-x><C-o>
" imap jj <esc>

"More useful command line options
set wildmenu
set wildmode=list:longest
"Opens a vertiocal split and switches over (\v)
nnoremap <leader>v <C-w>v

set showmatch
set formatoptions=qrn1

nmap <leader>nt :NERDTreeToggle <CR>
let NERDTreeShowHidden=1

" if has("autocmd")
"   autocmd bufwritepost init.vim source $MYVIMRC
" endif

au BufNewFile,BufRead *.ejs set filetype=html

" FZF config
nmap <C-p> :Files<CR>
imap <C-p> :Files<CR>
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-p': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" ALE config
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title
nmap ]l :ALENextWrap<CR>
nmap [l :ALEPreviousWrap<CR>

let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\   'elixir': ['mix_format']
\}

"gvim dont show menu bar
set guioptions-=m
set guioptions-=T
set guioptions-=L

