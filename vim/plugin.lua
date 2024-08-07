
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
  { 
    "challenger-deep-theme/vim",
    lazy = false,
    priority = 1000,
    config = function() 
      vim.cmd [[colorscheme challenger_deep]]
    end,
  },

  -- Window navigation with tmux
  "christoomey/vim-tmux-navigator",

  { 
    "declancm/maximize.nvim", 
    keys = { 
      "<Leader>z",
      { "<C-w>=", "<Cmd>lua require('maximize').toggle()<CR>" },
      { "<Leader>=", "<Cmd>lua require('maximize').toggle()<CR>" },
    },
    opts = {}, -- call setup
  },

  "yssl/QFEnter",

  { 
    "rgarver/Kwbd.vim",
    keys = {
      { "<Leader>bd", "<cmd>Kwbd<cr>" }
    },
  },

  { -- todo: switch to rg?
    "mhinz/vim-grepper",
    lazy = false,
    keys = { 
      { "<Leader>/", "<cmd>Grepper<CR>" },
      { "<Leader>*", "<cmd>Grepper -tool code-word -highlight -noprompt -cword<CR>" },
    },
    config = function()
      vim.cmd([[
        let code_extensions = "(go|h|mm|m|c|sh|py|cs|java|ts|js|rb|swift|php|pl|cgi)"
        let code_cmd='ag --vimgrep --ignore "*[Tt]est*" --ignore "*[Mm]ock*" --ignore "*vendor*" -G "\\.*\\.' . code_extensions . '$"'
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
                \     'grepprg': code_cmd,
                \     'grepformat': '%f:%l:%c:%m,%f:%l:%m,%f',
                \     'escape':     '^$.*+?()[]{}|"' },
                \ }
      ]])

    end,
  },

  { -- manage tags using m and '
    "kshenoy/vim-signature",
    --keys = {
    --  "mx",
    --  "dmx",
    --  "m,",
    --  "m.",
    --  "m-",
    --  "m<Space>",
    --  "m/",
    --}
  },

  --- IDE like features.
  'tpope/vim-fugitive', -- git 
  'tpope/vim-surround', 


  {
    "nvim-telescope/telescope.nvim", tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "Telescope",
    },
    keys = {
      { "<Leader>ff", "<cmd>Telescope find_files<CR>" },
      { "<Leader>fg", "<cmd>Telescope git_files<CR>" },
      { "<Leader>fb", "<cmd>Telescope buffers<CR>" },
      { "<Leader>fg", "<cmd>Telescope live_grep<CR>" },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
     "nvim-tree/nvim-web-devicons",
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true
      require("nvim-tree").setup({})
    end,
  },

  -- language plugins
  "sheerun/vim-polyglot",          -- syntax + indentation for a lot of languages.
  "editorconfig/editorconfig-vim", -- project editor configurations

  { 
    "neovim/nvim-lspconfig",
    config = function()
      require("lsp")
    end,
  },

  {
    "prettier/vim-prettier",
    ft = { "javascript", "typescript", "css", "less", "scss", "json", "graphql", "markdown", "vue", "svelte", "yaml", "html" },
  },

})


