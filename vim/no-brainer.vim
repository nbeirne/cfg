"
"" Basic VIM settings
"

" == systemish settings == {{{
  set backspace=indent,eol,start  " allow backspace over everying in insert mode
  set history=1000                " remember 1000 commands and search history
  set visualbell                  " don't beep 
  set fileformats=unix,dos,mac    " be able to read os file formats without issues
  set hidden                      " handles mutliple buffers better
" }}}

" == visual settings == {{{
  syntax on                       " syntax highlighting
  set noshowmatch                 " don't jump to matching paren

" }}}

" == indentation == {{{
  set autoindent      " always autoindent
  set tabstop=4       " a tab is four spaces
  set shiftwidth=4    " number of spaces to use for autoindenting
  set expandtab       " insert spaces when tab is pressed
" }}}

" == search and quickfix == {{{
  set incsearch       " show matches as you type
  set hlsearch        " highlight search terms
  set ignorecase      " ignore case
  set smartcase       " if you search with a capital, don't ignore case
                      " Use <C L> to clear the highlighting of :set hlsearch.
" }}}


" == status bar == {{{
  "set laststatus=2    " always show status line
  set laststatus=1    " only show status line on multiple windows
  set ruler           " always show columns/lines in status 
  set wildmenu        " allow status line completions (files, commands, etc)
  set wildignorecase  " ignore case in tab complete

" }}}

" == Keybindings == {{{
  " disable ex mode
    noremap Q <NOP>    

  " preserve page up and page down
    imap <C-d> <C-o><C-d>
    imap <C-u> <C-o><C-u>
" }}}

