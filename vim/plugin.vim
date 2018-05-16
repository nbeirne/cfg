" todo with plugins: 1. Install ruby
" Programs Used:
" - jslint
" - jshint
" - tern
" - clang
" - ghcmod


if exists("use_plugins")
  call plug#begin(g:plugin_path)

  " Essential Plugins
        Plug 'mhinz/vim-grepper'            " searching (faster than base.vim version)
        Plug 'yssl/QFEnter'                 " quickfix always opens last focused window
        Plug 'rgarver/Kwbd.vim'             " don't close window on :Kwbd


    " IDE-like features (none are strictly required).
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
        Plug 'junegunn/fzf.vim'

        Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle'    }
        Plug 'tpope/vim-fugitive'           " git tracking

        " disable supertab/ale for work. They appear to be broken :(
        "Plug 'ervandew/supertab'            " contextual tab complete
        "Plug 'w0rp/ale'                     " syntax errors

    " language specific plugins
        Plug 'sheerun/vim-polyglot'         " syntax + indentation for a lot of languages.

    " omni completions
        "Plug 'justmao945/vim-clang'                                " c-like
        "Plug 'keith/sourcekittendaemon.vim'                        " swift
        "Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }    " java
        "Plug 'OmniSharp/omnisharp-vim'                             " c-sharp
        "Plug 'davidhalter/jedi-vim',          { 'for': 'python'  } " python

    " colors
        Plug 'NLKNguyen/papercolor-theme'   " The best colorscheme.
        Plug 'rakr/vim-one'

  call plug#end()
    let g:Tlist_Display_Prototype = 1

  " ag config
    let g:grepper = {
      \   'tools': ['ag', 'agc', 'git', 'findf'],
      \   'open':  1,
      \   'jump':  0,
      \   'highlight': '1',
      \   'ag': { 
      \       'grepprg': 'ag --vimgrep --ignore-dir Pods/'
      \   },
      \   'findf': {
      \     'grepprg': 'find . -iregex ".*$*.*" | sed -e "s/\.\///g"',
      \     'grepformat': '%f',
      \     'escape': ''
      \   }
      \ }
    nnoremap <Leader>/ :Grepper -tool ag -highlight<CR> 
    nnoremap <Leader>* :Grepper -tool ag -highlight -noprompt -cword<CR> 

  " == Key Bindings == {{{
    " mapping toggles
        nmap <Leader>t co
        nmap <Leader>tt :TagbarToggle<CR>

    " fzf
        nmap <Leader>ff :Files<CR>
        nmap <Leader>fb :Buffers<CR>
        nmap <Leader>ft :Tags<CR>


    " Kwbd binding
        nmap <Leader>bd :Kwbd<CR>
  " }}}
  
  " language specific and omnicomplete
    " filetypes and such
        "autocmd FileType java set omnifunc=javacomplete#Complete
        "autocmd FileType c set omnifunc=ClangComplete
        "autocmd FileType objc set omnifunc=ClangComplete
        "autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

    " vim-clang
        "let g:clang_auto = 0
        "let g:clang_c_completeopt = 'menuone,preview'
        "let g:clang_cpp_completeopt = 'menuone,preview'
        "let g:clang_verbose_pmenu = 1

    " vim-android
        "let g:gradle_path = "/home/nick/.local/share/android-studio/gradle/gradle-2.14.1/bin/gradle"
        "let g:android_sdk_path = "/home/nick/.android/sdk/"

    " supertab 
        "jset completeopt=longest,menuone,preview,noinsert
        "jlet g:SuperTabDefaultCompletionType = "context"
        "jlet g:SuperTabContextDefaultCompletionType = "<c-p>"
        "jlet g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
        "jlet g:SuperTabContextDiscoverDiscovery = ["&omnifunc:<c-x><c-o>"]
        "jlet g:SuperTabCrMapping = 1
        "autocmd FileType * 
        "      \if &omnifunc != '' |
        "      \call SuperTabChain(&omnifunc, "<c-p>") |
        "      \call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
        "      \endif

    " ale 
        "let g:ale_enabled = 0
        "let g:ale_sign_column_always = 1
        "let g:ale_set_quickfix = 1
        "let g:ale_lint_delay = 500


  " colorscheme
    colorscheme PaperColor
    "colorscheme one
    set background=dark
end

