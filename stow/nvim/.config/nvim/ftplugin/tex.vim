"------------------ settings for Vimtex ------------------------------
call deoplete#custom#var('omni', 'input_patterns', {
            \ 'tex': g:vimtex#re#deoplete
            \})

let g:vimtex_compiler_progname = 'nvr'

"let g:vimtex_indent_enabled=1
"let g:vimtex_fold_enabled=1
"let g:vimtex_fold_manual=0
"set fillchars=fold:\
"let  g:vimtex_fold_types = {
            "\ 'preamble' : {'enabled' : 1},
            "\ 'envs' : {
            "\   'blacklist' : ['figure'],
            "\ },
"\}

" Usando plugin FastFold:
"let g:tex_fold_enabled = 1

let g:tex_conceal='abdmg'
set conceallevel=1
hi Conceal ctermbg=none
hi Pmenu guibg=gray
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
augroup vimtex_event_1
    au!
    au User VimtexEventQuit     call vimtex#compiler#clean(0)
augroup END

" This is new style - Autocomplete for .tex files
" Mapeamentos de tecla para LaTeX
nnoremap <leader>fe :VimtexCompile<CR>
nnoremap <leader>tt :VimtexTocOpen<CR>
nnoremap <leader>de :VimtexErrors<CR>
