"
"" Basic VIM settings
"

" == systemish settings == {{{
  set backspace=indent,eol,start  " allow backspace over everying in insert mode
  set history=1000                " remember 1000 commands and search history
  set visualbell                  " don't beep 
  set fileformats=unix,dos,mac    " be able to read os file formats without issues
  set hidden                      " handles mutliple buffers better
  set nrformats-=octal            " ctrl-a does NOT increase octal (hex/dec only)
  let g:netrw_liststyle=3         " netrw tree list 
  "set autoread                    " When a file changes out of vim, read it again 
  "" remove whitespace on write
  "autocmd BufWritePre * %s/\s\+$//e
" }}}

" == visual settings == {{{
  syntax on                       " syntax highlighting
  set showmatch                   " show matching parenthesis
  set showmode                    " shows the current mode
  set showcmd                     " Shows the input from an incomplete command

  set nowrap                      " do not wrap text in editor
  set listchars=eol:¬,extends:…,precedes:…,tab:▸\ 
  set colorcolumn=81      " show a line at the 81st column
  set cursorline          " highlight the current line
  set relativenumber      " relative number to the current column
  set number              " except for the current column
  "set list                " end of line/tab chars 
" }}}

" == indentation == {{{
  set autoindent      " always autoindent
  set smartindent     " smart indentation after a new line (ie, {, }, 
  set tabstop=2       " a tab is four spaces
  set shiftwidth=2    " number of spaces to use for autoindenting
  set smarttab        " insert tabs at the start of a line according to shiftwidth
  set expandtab       " insert spaces when tab is presssed
  set shiftround      " use multiple of Shiftwidth when indenting with '<' and '>'
" }}}

" == search and quickfix == {{{
  set incsearch       " show matches as you type
  set hlsearch        " highlight search terms
  set ignorecase      " ignore case
  set smartcase       " if you search with a capital, don't ignore case
                      " Use <C L> to clear the highlighting of :set hlsearch.
  aug QFClose
      " auto close quickfix window if it is the last window
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
  aug END

  if executable('ag') " when we have ag, use it.
    set grepprg=ag\ --nogroup\ --nocolor\ -S
  end
" }}}

" == backup and extra files == {{{
  set nobackup        " don't make backup files
  set nowritebackup   " push saves to the original file, as opposed to saving 
                      " to a new file then renaming it.
  " set noswapfile     " removes the 'swap' file (*.*.swp) 
  "
" }}}

" == scrolling ==  {{{
  set scrolloff=4         " start scrolling 8 rows above/below the top/bottom
  set sidescrolloff=8     " start scrolling 8 cols to the side fo the screen
  set sidescroll=1        " number of spaces to jump when scrolling to the side
" }}}

" == folding == {{{
  set foldmethod=indent   " fold based on indent
  set foldnestmax=10      " deepest fold is 10 levels
  set foldlevelstart=99   " start at fold level 10
  set foldlevel=99        " the higher the more folded regions are open. >1 some folds are closed
  set nofoldenable
" }}}

" == status and title == {{{
  set laststatus=2    " always show status line
  set ruler           " always show columns/lines in status bar
  set wildmenu        " allow status line completions (files, commands, etc)
  "set completeopt=menuone,longest,preview " show a menu when autocompleting

  set statusline=%<\ %n:%f\ 
  set statusline+=%m%r%y%=
  set statusline+=%c%V,
  set statusline+=%l\ of\ %L\ 
  set statusline+=(%P)

  set title titlestring=nvim\ \-\ %t
" }}}

" == Keybindings == {{{
  " setting leader key
  let mapleader = " "

  " disable ex mode
  noremap Q <NOP>    


  " preserve page up and page down
  imap <C-d> <C-o><C-d>
  imap <C-u> <C-o><C-u>

  " Explore mode key
  nmap <silent> <Leader>e :Explore<CR>

  " == Copy and Paste == {{{
    " These can potentially be overriden by platform specific settings
    imap <C-v> <ESC>"+Pa
    vmap <C-v> c<ESC>"+P
    vmap <C-c> "+yi
    vmap <C-x> "+c
  " }}}

  " == Windows == {{{
    nmap <Leader>w <C-w>

    " window bindings Alt-Shift-hjkl will resize windows
    nmap <M-S-h> <C-w><
    nmap <M-S-l> <C-w>>
    nmap <M-S-j> <C-w>+
    nmap <M-S-k> <C-w>-

    " Map Control-hjkl to move between windows
    "nmap <BS> <C-w>h
    set <C-h>=[104;5u
    nmap <C-h> <C-w>h
    nmap <C-j> <C-w>j
    nmap <C-k> <C-w>k
    nmap <C-l> <C-w>l

    " map Control-d, Control-\, and Control-- to manage splits
    nmap <C-w>\ :vsplit<CR>
    nmap <C-w>- :split<CR>
    nmap <C-w>d :close<CR>
  " }}

  " == Buffers == {{{
    " map buffer operations to leader. Yay spacemacs!
    nmap <Leader>bd :bd<CR>
    nmap <Leader>bl :bl<CR>
    nmap <Leader>bn :bn<CR>
  " }}}

  " == Search == {{{
    nnoremap <Leader>/ :grep<SPACE>
    nnoremap <Leader>* :grep "<cword>"<CR>
    "nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

    " maps control-/ to clear the current search
    if maparg('<C-_>', 'n') ==# ''
        nnoremap <silent> <C-_> :nohlsearch<CR><C-_>
    endif
  " }}}

  " == Quickfix == {{{
    " UP will go to the previous result, DOWN will go to the next result
    nnoremap <Leader>q :cwindow<CR>

    augroup qf
      autocmd FileType qf set nobuflisted
      autocmd FileType qf nmap <buffer> <UP> :cprev<CR>:copen<CR>
      autocmd FileType qf nmap <buffer> <DOWN> :cnext<CR>:copen<CR>
    augroup END
  " }}}

  " == Folds == {{{
    " zo - open
    " zc - close
    " zr - reduce fold level
    " zm - increase fold level
  " }}}
" }}}

" == Colorscheme == {{{
  colorscheme ron
" }}}
set modelines=1
" vim:foldmethod=marker:foldlevel=0

