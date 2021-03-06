
if exists("use_plugins")
    call plug#begin(g:plugin_path)

    " plugins which help my specific workflow
    Plug 'mhinz/vim-grepper'            " searching (faster than base.vim version)
    Plug 'yssl/QFEnter'                 " quickfix always opens last focused window
    Plug 'rgarver/Kwbd.vim'             " don't close window on :Kwbd

    " colors
    Plug 'NLKNguyen/papercolor-theme'   " The best colorscheme.
    Plug 'joshdick/onedark.vim'
    Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }

    " IDE-like features (none are strictly required).
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'ervandew/supertab'            " contextual tab complete
    Plug 'majutsushi/tagbar',           { 'on': 'TagbarToggle'    }

    " language specific plugins
    Plug 'sheerun/vim-polyglot'         " syntax + indentation for a lot of languages.

    " language completions and syntax errors. 
    "Plug 'w0rp/ale'                     " syntax errors

    call plug#end()

    " colorscheme
    set background=dark
    colorscheme challenger_deep
    "highlight Normal ctermbg=NONE
    "highlight nonText ctermbg=NONE


    " Kwbd config
    nmap <Leader>bd :Kwbd<CR>


    " grepper config
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


    " fzf config
    nmap <Leader>ff :Files<CR>
    nmap <Leader>fb :Buffers<CR>
    nmap <Leader>ft :Tags<CR>


    " supertab config
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


    " tagbar config
    nmap <Leader>t co
    nmap <Leader>tt :TagbarToggle<CR>
end

