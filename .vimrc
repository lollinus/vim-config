" vim: set ts=8 sw=8 sts=8 foldmethod=syntax noet:
set incsearch
set autoindent
set smartindent
set history=50
set ruler
set showcmd
" visual bell
set vb t_vb=
" turn off toolbar
set guioptions-=T
filetype on

" buffer size
set viminfo='20,<1000,s1000


if has("vms")
	set nobackup
else
	set backup
endif

" highlight whitespace errors in c mode
let c_space_errors = 1

set statusline=%F%m%r%h%w\ [FORMAT=%{&FF}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
map <silent> <F11> :if &guioptions =~# 'T' <Bar>
	\simalt ~X<CR> <Bar> 
	\set guioptions-=T <Bar>
	\set guioptions-=m <Bar>
	\set guioptions+=C <Bar>
	\else <Bar>
	\set guioptions+=T <Bar>
	\set guioptions+=m <Bar>
	\set guioptions-=C <Bar>
	\simalt ~R<CR> <Bar> 
	\endif<CR>

if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" configure colorscheme
let g:solarized_termcolors=256
" let g:solarized_termtrans=0
if has('gui_running')
	colorscheme solarized
	set background=light
else
	colorscheme solarized
	set background=dark
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


" easy window switch
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_
set wmh=0

" Gtags config
map <C-n> :cn<CR>
map <C-p> :cp<CR>

set laststatus=2 "turns on vim-arirline at startup
if has("gui_gtk2")
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
endif
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1 "tabline enable
let g:airline#extensions#tabline#fnamemod = ':t' "filenames only in tabs

" taglist plugin
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Show_Menu = 1
let Tlist_Auto_Highlight_Tag = 1

" Convert slashes to backslashes for Windows.
if has('win32')
  nmap ,cs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
  nmap ,cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

  " This will copy the path in 8.3 short format, for DOS and Windows 9x
  nmap ,c8 :let @*=substitute(expand("%:p:8"), "/", "\\", "g")<CR>
else
  nmap ,cs :let @*=expand("%")<CR>
  nmap ,cl :let @*=expand("%:p")<CR>
endif

