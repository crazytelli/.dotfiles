""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Deoplete autocomplete                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"call deoplete#custom#var('omni', 'input_patterns', {
      "\ 'tex': g:vimtex#re#deoplete
"\})


let g:tex_flavor = 'latex'

" script localizado em ~/.scripts/texclear para limpar arquivos auxiliares LaTeX
autocmd VimLeave *.tex !texclear %

" LaTeX Conceal. plugin KeitaNakamura/tex-conceal.vim
" Quase certeza de que essa config não tem nada a ver com o plugin
highlight Conceal guibg=NONE ctermbg=NONE
set conceallevel=2
let g:tex_conceal="abdgm"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Vimtex Settings                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_quickfix_mode=0
"let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_view_method='zathura'
let g:vimtex_view_general_options
      \ = '-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'

" Buffer interpreta .tex e .cls como arquivos LaTeX
autocmd BufRead,BufNewFile *.tex,*.cls set filetype=tex
autocmd FileType tex set textwidth=80 wrap


" Cleanup LaTeX auxiliary files  on quit
"augroup vimtex_event_1
"au!
"au User VimtexEventQuit     call vimtex#compiler#clean(0)
"augroup END

let g:vimtex_complete_close_braces = 1
let g:vimtex_indent_enabled=1
let g:vimtex_fold_enabled=1
let g:vimtex_fold_manual=0
set fillchars=fold:\
let  g:vimtex_fold_types = {
      \ 'preamble' : {'enabled' : 0},
      \ 'envs' : {
      \   'blacklist' : ['figure'],
      \ },
      \}

let g:vimtex_quickfix_mode = 2
let g:vimtex_quickfix_open_on_warning = 1
"let g:vimtex_quickfix_ignored_warnings = [
      "\ 'Underfull',
      "\ 'Overfull',
      "\ 'specifier changed to',
      "\ ]
