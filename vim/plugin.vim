" todo with plugins: 1. Install ruby
" Programs Used:
" - jslint
" - jshint
" - tern
" - clang
" - ghcmod


if exists("use_plugins")
  call plug#begin(g:plugin_path)

    Plug 'mhinz/vim-grepper'            " searching (faster than base.vim version)
    Plug 'tpope/vim-unimpaired'         " toggles and ][ commands
    Plug 'yssl/QFEnter'                 " quickfix always opens last focused window
    Plug 'rgarver/Kwbd.vim'             " don't close window on :Kwbd

    " colors
    Plug 'NLKNguyen/papercolor-theme'   " The best colorscheme.

    " IDE-like features (none are strictly required).
    Plug 'ervandew/supertab'            " contextual tab complete
    Plug 'vim-syntastic/syntastic'      " syntax checker
    Plug 'ludovicchabant/vim-gutentags' " auto generate tags
    Plug 'ctrlpvim/ctrlp.vim'           " searching
    Plug 'majutsushi/tagbar',           { 'on': 'TagbarToggle'    }
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'airblade/vim-gitgutter',      { 'on': 'GitGutterToggle' }

    " language specific plugins
    Plug 'sheerun/vim-polyglot'         " syntax + indentation for a lot of languages.

    " omni completions
    Plug 'justmao945/vim-clang'
    Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
    Plug 'ternjs/tern_for_vim',           { 'for': 'javascript', 'do': 'npm install' }
    Plug 'eagletmt/neco-ghc',             { 'for': 'haskell' }
    "Plug 'davidhalter/jedi-vim',          { 'for': 'python'  }

    " haskell magic
    Plug 'Shougo/vimproc.vim',   { 'do': 'make'     } " used in ghcmod-vim
    Plug 'eagletmt/ghcmod-vim',  { 'for': 'haskell' } " error checking and type magic.

    " testing
    "Plug 'jiangmiao/auto-pairs'
    "Plug 'Rip-Rip/clang_complete'
    "Plug 'msanders/cocoa.vim'             " completions for objc 

    "Plug 'vim-scripts/L9'
    "Plug 'vim-scripts/FuzzyFinder'
    "Plug 'junegunn/fzf'
    "Plug 'junegunn/fzf.vim'

    "Plug 'Shougo/Unite.vim'      " replace ctrlp
    "Plug 'Shougo/vimfiler.vim'   " does not have git status (replace nerdtree)
    "Plug 'Shougo/unite-outline'  " replace tagbar
    "Plug 'Shougo/neoinclude.vim'  " replace tagbar(2)
    "Plug 'tsukkee/unite-tag'     " part of ctrlp (tag search)

    " debuggers
    "Plug  'joonty/vdebug'
    Plug 'hsanson/vim-android'
    Plug 'idanarye/vim-vebugger'
    "Plug 'vim-scripts/yavdb'

  call plug#end()

  " filetypes and such
    autocmd FileType java set omnifunc=javacomplete#Complete
    autocmd FileType c set omnifunc=ClangComplete
    autocmd FileType objc set omnifunc=ClangComplete
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  
  " ghc
    let g:necoghc_enable_detailed_browse = 1

  " vim-clang
    let g:clang_auto = 1
    let g:clang_c_completeopt = 'menuone,preview'
    let g:clang_cpp_completeopt = 'menuone,preview'
    let g:clang_verbose_pmenu = 1

  " vim-android
    let g:gradle_path = "/home/nick/.local/share/android-studio/gradle/gradle-2.14.1/bin/gradle"
    let g:android_sdk_path = "/home/nick/.android/sdk/"

  " supertab 
    set completeopt=longest,menuone,preview,noinsert
    let g:SuperTabDefaultCompletionType = "context"
    let g:SuperTabContextDefaultCompletionType = "<c-p>"
    let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
    let g:SuperTabContextDiscoverDiscovery = ["&omnifunc:<c-x><c-o>"]
    let g:SuperTabCrMapping = 1
    autocmd FileType * 
          \if &omnifunc != '' |
          \call SuperTabChain(&omnifunc, "<c-p>") |
          \call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
          \endif

  " syntastic 
    set statusline^=%*
    set statusline^=%{SyntasticStatuslineFlag()}
    set statusline^=%#warningmsg#

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 0
    let g:syntastic_check_on_wq = 0
    let g:syntastic_java_javac_classpath = "~/.android/sdk/platforms/android-25/*.jar"
    let g:syntastic_java_javac_config_file_enabled = 1
    let g:syntastic_check_on_open = 1


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
    nnoremap <Leader>/ :Grepper -tool ag -highlight<CR> 
    nnoremap <Leader>* :Grepper -tool ag -highlight -noprompt -cword<CR> 


  "ctrlp 
    "set tags=./.git/tags
    if executable('ag')
      let g:ctrlp_user_command = 'ag %s -l --nocolor -g "" --ignore node_modules --ignore .git'
      let g:ctlrp_use_caching = 0
    endif

  " NERDTree
    " close when its the last window
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    let g:NERDTreeDirArrowExpandable = '▶'
    let g:NERDTreeDirArrowCollapsible = '▼'


  " == Key Bindings == {{{
    " mapping toggles
    nmap <Leader>t co
    nmap <Leader>tt :TagbarToggle<CR>
    nmap <Leader>tf :NERDTreeToggle<CR>
    nmap <Leader>tg :GitGutterToggle<CR>

    " CtrlP
    nmap <Leader>ff :CtrlP<CR>
    nmap <Leader>fb :CtrlPBuffer<CR>
    nmap <Leader>ft :CtrlPTag<CR>

    " Kwbd binding
    nmap <Leader>bd :Kwbd<CR>

    " haskell binding 
    map <silent> tw :GhcModTypeInsert<CR>
    map <silent> ts :GhcModSplitFunCase<CR>
    map <silent> tq :GhcModType<CR>
    map <silent> te :GhcModTypeClear<CR>
  " }}}

  " colorscheme
  set background=light
  let base16colorspace=256
  colorscheme PaperColor

end

