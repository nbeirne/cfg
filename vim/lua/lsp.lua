-- Setup language servers.
local lspconfig = require('lspconfig')

-- set up pyright and tsserver.
-- npm install -g typescript-language-server typescript vscode-langservers-extracted @tailwindcss/language-server
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
lspconfig.eslint.setup {}
lspconfig.sourcekit.setup {}
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
--vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
--vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
--vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
--vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

    vim.keymap.set('n', 'gii', vim.lsp.buf.incoming_calls, opts)
    --vim.keymap.set('n', 'gio', vim.lsp.buf.outgoing_calls, opts)

    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)

    vim.keymap.set('n', '<Leader>h', vim.lsp.buf.signature_help, opts)

    -- rename and refs dont really work as I want.
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<Leader>fm', function()
      vim.lsp.buf.format { async = true }
    end, opts)


    vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<Leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

  end,
})

