
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
    Plug 'tpope/vim-fugitive'           " git stuff

    Plug 'neovim/nvim-lspconfig'        " language server
    Plug 'prettier/vim-prettier', {
      \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

    
    "Plug 'ervandew/supertab'            " contextual tab complete
    "Plug 'majutsushi/tagbar' ",           { 'on': 'TagbarToggle'    }
    "Plug 'preservim/nerdtree'

    " window navigation with tmux
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'dhruvasagar/vim-zoom'

    " language specific plugins
    Plug 'sheerun/vim-polyglot'         " syntax + indentation for a lot of languages.
    Plug 'editorconfig/editorconfig-vim' " project editor configurations
    "Plug 'darfink/vim-plist'
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


    let code_extensions="(go|h|mm|m|c|sh|py|cs|java|ts|js|rb|swift|php|pl|cgi)"
    let code_cmd='ag --vimgrep --ignore "*[Tt]est*" --ignore "*[Mm]ock*" --ignore "*vendor*" -G "\.*\.'.code_extensions.'$"'
    " grepper config
    let g:grepper = {
                \ 'tools': ['code', 'ag', 'code-word'],
                \ 'simple_prompt':  1,
                \ 'prompt_text':   '\$t> ',
                \ 'open':  1,
                \ 'jump':  0,
                \ 'highlight': '1',
                \ 'code': {
                \     'grepprg': code_cmd . ' "$*"',
                \     'grepformat': '%f:%l:%c:%m,%f:%l:%m,%f',
                \     'escape':     '^$.*+?()[]{}|"' },
                \ 'code-word': {
                \     'grepprg': code_cmd ,
                \     'grepformat': '%f:%l:%c:%m,%f:%l:%m,%f',
                \     'escape':     '^$.*+?()[]{}|"' },
                \ }
    let g:grepper.prompt_text = '$c> '
    nnoremap <Leader>/ :Grepper<CR>
    nnoremap <Leader>* :Grepper -tool code-word -highlight -noprompt -cword<CR> 
    command! -nargs=+ Scode :Grepper -tool code -highlight -noprompt -query '<args>' 
    command! Todo :Grepper -tool ag -query '\(TODO\|FIXME\)'

    "ag --vimgrep> '\binitializeWithGameId\b' --ignore '*Tests*'  -G '\.*\.m'


    " fzf config
    nmap <Leader>ff :Files<CR>
    nmap <Leader>fb :Buffers<CR>
    nmap <Leader>ft :Tags<CR>

    " supertab config
    "set completeopt=longest,menuone,preview,noinsert
    "let g:SuperTabDefaultCompletionType = "context"
    "let g:SuperTabContextDefaultCompletionType = "<c-p>"
    "let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
    "let g:SuperTabContextDiscoverDiscovery = ["&omnifunc:<c-x><c-o>"]
    "let g:SuperTabCrMapping = 1
    "autocmd FileType * 
    "            \if &omnifunc != '' |
    "            \call SuperTabChain(&omnifunc, "<c-p>") |
    "            \call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
    "            \endif

    " tagbar config
    "nmap <Leader>t co
    "nmap <Leader>tt :TagbarToggle<CR>

    " prettier
    "let g:prettier#autoformat = 1
    "let g:prettier#autoformat_require_pragma = 0



    " zoom window
    nmap <Leader>= <C-w>m
    nmap <C-=> <C-w>m

    if has("nvim")
        exec "so " . g:load_path . "/lsp.lua"
    end
end

