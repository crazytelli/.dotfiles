
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Configurações gerais                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on
filetype plugin on
set background=dark
hi Normal guibg=NONE ctermbg=NONE
set termguicolors
set encoding=utf-8
set fileencoding=utf-8
set number relativenumber
set noswapfile
set smartindent
set nowrap
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartcase
set incsearch
set wildmode=longest,list,full
set nobackup
set nowritebackup
set splitbelow splitright
set colorcolumn=81
set cursorline
set mouse=a
set clipboard+=unnamedplus

let mapleader = " "
let g:tex_flavor = 'latex'

" Ativa spellcheck para português com leader + o. O de 'ortografia'
map <leader>o :setlocal spell! spelllang=pt_br<CR>

"spell check shortcut Ctrl+L
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" LaTeX Conceal. plugin KeitaNakamura/tex-conceal.vim
" Quase certeza de que essa config não tem nada a ver com o plugin
highlight Conceal guibg=NONE ctermbg=NONE
set conceallevel=2
let g:tex_conceal="abdgm"

"Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" Ctrl + h,j,k,l para mover entre buffers
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

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

" Navigate tabs easily
" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Executa o buffer atual em python com F9
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
