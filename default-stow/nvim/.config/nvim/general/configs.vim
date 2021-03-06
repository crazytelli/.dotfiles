
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Configurações gerais                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on
filetype plugin on
set background=dark
hi Normal guibg=NONE ctermbg=NONE
set termguicolors
set encoding=utf-8
"set fileencoding=utf-8
set number relativenumber
set noswapfile
set smartindent
set nowrap
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set ignorecase
set smartcase
set incsearch
set wildmode=longest,list,full
set nobackup
set nowritebackup
set splitbelow splitright
set colorcolumn=81
"set cursorline
set mouse=a
set clipboard+=unnamedplus
set iskeyword+=-            " treat dash separated words as a word text object"
"set ruler              			" Show the cursor position all the time
set spellfile=~/.config/nvim/spell/pt.utf-8.add
set spelllang=en,pt

let mapleader = " "
let maplocalleader = ","

" Ativa spellcheck para português com leader + o. O de 'ortografia'
"map <leader>o :setlocal spell! spelllang=en,pt<CR>
map <leader>o :setlocal spell!<CR>

"spell check shortcut Ctrl+L
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

"Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" Ctrl + h,j,k,l para mover entre buffers
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Replace ex mode with gq
map Q gq

"após pesquisar algo com (/), (esc)x2 apaga o highlight
nnoremap <esc><esc> :noh<CR>

" ajusta tamanho do buffer atual com Alt
nnoremap <silent> <M-j>    :resize -2<CR>
nnoremap <silent> <M-k>    :resize +2<CR>
nnoremap <silent> <M-h>    :vertical resize -2<CR>
nnoremap <silent> <M-l>    :vertical resize +2<CR>

" Move a linha selecionada pra cima ou para baixo
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

" Executa o buffer atual em python com F9
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
