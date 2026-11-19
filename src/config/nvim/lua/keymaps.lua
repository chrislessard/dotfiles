-- Keymaps.lua: Key mappings and shortcuts

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Clear search highlights when pressing <Esc>
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Open file navigation
vim.keymap.set('n', '<C-p>', ':Files<CR>', { noremap = true, silent = true })
-- Open Buffers
vim.keymap.set('n', '<C-t>', ':Buffers<CR>', { noremap = true, silent = true })
-- Open a generic Rg search
vim.keymap.set('n', '<C-S-f>', ':Rg<CR>', { noremap = true, silent = true})

-- Rg search the word under the cursor
vim.keymap.set('n', '<C-f>', function()
  local word = vim.fn.expand('<cword>')  -- Get the word under the cursor
  vim.cmd('Rg ' .. word)
end, {silent = true, noremap = true})

-- Fast split panes
vim.keymap.set('n', '<leader>h', ':split<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>v', ':vsplit<CR>', { noremap = true, silent = true })

-- Smart way to move between windows
vim.api.nvim_set_keymap('n', '<C-j>', '<C-W>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-W>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-W>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-W>l', { noremap = true })

-- Quick buffer navigation
vim.keymap.set('n', '[b', ':bprevious<CR>', { noremap = true })
vim.keymap.set('n', ']b', ':bnext<CR>', { noremap = true })

-- Delete buffer without closing window
vim.keymap.set('n', '<leader>bd', ':bp<bar>sp<bar>bn<bar>bd<CR>', { noremap = true })

-- Format JSON with jq (pretty print)
vim.keymap.set('n', '<leader>j', ':%!jq .<CR>', { noremap = true, silent = true, desc = 'Format JSON' })
vim.keymap.set('v', '<leader>j', ':!jq .<CR>', { noremap = true, silent = true, desc = 'Format JSON selection' })

-- Quick command to set JSON syntax highlighting
vim.cmd('command! Json set ft=json')

-- Yank absolute path of current file to system clipboard
vim.keymap.set('n', '<leader>yp', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
  vim.notify('Copied: ' .. path)
end, { noremap = true, silent = true, desc = 'Yank absolute file path' })
