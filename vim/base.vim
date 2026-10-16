" == Basic VIM settings ==
let g:netrw_liststyle=3   " netrw tree list

set clipboard=unnamed     " Copy and Paste to system clipboard (use unnamedplus on linux)


" == visual settings ==

colorscheme ron

set nowrap                " do not wrap text in editor
set linebreak             " break on words when wrap is on
"set colorcolumn=81        " show a line at the 81st column
"set cursorline            " highlight the current line
"set list                  " end of line/tab chars 
set number                " line numbers
"set relativenumber        " relative number to the current column
set scrolloff=4           " start scrolling n rows above/below the top/bottom
set sidescrolloff=8       " start scrolling n cols to the side of the screen


" == indentation ==
set tabstop=4             " a tab is four spaces
set shiftwidth=4          " number of spaces to use for autoindenting
set expandtab             " insert spaces when tab is pressed


" == Keybindings ==
let mapleader = " "       " set <Leader>


" == completion and search behaviour ==
set wildignorecase        " ignore case in tab complete in the command line (:e rea<tab> -> :e README)
set path=.,,,**           " path for :find, gf, and other file search ops
set ignorecase            " ignore case in / search
set smartcase             " if you / search with a capital, don't ignore case


" == search tools ==
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
elseif executable('ag')
  set grepprg=ag\ --vimgrep\ -S\ --ignore\ node_modules\ --ignore\ .git\ --ignore\ tags
  set grepformat=%f:%l:%c:%m
endif

" == quickfix window and filetype behaviours == 

augroup qf
  au!
  autocmd FileType qf setlocal nobuflisted " take quickfix buffer out of the buflist (:bl and <Space>fb)
augroup END

" gq formats json with jq (gggqG for the whole file)
augroup json
  au!
  au FileType json setlocal formatprg=jq\ .
augroup END



" == testing removing settings ==

"set listchars=eol:¬,extends:…,precedes:…,tab:▸\ 

" statusline 
"set laststatus=1    " only show status line on multiple windows
"set statusline=%<\ %n:%f\ 
"set statusline+=%m%r%y%=
"set statusline+=%c%V,
"set statusline+=%l\ of\ %L\ 
"set statusline+=(%P)
"set title titlestring=vim\ \-\ %t

"set modelines=1

" move by visual line -- don't skip wrapped lines.
"nnoremap j gj
"nnoremap k gk

" nvim only: next / previous quickfix item (nvim's built-in ]q and [q). 
" NOTE: replaces default behaviour, where C-n goes up a line and C-p goes down.
"nmap <C-n> ]q
"nmap <C-p> [q

"set completeopt=longest,menuone,preview 

"set smartindent     " smart indentation after a new line (ie, {, },
"set shiftround      " use multiple of Shiftwidth when indenting with '<' and '>'
