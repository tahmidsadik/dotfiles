set ruler

set tabstop=2
set shiftwidth=2
set softtabstop=2
set smartindent
set autoindent

set number
set linespace=3
set wrap
set textwidth=80
set incsearch
set hlsearch
set ignorecase
set mousehide
set noswapfile

set clipboard=unnamedplus

let mapleader = ","

let g:node_host_prog = '/Users/tahmid/Library/Application Support/fnm/node-versions/v18.16.0/installation/bin/node'
" set the title of the current file we are editing

let $PATH = '/Users/tahmid/Library/Application Support/fnm/node-versions/v18.16.0/installation/bin:' . $PATH

set title

" source settings
nmap <leader>ss :source ~/.config/nvim/init.vim<CR>

" Setting up guifont
" set guifont=CaskaydiaCove\ Nerd\ Font\ Mono:h12
" set guifont=Operator\ Mono\ Nerd\ Font:h12
" set guifont=mononoki\ Nerd\ Font\ Mono:h12
" set guifont=Fira\ Code\ Light:h12
set guifont=OperatorMono\ Nerd\ Font:h14


"disable netrw
let loaded_netrwPlugin = 1

lua << EOF

require('config')
require('lsp')
require('root')

EOF

filetype plugin indent on
syntax on

" indent settings by file type
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType elixir setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

tmap <C-k> :IExHide<CR>

"tab options
" nmap <C-n> :tabnew<cr>

"switching between panes
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
" resizing windows 
nmap <A-right> :vertical res +2<CR>
nmap <A-left> :vertical res -2<CR>
nmap <A-up> :res -2<CR>
nmap <A-down> :res +2<CR>
nmap <leader>h <C-w>H
nmap <leader>k <C-w>K

" nmap <leader>t :Mix test<cr>
" nmap <leader>l :Mix dialyzer<cr>
nmap <leader>1 :tabn<cr>
nmap <leader>2 :tabp<cr>
nmap <leader><tab> :b#<cr>
"vimrc sorcing
nmap <leader>ev :tabedit $MYVIMRC<CR>

nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

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
" colorscheme edge
" colorscheme nord
" colorscheme miramare
" colorscheme night-owl 
" colorscheme onedark
colorscheme quietlight 
set bg=light
set foldenable

" imap <leader><tab> <C-x><C-o>
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


" FZF config
" let $FZF_DEFAULT_COMMAND = 'rg --files'
" let $FZF_DEFAULT_OPTS = '--reverse'
" nmap <C-p> :Files<CR>
" imap <C-p> <Esc>:Files<CR>


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
nmap <C-f> :ZRG<CR>


" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-p': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = {'window': {'width': 0.80, 'height': 0.70, 'yoffset': 0.1, 'border': 'sharp'}}

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

nmap <C-\> :NvimTreeToggle<CR>
imap <C-\> :CocCommand<CR>

if exists("g:neovide")
  set guifont=OperatorMono\ Nerd\ Font:h16
    " Put anything you want to happen only in Neovide here
endif

