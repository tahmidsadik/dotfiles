lua << EOF

require('config')
require('lsp')
require('root')

EOF

" source settings
nmap <leader>ss :source $MYVIMRC<CR>

"switching between panes
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
" resizing windows 
nmap <M-right> :vertical res +2<CR>
nmap <M-left> :vertical res -2<CR>
nmap <M-up> :res -2<CR>
nmap <M-down> :res +2<CR>
nmap <leader>h <C-w>H
nmap <leader>k <C-w>K

"vimrc editing
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


" imap <leader><tab> <C-x><C-o>

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

" git operations hotkeys
" aliases the terminal keys e.g. gst for git status, ga for git add etc
nmap <leader>gst :Git<CR>
nmap <leader>gd :Gvdiff<CR>
nmap <leader>grm :Gdelete<CR>
nmap <leader>gmv :Gmove<CR>
nmap <leader>gco :Gread<CR>
nmap <leader>ga :Gwrite<CR>
nmap <leader>gc :Git commit<CR>


" FZF config
" let $FZF_DEFAULT_COMMAND = 'rg --files'
" let $FZF_DEFAULT_OPTS = '--reverse'
" nmap <C-p> :Files<CR>
" imap <C-p> <Esc>:Files<CR>


" better ripgrep command: ZRG
" command! -nargs=* -bang ZRG call RipgrepFzf(<q-args>, <bang>0)
" function! RipgrepFzf(query, fullscreen)
"   let command_fmt = '[ -n %s ] && rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
"   let initial_command = printf(command_fmt, shellescape(a:query), shellescape(a:query))
"   let reload_command = printf(command_fmt, '{q}', '{q}')
"   let spec = {'options': ['--phony', '--prompt', 'Search > ', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
"   call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
" endfunction

" nmap <Leader>/ :ZLines<CR>
" nmap <C-f> :ZRG<CR>


" This is the default extra key bindings
" let g:fzf_action = {
"   \ 'ctrl-p': 'tab split',
"   \ 'ctrl-x': 'split',
"   \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
" let g:fzf_layout = {'window': {'width': 0.80, 'height': 0.70, 'yoffset': 0.1, 'border': 'sharp'}}

" In Neovim, you can set up fzf window using a Vim command

" Customize fzf colors to match your color scheme
" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'border':  ['fg', 'Ignore'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
" let g:fzf_history_dir = '~/.local/share/fzf-history'


"gvim dont show menu bar
" set guioptions-=m
" set guioptions-=T
" set guioptions-=L

nmap <C-\> :NvimTreeToggle<CR>
