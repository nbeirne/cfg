" todo with plugins: 1. Install ruby
"                    2. Install python-lldb
"                    3. Make sure kwbd.vim is in autoload/
"                    4. Edit Clang paths
"                    5. :PlugInstall
"                    6. In clang_complete: make install


if exists("use_plugins")
  call plug#begin(g:plugin_path)

  Plug 'mhinz/vim-grepper'
  Plug 'tpope/vim-unimpaired'
  "Plug 'kien/ctrlp.vim'

  "Plug 'chriskempson/base16-vim'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'chriskempson/base16-vim'
  Plug 'tpope/vim-fugitive'
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'rgarver/Kwbd.vim'

  " language specific plugins
  "Plug 'SolitaryCipher/vim-markdown'

  if has("macunix")
    " macOS Specific Plugins
    Plug 'msanders/cocoa.vim'
    Plug 'eraserhd/vim-ios'
  end

  if has("nvim")
    " NVIM specific plugins
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'critiqjo/lldb.nvim'
    Plug 'Rip-Rip/clang_complete'
  else
    " VIM specific plugins
    Plug 'Shougo/neocomplete'
    "Plug 'justmao945/vim-clang.git'
  end

  call plug#end()


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
  end

  let g:clang_complete_auto = 0
  let g:clang_auto_select = 0
  let g:clang_omnicppcomplete_compliance = 0
  let g:clang_make_default_keymappings = 0
  let g:clang_verbose_pmenu = 1
  let g:clang_use_library = 1
  let g:clang_snippets = 1
  let g:clang_user_options = '-std=c++11 -stdlib=libc++ -I/usr/local/include'
  let g:clang_c_options = '-std=c11 -I/usr/local/include'
  let g:clang_cpp_options = '-std=c++11 -isystem -I/usr/local/include'
  let g:clang_auto_user_options = 'compile_commands.json, .clang_complete, path'

  "let g:clang_user_options='-fblocks -isysroot /Applications/Xcode.app/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk -D__IPHONE_OS_VERSION_MIN_REQUIRED=40300'
  "autocmd FileType objc let g:clang_use_library=1
  "autocmd FileType objc let g:clang_library_path='/Developer/usr/clang-ide/lib'

  " colors
  set background=light
	"let base16colorspace=256  " Access colors present in 256 colorspace
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

  " ctrlp 
  "let g:ctrlp_show_hidden = 1
  "let g:ctrlp_extensions = ['smarttabs']

  " markdown
  let g:vim_markdown_math = 1

  " == Key Bindings == 
  " search bindings
  nmap gs  <plug>(GrepperOperator)
  xmap gs  <plug>(GrepperOperator)
  if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ -S
    "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    "let g:ctlrp_use_caching = 0

    nnoremap <Leader>/ :Grepper -tool ag -highlight<CR>
    nnoremap <Leader>* :Grepper -tool ag -cword -noprompt -highlight<CR>
  endif
  nmap <Leader>ff :Grepper -tool findf -nohighlight<CR>



  nmap <Leader>tt :NERDTreeToggle<CR>

  " CTRL P bindings
  "nmap <Leader>ff :CtrlP<CR>
  "nmap <Leader>fb :CtrlPBuffer<CR>
  "nmap <Leader>fr :CtrlPMRU<CR>
  "nmap <Leader>fq :CtrlPQuickfix<CR>

  " Vim iOS
  nmap <Leader>fm :ListMethods<CR>
  nmap <Leader>m :ListMethods<CR>

  " mapping toggles
  nmap <Leader>t co

  " Kwbd binding
  nmap <Leader>bd :Kwbd<CR>
end

