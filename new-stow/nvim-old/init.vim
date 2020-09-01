let mapleader = " "

let g:tex_flavor = 'latex'

if has('win32') || ('win64')
    let g:python3_host_prog = 'C:/Python38/python.EXE' " Python path
    set guifontset=Consolas:h12
    call plug#begin('~/AppData/Local/nvim/plugged')
elseif has('unix')
    let g:python3_host_prog = '/usr/bin/python' " Python path
    if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
        echo "Downloading junegunn/vim-plug to manage plugins..."
        silent !mkdir -p ~/.config/nvim/autoload/
        silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
        autocmd VimEnter * PlugInstall
    endif
    call plug#begin('~/.config/nvim/plugged')
endif

Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'KeitaNakamura/tex-conceal.vim'
Plug 'ervandew/supertab'
"Plug 'zchee/deoplete-jedi'
Plug 'sbdchd/neoformat'
Plug 'neomake/neomake'
"Plug 'davidhalter/jedi-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'Konfekt/FastFold'
Plug 'airblade/vim-gitgutter'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
"Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
"Plug 'ThePrimeagen/vim-be-good'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
"Plug 'dylanaraps/wal'
"Plug 'skywind3000/asyncrun.vim'
"Plug 'Chiel92/vim-autoformat'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'kovetskiy/sxhkd-vim'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
call plug#end()

syntax on
filetype plugin on
colorscheme nord
set background=dark
set termguicolors
set encoding=utf-8
set fileencoding=utf-8
set number relativenumber
set noswapfile
set smartindent
set nowrap
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartcase
set incsearch
set mouse=a
set wildmode=longest,list,full
setlocal spell
set spelllang=pt_br,en_us
set splitbelow splitright
set colorcolumn=81
set cursorline
set clipboard+=unnamedplus

"spell check shortcut Ctrl+L
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

let g:airline_theme='nord'

" Vim-gitgutter settings
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0
highlight GitGutterAdd guifg=#009900 ctermfg=Green
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red

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

" Vim hexokinase - Display Hex colors in terminal
let g:Hexokinase_refreshEvents = ['InsertLeave']

let g:Hexokinase_optInPatterns = [
            \     'full_hex',
            \     'triple_hex',
            \     'rgb',
            \     'rgba',
            \     'hsl',
            \     'hsla',
            \     'colour_names'
            \ ]
let g:Hexokinase_highlighters = ['backgroundfull']

" Reenable hexokinase on enter
autocmd VimEnter * HexokinaseTurnOn

" NERDtree configuration
map <leader>nd :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
            \b:NERDTree.isTabTree()) | q | endif

let NERDTreeIgnore=['\.aux$', '\.synctex.gz$','\.fdb_latexmk', '\.fls', '\.log',
            \'\.bbl', '\.docx', '\.pdf', '\.run.xml', '\.bcf', '\.blg', '\.lof',
            \'\.out', '\.toc','\.xdv$','\.cb$','\.cb2$',]

"após pesquisar algo com (/), (esc)x2 apaga o highlight
nnoremap <esc><esc> :noh<CR>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"exits insert mode with 'jj'
imap jj <esc>

" ajusta tamanho do buffer atual
nnoremap <silent> <M-j>    :resize -2<CR>
nnoremap <silent> <M-k>    :resize +2<CR>
nnoremap <silent> <M-h>    :vertical resize -2<CR>
nnoremap <silent> <M-l>    :vertical resize +2<CR>

" Move a linha selecionada pra cima ou para baixo
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

" Fzf configurations
" -------------------------- "
" Launch fzf with CTRL+P.
nnoremap <silent> <C-p> :FZF -m<CR>

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

" Ranger configuration for image preview inside neovim
let g:rnvimr_ex_enable = 1
nmap <space>r :RnvimrToggle<CR>
