" ---------------- UltiSnips setup --------------------------
" Shortcut to jump forward and backward in tabstop positions
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

"Pasta onde estão os snippets - pasta: ("my_snippets")
"A pasta pode estar em qualquer lugar em :echo &runtimepath
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my_snippets"]
