"
"" Basic VIM settings
"

" == systemish settings == {{{
  set backspace=indent,eol,start  " allow backspace over everying in insert mode
  set history=1000                " remember 1000 commands and search history
  set visualbell                  " don't beep 
  set fileformats=unix,dos,mac    " be able to read os file formats without issues
  set hidden                      " handles mutliple buffers better

  set isfname+=32                 " file name completion fixes (space, brackets)
  set isfname+=(
  set isfname+=)
  set textwidth=0                 " no auto newline
" }}}

" == visual settings == {{{
  syntax on                       " syntax highlighting
  set noshowmatch                 " don't jump to matching paren
  set showmode                    " shows the current mode
  set showcmd                     " Shows the input from an incomplete command

  set number                      " line numbers
  "set colorcolumn=81      " show a line at the 81st column
  set nowrap                      " do not wrap text in editor
  set linebreak                   " break on words when wrap is on
  set listchars=eol:¬,extends:…,precedes:…,tab:▸\ 
  "set list                " end of line/tab chars 
" }}}

" == indentation == {{{
  set autoindent      " always autoindent
  set smartindent     " smart indentation after a new line (ie, {, }, 
  set tabstop=2       " a tab is four spaces
  set shiftwidth=2    " number of spaces to use for autoindenting
  set smarttab        " insert tabs at the start of a line according to shiftwidth
  set expandtab       " insert spaces when tab is pressed
  set shiftround      " use multiple of Shiftwidth when indenting with '<' and '>'
" }}}

" == search and quickfix == {{{
  set path=.,,,**     " path for :find 
  set incsearch       " show matches as you type
  set hlsearch        " highlight search terms
  set ignorecase      " ignore case
  set smartcase       " if you search with a capital, don't ignore case
                      " Use <C L> to clear the highlighting of :set hlsearch.

  aug QFClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
  aug END

  if executable('ag') " when we have ag, use it.
    set grepprg=ag\ --nogroup\ --nocolor\ -S\ --ignore\ node_modules\ --ignore\ .git\ --ignore\ tags
  end
" }}}

" == backup and extra files == {{{
  set nobackup        " don't make backup files
  set nowritebackup   " push saves to the original file, as opposed to saving 
                      " to a new file then renaming it.
" }}}

" == scrolling ==  {{{
  set scrolloff=4         " start scrolling 8 rows above/below the top/bottom
  set sidescrolloff=8     " start scrolling 8 cols to the side fo the screen
  set sidescroll=1        " number of spaces to jump when scrolling to the side
" }}}

" == folding == {{{
  set nofoldenable
" }}}

" == Completion == {{{
  set completeopt=menuone,menu,longest
  set omnifunc=syntaxcomplete#Complete " override built-in C omnicomplete with C++ OmniCppComplete plugin
" }}}

" == status and title == {{{
  "set laststatus=2    " always show status line
  set laststatus=1    " only show status line on multiple windows
  set ruler           " always show columns/lines in status 
  set wildmenu        " allow status line completions (files, commands, etc)
  set wildignorecase  " ignore case in tab complete

  set wildignore+=**/node_modules/*
  set wildignore+=**/.git/*
  set wildignore+=**/*.o
  set wildignore+=**/*.obj
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
  set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

  set title titlestring=vim\ \-\ %t
" }}}

" == Keybindings == {{{
  " setting leader key
  let mapleader = " "

  " disable ex mode
    noremap Q <NOP>    

  " preserve page up and page down
    imap <C-d> <C-o><C-d>
    imap <C-u> <C-o><C-u>

  " == Editing == {{{
    " move by visual line -- don't skip wrapped lines.
    nnoremap j gj
    nnoremap k gk
    
    " bind \ to repeat last macro (@@)
    nnoremap \ @@
  " }}}

  " == Copy and Paste == {{{
    " These can potentially be overriden by platform specific settings
    imap <C-v> <ESC>"+pa
    vmap <C-v> c<ESC>"+p
    vmap <C-c> "+yi
    vmap <C-x> "+c
  " }}}

  " == Windows == {{{
    nmap <Leader>w <C-w>

    " Map Control-hjkl to move between windows
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
    " bd closes the current buffer. backspace goes to the last buffer
    nmap <Leader>bd :bp<bar>sp<bar>bn<bar>bd<CR>
    nmap <BS> <C-^>
  " }}}

  " == Search == {{{
    " maps control-/ to clear the current search
    if maparg('<C-_>', 'n') ==# ''
        nnoremap <silent> <C-_> :nohlsearch<CR><C-_>
    endif
  " }}}

  " == Quickfix == {{{
    augroup qf
      autocmd FileType qf set nobuflisted
      autocmd FileType qf set norelativenumber
      autocmd FileType qf set wrap
      autocmd FileType qf nmap <buffer> <UP> <UP><CR><C-w><C-p> 
      autocmd FileType qf nmap <buffer> <DOWN> <DOWN><CR><C-w><C-p> 
      autocmd FileType qf nmap <buffer> q :close<CR>
    augroup END
  " }}}


  " == Folds == {{{
    " zo - open
    " zc - close
    " zr - reduce fold level
    " zm - increase fold level
  " }}}
" }}}

" == Language Helpers {{{
  command! SortCSSBraceContents :g#\({\n\)\@<=#.,/}/sort
  nmap <Leader><Leader>css :SortCSSBraceContents<CR>
" }}}

" == Colorscheme == {{{
  colorscheme ron
" }}}

set modelines=1
" vim:foldmethod=marker:foldlevel=0

