local M = {}

function M.on_attach(bufnr)
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  local opts = { buffer = bufnr, silent = true }
  local map = vim.keymap.set
  map('n', 'gD', vim.lsp.buf.declaration, opts)
  map('n', 'gd', vim.lsp.buf.definition, opts)
  map('n', '<leader><leader>', vim.lsp.buf.hover, opts)
  map('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  map('n', '<leader>rn', vim.lsp.buf.rename, opts)
  map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  map('n', 'gr', vim.lsp.buf.references, opts)
  map('n', 'gi', vim.lsp.buf.implementation, opts)
  map('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, opts)
  map('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, opts)
  map('n', '<leader>q', vim.diagnostic.setloclist, opts)
  map('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts)
end

return M
