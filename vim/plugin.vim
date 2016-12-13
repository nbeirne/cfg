" todo with plugins: 1. Install ruby
"
"                    2. Install python-lldb
"                    3. Make sure kwbd.vim is in autoload/
"                    4. Edit Clang paths
"                    5. :PlugInstall
"                    6. In clang_complete: make install


if exists("use_plugins")
  call plug#begin(g:plugin_path)

  Plug 'mhinz/vim-grepper'    " better grep
  Plug 'tpope/vim-unimpaired' " toggles and ]b [b
  Plug 'yssl/QFEnter'         " quickfix always opens last focused window
  Plug 'rgarver/Kwbd.vim'     " don't close window on :Kwbd

  "Plug 'nickburlett/vim-colors-stylus'
  Plug 'reedes/vim-colors-pencil'
  Plug 'NLKNguyen/papercolor-theme'
  "Plug 'chriskempson/base16-vim'

  "set t_Co=256
  "let &t_AB="\e[48;5;%dm"
  "let &t_AF="\e[38;5;%dm"

  " language specific plugins - for completions + syntax checking.

  if has("nvim")
    " NVIM specific plugins
    " completion plugins
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'neomake/neomake'           " syntax checker

    " c
    "Plug 'zchee/deoplete-clang' " completions

    " haskell 
    Plug 'eagletmt/neco-ghc'         " completions
    Plug 'neovimhaskell/haskell-vim' " better highlighting + indentation
    Plug 'eagletmt/ghcmod-vim'       " error checking and type magic.
    Plug 'Shougo/vimproc.vim', {'do': 'make'}
 
  else
    " VIM specific plugins
    Plug 'Shougo/neocomplete'
  end

  call plug#end()

  inoremap <silent><expr><CR>  pumvisible() ? "\<C-y>" : "\<CR>"

  function! s:neosnippet_complete()
  if pumvisible()
    return "\<c-n>"
  else
    if neosnippet#expandable_or_jumpable() 
      return "\<Plug>(neosnippet_expand_or_jump)"
    endif
    return "\<tab>"
  endif
endfunction

imap <expr><TAB> <SID>neosnippet_complete()
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

  " clang, neocomplete, and deoplete config
  if has("nvim")
    call deoplete#enable()

    inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#mappings#manual_complete()
      function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
      endfunction
  else
    let g:neocomplete#enable_at_startup = 1

    inoremap <silent><expr><TAB>  
              \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<TAB>" :
              \ neocomplete#start_manual_complete()
      function! s:check_back_space() "{{{
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
      endfunction
  end

  if has("macunix")
    let g:clang_library_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
  else
    let g:clang_library_path = '/usr/lib/llvm-3.6/lib/libclang.so.1'
    let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.6/lib/libclang.so.1'
    let g:deoplete#sources#clang#clang_header = '/usr/lib/llvm-3.6/lib/clang/3.6.2/include'
  end

  let g:clang_complete_auto = 0
  let g:clang_auto_select = 0
  let g:clang_omnicppcomplete_compliance = 0
  let g:clang_make_default_keymappings = 0
  let g:clang_verbose_pmenu = 1
  let g:clang_use_library = 1
  let g:clang_snippets = 1
  let g:clang_user_options = '-std=c++11 -stdlib=libc++ -I/usr/local/include'
  let g:clang_c_options = '-std=c11 -I/usr/local/include -Iinclude/'
  let g:clang_cpp_options = '-std=c++11 -isystem -I/usr/local/include'
  let g:clang_auto_user_options = 'compile_commands.json, .clang_complete, path'


  " haskell syntax + indentation   
  let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
  let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
  let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
  let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
  let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
  let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`

  let g:haskell_indent_if = 2
  let g:haskell_indent_case = 2

  autocmd! BufWritePost * Neomake

	map <silent> tw :GhcModTypeInsert<CR>
	map <silent> ts :GhcModSplitFunCase<CR>
	map <silent> tq :GhcModType<CR>
	map <silent> te :GhcModTypeClear<CR>

  set background=light
  let base16colorspace=256
  colorscheme PaperColor

  " ag config
  let g:grepper = { 
    \ 'tools': ['ag', 'git', 'findf'],
    \ 'open':  1,
    \ 'jump':  0,
    \ 'highlight': '1',
    \ 'findf': {
    \   'grepprg': 'find . -iregex ".*$*.*" | sed -e "s/\.\///g"',
    \   'grepformat': '%f',
    \   'escape': ''
    \ }}

  " == Key Bindings == 
  " search bindings
  nmap gs  <plug>(GrepperOperator)
  xmap gs  <plug>(GrepperOperator)
  if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctlrp_use_caching = 0

    nnoremap <Leader>/ :Grepper -tool ag -highlight<CR>
    nnoremap <Leader>* :Grepper -tool ag -cword -noprompt -highlight<CR>
  endif

  " mapping toggles
  nmap <Leader>t co

  " Kwbd binding
  nmap <Leader>bd :Kwbd<CR>
end

