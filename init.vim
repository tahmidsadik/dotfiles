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
Plug 'dense-analysis/ale'

" yank highlighting
Plug 'machakann/vim-highlightedyank'

"clojure plugins
Plug 'https://github.com/guns/vim-clojure-static.git', { 'for': 'clojure' }
Plug 'https://github.com/tpope/vim-fireplace.git', { 'for': 'clojure' }
Plug 'https://github.com/jpalardy/vim-slime.git', { 'for': 'clojure' }
Plug 'https://github.com/kien/rainbow_parentheses.vim.git', { 'for': 'clojure' }

" Golang support 
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"nerdtree 
Plug 'https://github.com/scrooloose/nerdtree.git', { 'on':  'NERDTreeToggle' } 
Plug 'mattn/emmet-vim'

" Rust language support
Plug 'rust-lang/rust.vim'
au FileType rust nmap rr :VTerm cargo run<cr>
au FileType rust nmap re :VTerm cargo check<cr>

au FileType javascript nmap rr :VTerm yarn start<cr>
" nmap re :Build()<cr>
" nmap rr :Run()<cr>

" toml syntax highlighting
Plug 'cespare/vim-toml'
let g:autofmt_autosave = 1

" Language pack
Plug 'sheerun/vim-polyglot'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Coc configurations
" start
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" neosnippet support
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" rest api request chekcing in vim
Plug 'diepm/vim-rest-console'

"Utilities
Plug 'https://github.com/tpope/vim-surround.git'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" vim clap
" Plug 'liuchengxu/vim-clap'
" Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }

"tcomment plugin
Plug 'https://github.com/tomtom/tcomment_vim.git'
"Multiple Cursors
Plug 'https://github.com/terryma/vim-multiple-cursors.git'

"colorschemes
Plug 'matthewtodd/vim-twilight'
Plug 'jnurmine/Zenburn'
Plug 'vim-scripts/xoria256.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'
Plug 'zeis/vim-kolor'
Plug 'tomasr/molokai'
Plug 'altercation/vim-colors-solarized'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ayu-theme/ayu-vim'
Plug 'fneu/breezy'
Plug 'dim13/smyck.vim'
Plug 'joshdick/onedark.vim'
Plug 'iCyMind/NeoSolarized'
Plug 'haishanh/night-owl.vim'
Plug 'chriskempson/base16-vim'
Plug 'NLKNguyen/papercolor-theme'

" Status line
" Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline_theme='papercolor'

" Auto close parens 
Plug 'jiangmiao/auto-pairs'

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

if (has("termguicolors"))
 set termguicolors
endif

" colorscheme night-owl
" colorscheme breezy
colorscheme onedark
set bg=dark
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

" git operations hotkeys
" aliases the terminal keys e.g. gst for git status, ga for git add etc
nmap <leader>gst :Gstatus<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>grm :Gdelete<CR>
nmap <leader>gmv :Gmove<CR>
nmap <leader>gco :Gread<CR>
nmap <leader>ga :Gwrite<CR>
nmap <leader>gc :Gcommit %<CR>

" Vim Clap keybinding
" nmap <C-p> :Clap files<CR>
" imap <C-p> :Clap files<CR>

" FZF config
let $FZF_DEFAULT_COMMAND = 'rg --files'
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
\   'typescript': ['eslint', 'tsserver'],
\   'rust': ['rls'],
\   'golang': ['gofmt']
\}

let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\   'typescript': ['eslint', 'prettier'],
\   'json': ['prettier'],
\   'elixir': ['mix_format'],
\   'rust': ['rustfmt'],
\   'golang': ['gofmt']
\}


" Required for operations modifying multiple buffers like rename.
set hidden

" Maps K to hover, gd to goto definition, F2 to rename
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>


"gvim dont show menu bar
set guioptions-=m
set guioptions-=T
set guioptions-=L

" netrw setup

" nmap <C-\> :Vexplore<CR>
" imap <C-\> :Vexplore<CR>

nmap <C-\> :NERDTreeToggle<CR>
imap <C-\> :NERDTreeToggle<CR>



