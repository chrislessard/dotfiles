vim.lsp.config('sorbet', {
  cmd = { 'bundle', 'exec', 'srb', 'tc', '--lsp' },
  root_markers = { 'sorbet/config' },
})
vim.lsp.enable({ 'ruby_lsp', 'sorbet' })
