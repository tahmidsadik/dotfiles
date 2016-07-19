call plug#begin('~/.vim/plugged')
"clojure plugins
Plug 'https://github.com/guns/vim-clojure-static.git', { 'for': 'clojure' }
Plug 'https://github.com/tpope/vim-fireplace.git', { 'for': 'clojure' }
Plug 'https://github.com/jpalardy/vim-slime.git', { 'for': 'clojure' }
Plug 'https://github.com/kien/rainbow_parentheses.vim.git', { 'for': 'clojure' }

"jade support
Plug 'https://github.com/digitaltoad/vim-jade.git'

"nerdtree
Plug 'https://github.com/scrooloose/nerdtree.git', { 'on':  'NERDTreeToggle' }

"YCM
Plug 'https://github.com/Valloric/YouCompleteMe.git'
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'https://github.com/Shutnik/jshint2.vim.git'

"Scala and play 2 syntax highlighting
Plug 'derekwyatt/vim-scala'
Plug 'git://github.com/othree/html5.vim.git'
Plug 'https://github.com/gre/play2vim.git'
Plug 'mattn/emmet-vim'

" elm-lang
Plug 'ElmCast/elm-vim'

"Javascript plugs
" Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'https://github.com/othree/yajs.vim.git'
Plug 'https://github.com/othree/javascript-libraries-syntax.vim.git'
Plug 'https://github.com/othree/es.next.syntax.vim.git'
Plug 'flowtype/vim-flow'
Plug 'gavocanov/vim-js-indent'

"Utilities
Plug 'https://github.com/scrooloose/syntastic.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

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
"Plugin 'https://github.com/nathanaelkane/vim-indent-guides.git'


" Auto close parens 
Plug 'https://github.com/Raimondi/delimitMate.git'

"linters
"Plug 'flowtype/vim-flow'
Plug 'benekastah/neomake'

"Distraction free mode
Plug 'https://github.com/junegunn/goyo.vim.git'
Plug 'https://github.com/junegunn/limelight.vim.git'

call plug#end()
filetype plugin indent on
syntax on
set runtimepath^=~/.vim/bundle/ctrlp.vim
set ruler
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set laststatus=2

set showcmd
set number
set smartindent
set autoindent


set linespace=3
set wrap
set textwidth=79
set incsearch
set hlsearch
set ignorecase
set smartcase
set mousehide

"tab options
nmap <C-n> :tabnew<cr>

"switching between panes
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
"vimrc sorcing
nmap <leader>ev :tabedit $MYVIMRC<CR>

set bg=dark
colorscheme gruvbox
set foldenable
nmap <space> :

imap <leader><tab> <C-x><C-o>
imap jj <esc>

"More useful command line options
set wildmenu
set wildmode=list:longest
"Opens a vertiocal split and switches over (\v)
nnoremap <leader>v <C-w>v

set showmatch
set formatoptions=qrn1

nmap <leader>nt :NERDTreeToggle <CR>
let NERDTreeShowHidden=1

set guifont=Monaco:h14

if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

au BufNewFile,BufRead *.ejs set filetype=html

"gvim dont show menu bar
set guioptions-=m
set guioptions-=T
set guioptions-=L


" JSX ext is not required 
let g:jsx_ext_required = 0
let g:neomake_javascript_enabled_makers = ['eslint']

" Add flowtype syntax for pangloss javascript syntax highlighter
let g:javascript_plugin_flow = 1

