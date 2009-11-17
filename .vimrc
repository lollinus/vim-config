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

if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

let g:ccaseUseDialog=0	" Don't use dialog boxes
let g:ccaseAutoLoad=1	" Reload file after checkin/checkout

