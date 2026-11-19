vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      check = { command = 'check' },
      cargo = { buildScripts = { enable = true } },
      procMacro = { enable = true },
    },
  },
})
vim.lsp.enable('rust_analyzer')
