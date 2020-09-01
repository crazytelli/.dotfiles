" ---------------NERDtree configuration--------------------------
map <leader>nd :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
      \b:NERDTree.isTabTree()) | q | endif

let NERDTreeIgnore=['\.aux$', '\.synctex.gz$','\.fdb_latexmk', '\.fls', '\.log',
      \'\.bbl', '\.docx', '\.pdf', '\.run.xml', '\.bcf', '\.blg', '\.lof',
      \'\.out', '\.toc','\.xdv$','\.cb$','\.cb2$',]
