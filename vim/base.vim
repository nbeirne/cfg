" == Basic VIM settings ==
set fileformats=unix,dos,mac    " be able to read os file formats without issues
let g:netrw_liststyle=3         " netrw tree list

"set autoread                    " When a file changes out of vim, read it again 

" == visual settings ==
set nowrap                      " do not wrap text in editor
set linebreak                   " break on words when wrap is on
set listchars=eol:¬,extends:…,precedes:…,tab:▸\ 
"set colorcolumn=81      " show a line at the 81st column
"set cursorline          " highlight the current line
set number             " line numbers
"set relativenumber      " relative number to the current column
"set list                " end of line/tab chars 


colorscheme ron

" == indentation ==
set smartindent     " smart indentation after a new line (ie, {, },
set tabstop=4       " a tab is four spaces
set shiftwidth=4    " number of spaces to use for autoindenting
set expandtab       " insert spaces when tab is pressed
set shiftround      " use multiple of Shiftwidth when indenting with '<' and '>'


" == search and quickfix ==
set path=.,,,**     " path for :find
set ignorecase      " ignore case
set smartcase       " if you search with a capital, don't ignore case
aug QFClose
  " auto close quickfix window if it is the last window
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

if executable('ag') 
  set grepprg=ag\ --nogroup\ --nocolor\ -S\ --ignore\ node_modules\ --ignore\ .git\ --ignore\ tags
endif


" == backup and extra files ==
set nowritebackup   " push saves to the original file, as opposed to saving 
" to a new file then renaming it.
" set noswapfile     " removes the 'swap' file (*.*.swp) 



" == scrolling ==
set scrolloff=4         " start scrolling 8 rows above/below the top/bottom
set sidescrolloff=8     " start scrolling 8 cols to the side fo the screen


" == status and title ==
"set laststatus=1    " only show status line on multiple windows

set wildignorecase  " ignore case in tab complete

"set wildignore+=**/node_modules/*
"set wildignore+=**/.git/*
"set wildignore+=**/*.o
"set wildignore+=**/*.obj
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
"set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

set statusline=%<\ %n:%f\ 
set statusline+=%m%r%y%=
set statusline+=%c%V,
set statusline+=%l\ of\ %L\ 
set statusline+=(%P)
"set title titlestring=vim\ \-\ %t

" Completion fixes 
set completeopt=longest,menuone,preview 


" == Keybindings ==
" setting leader key
let mapleader = " "

" move by visual line -- don't skip wrapped lines.
nnoremap j gj
nnoremap k gk

" nvim only: next / previous quickfix item (nvim's built-in ]q and [q). 
" NOTE: replaces default behaviour, where C-n goes up a line and C-p goes down.
nmap <C-n> ]q
nmap <C-p> [q

" Copy and Paste
" These can potentially be overriden by platform specific settings
imap <C-v> <ESC>"+pa
vmap <C-v> c<ESC>"+p
vmap <C-c> "+yi
vmap <C-x> "+c

" == Quickfix == 
augroup qf
  " UP will go to the previous result, DOWN will go to the next result
  autocmd FileType qf set nobuflisted
  autocmd FileType qf set norelativenumber
  autocmd FileType qf set wrap
  "autocmd WinLeave * set cul
  "autocmd WinEnter * set nocul
augroup END

" gq formats json with jq (gggqG for the whole file)
augroup json
  au!
  au FileType json setlocal formatprg=jq\ .
augroup END

"set modelines=1

