" vim: set ts=8 sw=8 sts=8 foldmethod=syntax noet:
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

" highlight whitespace errors in c mode
let c_space_errors = 1

if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" configure colorscheme
if has("gui_running")
	colorscheme robinhood
else
	colorscheme murphy
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
