"Esse texto foi adicionado no diretório ~/.config/nvim/init.vim
let mapleader = " "

let g:deoplete#enable_at_startup = 1

if has('win32') || ('win64')
	let g:python3_host_prog = 'C:/Python38/python.EXE' " Python path
	call plug#begin('~/AppData/Local/nvim/plugged')
else
	call plug#begin('~/.config/nvim/plugged')
endif

"call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'dylanaraps/wal'
Plug 'dylanaraps/wal.vim'
Plug 'bling/vim-airline'
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'junegunn/goyo.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'KeitaNakamura/tex-conceal.vim'
Plug 'Konfekt/FastFold'
Plug 'ervandew/supertab'
Plug 'zchee/deoplete-jedi'
Plug 'sbdchd/neoformat'
Plug 'davidhalter/jedi-vim'
Plug 'kovetskiy/sxhkd-vim'
"Plug 'Chiel92/vim-autoformat'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'PotatoesMaster/i3-vim-syntax'
call plug#end()

syntax on
filetype plugin on
colorscheme gruvbox
set background=dark
set termguicolors
set encoding=utf-8
set number relativenumber
set nobackup
set noswapfile
set smartindent
set nowrap
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set incsearch
set wildmode=longest,list,full
"setlocal spell
"set spelllang=pt_br,en_us
set splitbelow splitright

"spell check shortcut Ctrl+L
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

"---------------- UltiSnips setup --------------------------
" Shortcut to jump forward and backward in tabstop positions
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

"Pasta onde estão os snippets - pasta: ("my_snippets")
"A pasta pode estar em qualquer lugar em :echo &runtimepath
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my_snippets"]

"------------------------supertab settings------------------
" Auto-close method preview window
let g:SuperTabClosePreviewOnPopupClose = 1
" Use the default top to bottom way for scroll, see https://goo.gl/APdo9V
let g:SuperTabDefaultCompletionType = '<c-n>'
" Shortcut to navigate forward and backward in completion menu,
" see https://is.gd/AoSv4m
let g:SuperTabMappingForward = '<C-k>'
let g:SuperTabMappingBackward = '<C-j>'

"Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

map <leader>nd :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

nnoremap <leader>ss :source %<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
"após pesquisar algo com (/), (esc)x2 apaga o highlight
nnoremap <esc><esc> :noh<CR>
