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
set mousehide
set noswapfile

set cursorline
set clipboard=unnamedplus
" set cursorcolumn

" set the title of the current file we are editing
set title

" source settings
nmap <leader>ss :source ~/.config/nvim/init.vim<CR>

" Setting up guifont
" set guifont=CaskaydiaCove\ Nerd\ Font:h14
" set guifont=Operator\ Mono\ Nerd\ Font:h12
" set guifont=mononoki\ Nerd\ Font\ Mono:h12


"disable netrw
let loaded_netrwPlugin = 1

call plug#begin()
" Startify
Plug 'mhinz/vim-startify' 

" Table mode
Plug 'dhruvasagar/vim-table-mode'

" Ansi escape for nicer documentation
Plug 'powerman/vim-plugin-AnsiEsc'

" Editor config for vim
Plug 'editorconfig/editorconfig-vim'

" git stuff
Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0
Plug 'tpope/vim-fugitive'

" inline todo
Plug 'vitalk/vim-simple-todo'

" terminal management
Plug 'mklabs/split-term.vim'
set splitright
set splitbelow

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

" Vim Notes
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'

" Align stuff
Plug 'tommcdo/vim-lion'

Plug 'iamcco/markdown-preview.nvim'

" Rust language support
Plug 'rust-lang/rust.vim'
au FileType rust nmap rr :VTerm cargo run<cr>
au FileType rust nmap re :VTerm cargo check<cr>

au FileType javascript nmap rr :VTerm yarn start<cr>
au FileType typescript nmap rr :VTerm yarn start<cr>
au FileType go nmap rr :VTerm go run ./main.go<cr>
au FileType go nmap rr :VTerm go run ./main.go<cr>
" nmap re :Build()<cr>
" nmap rr :Run()<cr>

" toml syntax highlighting
Plug 'cespare/vim-toml'
let g:autofmt_autosave = 1

" colorizer
Plug 'norcalli/nvim-colorizer.lua'

" Language pack
Plug 'sheerun/vim-polyglot'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" global plugins
let g:coc_global_extensions = [
      \ 'coc-actions',
      \ 'coc-css',
      \ 'coc-emoji',
      \ 'coc-eslint',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-explorer',
      \ 'coc-marketplace',
      \ 'coc-pairs',
      \ 'coc-prettier',
      \ 'coc-snippets',
      \ 'coc-tsserver',
      \ 'coc-vimlsp',
      \ 'coc-yaml',
      \ 'coc-rls',
      \ 'coc-rust-analyzer'
      \ ]

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
nmap <F2> <Plug>(coc-rename)

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
nnoremap <leader>oi :call CocAction('runCommand', 'editor.action.organizeImport')<CR>



" COC config end

" neosnippet support
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" rest api request chekcing in vim
Plug 'diepm/vim-rest-console'

"Utilities
Plug 'https://github.com/tpope/vim-surround.git'
" source /usr/share/doc/fzf/examples/fzf.vim
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'


" vim clap
" Plug 'liuchengxu/vim-clap'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }

"tcomment plugin
Plug 'https://github.com/tomtom/tcomment_vim.git'

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
Plug 'NLKNguyen/papercolor-theme'
Plug 'skbolton/embark'
Plug 'arcticicestudio/nord-vim', { 'branch': 'develop' }
Plug 'franbach/miramare'
Plug 'srcery-colors/srcery-vim'
Plug 'vimoxide/vim-cinnabar'

" Status line
Plug 'itchyny/lightline.vim'

let g:lightline = {
      \ 'component': {
      \   'lineinfo': ' %3l:%-2c',
      \ },
      \ 'component_function': {
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }
function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction
function! LightlineFugitive()
  if exists('*FugitiveHead')
    let branch = FugitiveHead()
    return branch !=# '' ? ''.branch : ''
  endif
  return ''
endfunction

let g:lightline.colorscheme = 'solarized'

" Airline configurations
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" let g:airline_powerline_fonts = 1
" let g:airline_theme='night_owl'
" let g:airline_theme='base16_nord'
" let g:airline_theme='gruvbox'
" let g:airline_theme='solarized'
" let g:airline_theme='miramare'


"Distraction free mode
Plug 'https://github.com/junegunn/goyo.vim.git'
Plug 'https://github.com/junegunn/limelight.vim.git'

" vim devicons; needs to be loaded last
Plug 'ryanoasis/vim-devicons'

call plug#end()
filetype plugin indent on
syntax on

let mapleader = ","
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
nmap <C-right> :vertical res +2<CR>
nmap <C-left> :vertical res -2<CR>
nmap <C-up> :res -2<CR>
nmap <C-down> :res +2<CR>
nmap <leader>h <C-w>H
nmap <leader>k <C-w>K

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

" enable truecolor
" if has('termguicolors')
"   if ! has('nvim')
"     " *xterm-true-color*
"     let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"   endif
" endif

" colorscheme NeoSolarized
" colorscheme onedark
" colorscheme embark
" colorscheme gruvbox
" colorscheme nord 
colorscheme miramare
" colorscheme night-owl 
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
" imap <C-p> <Esc>:Clap files<CR>

" FZF config
let $FZF_DEFAULT_COMMAND = 'rg --files'
let $FZF_DEFAULT_OPTS = '--reverse'
nmap <C-p> :Files<CR>
imap <C-p> <Esc>:Files<CR>


" better ripgrep command: ZRG
command! -nargs=* -bang ZRG call RipgrepFzf(<q-args>, <bang>0)
function! RipgrepFzf(query, fullscreen)
  let command_fmt = '[ -n %s ] && rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query), shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}', '{q}')
  let spec = {'options': ['--phony', '--prompt', 'Search > ', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

nmap <Leader>/ :ZLines<CR>
nmap <C-S-f> :ZRG<CR>


" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-p': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = {'window': {'width': 0.55, 'height': 0.35, 'yoffset': 0.1, 'border': 'sharp'}}

" In Neovim, you can set up fzf window using a Vim command

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


"gvim dont show menu bar
set guioptions-=m
set guioptions-=T
set guioptions-=L

nmap <C-\> :CocCommand explorer<CR>
imap <C-\> :CocCommand explorer<CR>

