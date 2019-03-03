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
let g:ale_lint_delay = 100
let g:ale_fix_on_save = 1


call plug#begin()

" Ansi escape for nicer documentation
Plug 'powerman/vim-plugin-AnsiEsc'

" Editor config for vim
Plug 'editorconfig/editorconfig-vim'

" git stuff
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" terminal management
Plug 'mklabs/split-term.vim'
set splitright
set splitbelow

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

" Language LSP
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }


"YCM
"Tern js 
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
"Scala and play 2 syntax highlighting
Plug 'derekwyatt/vim-scala'
Plug 'git://github.com/othree/html5.vim.git'
Plug 'https://github.com/gre/play2vim.git'
Plug 'mattn/emmet-vim'

" elm-lang
Plug 'ElmCast/elm-vim'

" Rust language support
Plug 'rust-lang/rust.vim'
au FileType rust nmap rr :VTerm cargo run<cr>
au FileType rust nmap re :VTerm cargo check<cr>

let g:autofmt_autosave = 1

" Racer autocompletion via deoplete
Plug 'sebastianmarkow/deoplete-rust'
"Javascript plugs
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'

" flow autocompletion in vim
Plug 'wokalski/autocomplete-flow'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" rest api request chekcing in vim
Plug 'diepm/vim-rest-console'


"Utilities
Plug 'https://github.com/tpope/vim-surround.git'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

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
Plug 'joshdick/onedark.vim'

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

" vim-tasks plugin
Plug '~/projects/rust/vim-tasks'

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
colorscheme onedark
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

let g:ale_linters = {
\   'javascript': ['flow', 'eslint'],
\   'rust': ['rls']
\}

let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\   'json': ['prettier'],
\   'elixir': ['mix_format'],
\   'rust': ['rustfmt']
\}


" rust setup rls
"
let g:deoplete#sources#rust#racer_binary='/Users/tahmid/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/Users/tahmid/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src'

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio']
    \ }


let g:LanguageClient_autoStart = 1

" Maps K to hover, gd to goto definition, F2 to rename
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>


"gvim dont show menu bar
set guioptions-=m
set guioptions-=T
set guioptions-=L

" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
nmap <leader>nt :Vexplore<CR>
