set incsearch
set autoindent
set history=50
set ruler
set showcmd

if has("vms")
	set nobackup
else
	set backup
endif

" configure colorscheme
colorscheme robinhood

" highlight whitespace errors in c mode
let c_space_errors = 1

if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

let g:ccaseUseDialog=0	" Don't use dialog boxes
let g:ccaseAutoLoad=1	" Reload file after checkin/checkout

"--------------------------------------------------------------------------------
" set vim to chdir for each file
if exists('+autochdir')
	set autochdir
else
	autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
endif

" doxygen syntax higlighting
au BufNewFile,BufRead *.doxygen setfiletype doxygen

"set ts=8
"set sw=8
"set noet
