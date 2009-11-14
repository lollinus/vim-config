autocmd Filetype ruby setlocal ts=2 sts=2 sw=2

if &t_Co > 1
	syntax enable
endif

colorscheme desert

" Show trailing whitespace and spaces before tabs
hi link RedundantSpaces Error
match RedundantSpaces /\s\+$\| \+\ze\t/

" set vim to chdir for each file
if exists('+autochdir')
	set autochdir
else
	autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
endif

set hlsearch

"set ts=8
"set sw=8
"set noet
