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
    Plug 'yssl/QFEnter'                 " quickfix always opens last focused window
    Plug 'rgarver/Kwbd.vim'             " don't close window on :Kwbd

    " colors
    Plug 'NLKNguyen/papercolor-theme'   " The best colorscheme.
    Plug 'joshdick/onedark.vim'
    Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }

    " IDE-like features (none are strictly required).
	"Plug 'junegunn/fzf.vim', { 'dir': '/opt/homebrew/opt/fzf' }
     Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
     Plug 'junegunn/fzf.vim'

    Plug 'ctrlpvim/ctrlp.vim'           " popup for buffers/files
    Plug 'ervandew/supertab'            " contextual tab complete
    Plug 'w0rp/ale'                     " syntax errors
    Plug 'majutsushi/tagbar',           { 'on': 'TagbarToggle'    }

    " language specific plugins
    Plug 'sheerun/vim-polyglot'         " syntax + indentation for a lot of languages.
    Plug 'sboehler/jflex-vim'
    Plug 'vim-scripts/cup.vim'

    " omni completions
    Plug 'justmao945/vim-clang'
    Plug 'keith/sourcekittendaemon.vim'
    "Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
    Plug 'eagletmt/neco-ghc',             { 'for': 'haskell' }

		Plug 'OmniSharp/omnisharp-vim' " unity

		let g:OmniSharp_selector_ui = 'fzf'    " Use fzf.vim
    "Plug 'davidhalter/jedi-vim',          { 'for': 'python'  }

    " haskell magic
    Plug 'Shougo/vimproc.vim',   { 'do': 'make'     } " used in ghcmod-vim
    Plug 'eagletmt/ghcmod-vim',  { 'for': 'haskell' } " error checking and type magic.

  call plug#end()
    let g:Tlist_Display_Prototype = 1

  " filetypes and such
    autocmd FileType java set omnifunc=javacomplete#Complete
    autocmd FileType c set omnifunc=ClangComplete
    autocmd FileType objc set omnifunc=ClangComplete
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  
  " ghc
    let g:necoghc_enable_detailed_browse = 1

  " vim-clang
    let g:clang_auto = 0
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
    let g:ale_sign_column_always = 1
    let g:ale_set_quickfix = 1
    let g:ale_lint_delay = 500

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


  " == Key Bindings == {{{
    " mapping toggles
    nmap <Leader>t co
    nmap <Leader>tt :TagbarToggle<CR>

    " CtrlP
    nmap <Leader>ff :Files<CR>
    nmap <Leader>fb :Buffers<CR>
    nmap <Leader>ft :Tags<CR>
    nmap <Leader>fq :CtrlPQuickfix<CR>
    nmap <Leader>fr :CtrlPMRU<CR>

    " Kwbd binding
    nmap <Leader>bd :Kwbd<CR>

    " haskell binding 
    map <silent> tw :GhcModTypeInsert<CR>
    map <silent> ts :GhcModSplitFunCase<CR>
    map <silent> tq :GhcModType<CR>
    map <silent> te :GhcModTypeClear<CR>
  " }}}

  " colorscheme
  set background=dark
  colorscheme challenger_deep
  "highlight Normal ctermbg=NONE
  "highlight nonText ctermbg=NONE
end

