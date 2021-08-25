
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
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'ervandew/supertab'            " contextual tab complete
    Plug 'majutsushi/tagbar' ",           { 'on': 'TagbarToggle'    }
    Plug 'tpope/vim-fugitive'           " git stuff

    " window navigation with tmux
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'dhruvasagar/vim-zoom'

    " language specific plugins
    Plug 'sheerun/vim-polyglot'         " syntax + indentation for a lot of languages.
    Plug 'editorconfig/editorconfig-vim' " configurable stuff

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
                \ 'tools': ['ag', 'code', 'git', 'findf'],
                \ 'open':  1,
                \ 'jump':  0,
                \ 'highlight': '1',
                \ 'findf': {
                \     'grepprg': 'find . -iregex ".*$*.*" | sed -e "s/\.\///g"',
                \     'grepformat': '%f',
                \     'escape': '' },
                \ 'code': {
                \     'grepprg': 'ag --vimgrep -G "\.*\.[hmc]m?$" --ignore "*Tests*"',
                \     'grepformat': '%f:%l:%c:%m,%f:%l:%m,%f',
                \     'escape':     '\^$.*+?()[]{}|' },
                \ }
    nnoremap <Leader>/ :Grepper -tool ag -highlight<CR> 
    nnoremap <Leader>* :Grepper -tool ag -highlight -noprompt -cword<CR> 
    command! -nargs=+ Scode :Grepper -tool code -highlight -noprompt -query '<args>' 
    command! Todo :Grepper -tool ag -query '\(TODO\|FIXME\)'

    "ag --vimgrep> '\binitializeWithGameId\b' --ignore '*Tests*'  -G '\.*\.m'


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


    " zoom window
    nmap <Leader>= <C-w>m
    nmap <C-=> <C-w>m
end

