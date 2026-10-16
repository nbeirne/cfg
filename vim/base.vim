" == Basic VIM settings ==
set fileformats=unix,dos,mac    " be able to read os file formats without issues
let g:netrw_liststyle=3         " netrw tree list

set nowritebackup   " push saves to the original file, as opposed to saving 
" to a new file then renaming it.
" set noswapfile     " removes the 'swap' file (*.*.swp) 

"set autoread                    " When a file changes out of vim, read it again 

" Copy and Paste to system clipboard (use unnamedplus on linux)
set clipboard=unnamed

" == visual settings ==
colorscheme ron

set nowrap                      " do not wrap text in editor
set linebreak                   " break on words when wrap is on
set listchars=eol:¬,extends:…,precedes:…,tab:▸\ 
"set colorcolumn=81      " show a line at the 81st column
"set cursorline          " highlight the current line
set number             " line numbers
"set relativenumber      " relative number to the current column
"set list                " end of line/tab chars 
set scrolloff=4         " start scrolling 8 rows above/below the top/bottom
set sidescrolloff=8     " start scrolling 8 cols to the side fo the screen

" statusline 
"set laststatus=1    " only show status line on multiple windows
set statusline=%<\ %n:%f\ 
set statusline+=%m%r%y%=
set statusline+=%c%V,
set statusline+=%l\ of\ %L\ 
set statusline+=(%P)
"set title titlestring=vim\ \-\ %t


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

if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
elseif executable('ag')
  set grepprg=ag\ --vimgrep\ -S\ --ignore\ node_modules\ --ignore\ .git\ --ignore\ tags
  set grepformat=%f:%l:%c:%m
endif

set wildignorecase  " ignore case in tab complete in teh command line (:e rea<tab> -> :e README)

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


" == Quickfix == 

augroup qf
  " UP will go to the previous result, DOWN will go to the next result
  autocmd FileType qf set nobuflisted
  autocmd FileType qf set norelativenumber
  autocmd FileType qf set wrap
  "autocmd WinLeave * set cul
  "autocmd WinEnter * set nocul
augroup END

aug QFClose
  " auto close quickfix window if it is the last window
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" gq formats json with jq (gggqG for the whole file)
augroup json
  au!
  au FileType json setlocal formatprg=jq\ .
augroup END


"set modelines=1

