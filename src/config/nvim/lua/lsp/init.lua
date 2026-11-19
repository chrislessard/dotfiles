local common = require('lsp.common')
local clients = setmetatable({}, { __mode = 'k' })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    if not clients[client] then
      client.request = require('lspfuzzy').wrap_request(client.request)
      clients[client] = true
    end
    common.on_attach(args.buf)
  end,
})

vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

require('lsp.ruby')
require('lsp.rust')
