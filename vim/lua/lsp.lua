
vim.lsp.enable("pyright")
vim.lsp.enable("ts_ls")
vim.lsp.enable("eslint")
vim.lsp.enable("sourcekit")
vim.lsp.enable("yamlls")
vim.lsp.enable("hls")
vim.lsp.enable("clangd")
vim.lsp.enable("rust_analyzer")


-- nvim's built-in LSP defaults (:help lsp-defaults).
--   <C-]>        definition (via tagfunc; <C-w>] in a split)
--   K            hover
--   grr          references
--   gri          implementation
--   grt          type definition
--   grn          rename
--   gra          code action (normal + visual)
--   grx          run codelens
--   gO           document symbols
--   <C-s>        signature help (insert mode)
--   <C-x><C-o>   completion (insert mode)
--   gq           format via LSP (gw to bypass)
--   ]d [d        next / prev diagnostic (]D [D for last / first)
--   <C-w>d       diagnostic float
--
-- useful commands:
--   :lua vim.lsp.buf.declaration()
--   :lua vim.lsp.buf.incoming_calls()          (outgoing_calls)
--   :lua vim.lsp.buf.workspace_symbol()
--   :lua vim.diagnostic.setqflist()            all diagnostics -> quickfix
--   :lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
--   :lua vim.lsp.buf.list_workspace_folders()  (add_/remove_workspace_folder)
--   :checkhealth vim.lsp                       attached clients, config, logs
--   :lsp restart | stop | enable | disable [name]
