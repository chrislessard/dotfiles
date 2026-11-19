require('options')
require('keymaps')
require('plugins')
if vim.g.dotfiles_installing then
  return
end

require('lsp')
require('lang.ruby')
require('utils')
