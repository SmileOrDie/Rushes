inoremap ( ()<left>
inoremap { {}<left>
set ai
set cursorline
set cursorcolumn
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t\| \s\+/
