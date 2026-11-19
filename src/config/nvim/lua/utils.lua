vim.api.nvim_create_user_command('GBrowseCopy', function(args)
  vim.cmd(('%d,%dGBrowse!'):format(args.line1, args.line2))
end, { range = true, desc = 'Copy GitHub link' })

vim.keymap.set('n', 'ogb', '<cmd>.GBrowse<CR>', { desc = 'Open GitHub link' })
vim.keymap.set('x', 'ogb', ':GBrowse<CR>', { desc = 'Open GitHub link for selection' })
vim.keymap.set('n', 'gb', '<cmd>GBrowseCopy<CR>', { desc = 'Copy GitHub link' })
vim.keymap.set('x', 'gb', ':GBrowseCopy<CR>', { desc = 'Copy GitHub link for selection' })
