"
"" nvim entry point
"

set modelines=1

runtime base.vim

" == plugins == 

" nvim-tree replaces netrw; must be set before netrw's plugin/ script loads.
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" :lua vim.pack.update()           review in new tab, :w to apply, :q to cancel
" :lua vim.pack.del({ "name" })    after removing a plugin from this list
lua << EOF
vim.pack.add({
  { src = "https://github.com/challenger-deep-theme/vim", name = "challenger-deep" },

  { src = "https://github.com/christoomey/vim-tmux-navigator" }, -- window navigation with tmux
  { src = "https://github.com/rgarver/Kwbd.vim" },
  -- { src = "https://github.com/mhinz/vim-grepper" }, -- config below

  --- IDE like features.
  { src = "https://github.com/tpope/vim-fugitive" }, -- git
  { src = "https://github.com/tpope/vim-surround" }, -- delete and change within pairs. noun: s<Q> (cs'")

  { src = "https://github.com/nvim-telescope/telescope.nvim" }, -- window for searching buffers/files
  { src = "https://github.com/nvim-lua/plenary.nvim" },         -- required for telescope

  { src = "https://github.com/nvim-tree/nvim-tree.lua", version = vim.version.range("*") },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },

  -- language plugins
  { src = "https://github.com/neovim/nvim-lspconfig" },
})

require("nvim-tree").setup({})
require("lsp")
EOF

colorscheme challenger_deep

nnoremap <Leader>bd <cmd>Kwbd<CR>
nnoremap <Leader>ff <cmd>Telescope find_files<CR>
nnoremap <Leader>fG <cmd>Telescope git_files<CR>
nnoremap <Leader>fb <cmd>Telescope buffers<CR>
nnoremap <Leader>fg <cmd>Telescope live_grep<CR>

" vim-grepper
"nnoremap <Leader>/ <cmd>Grepper<CR>
"nnoremap <Leader>* <cmd>Grepper -tool code-word -highlight -noprompt -cword<CR>
"let s:code_extensions = "(go|h|mm|m|c|sh|py|cs|java|ts|js|rb|swift|php|pl|cgi)"
"let s:code_cmd = 'ag --vimgrep --ignore "*[Tt]est*" --ignore "*[Mm]ock*" --ignore "*vendor*" -G "\\.*\\.' . s:code_extensions . '$"'
"let g:grepper = {
"      \ 'tools': ['code', 'ag', 'code-word'],
"      \ 'simple_prompt':  1,
"      \ 'prompt_text':   '\$t> ',
"      \ 'open':  1,
"      \ 'jump':  0,
"      \ 'highlight': '1',
"      \ 'code': {
"      \     'grepprg': s:code_cmd . ' "$*"',
"      \     'grepformat': '%f:%l:%c:%m,%f:%l:%m,%f',
"      \     'escape':     '^$.*+?()[]{}|"' },
"      \ 'code-word': {
"      \     'grepprg': s:code_cmd,
"      \     'grepformat': '%f:%l:%c:%m,%f:%l:%m,%f',
"      \     'escape':     '^$.*+?()[]{}|"' },
"      \ }

