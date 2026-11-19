-- Plugins.lua: Plugin definitions and settings

local Plug = vim.fn['plug#']
vim.fn['plug#begin']()

Plug('catppuccin/nvim', { as = 'catppuccin' }) -- Pretty colors
Plug 'tpope/vim-sensible'            -- Sensible defaults
Plug 'junegunn/fzf'                  -- Fuzzy searching
Plug 'junegunn/fzf.vim'              -- Idem
Plug 'tpope/vim-fugitive'            -- Git commands
Plug 'tpope/vim-rhubarb'             -- Allows visiting Github URLs
Plug 'neovim/nvim-lspconfig'         -- LSP Support
Plug 'airblade/vim-gitgutter'        -- Shows git diff in the gutter
Plug 'ojroques/nvim-lspfuzzy'        -- LSP Results use FZF
Plug 'github/copilot.vim'            -- Smart autocomplete
Plug 'tpope/vim-surround'            -- Surround and replace surrounding text with quotes, brackets, etc
Plug 'tpope/vim-commentary'          -- Comment and uncomment lines
Plug 'stevearc/oil.nvim'             -- Edit directories as buffers

-- Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'

vim.fn['plug#end']()

if vim.g.dotfiles_installing then
  return
end

-- Set the background and colorscheme
vim.opt.termguicolors = true
vim.o.background = "light"
require('catppuccin').setup({ color_overrides = { latte = { yellow = '#209fb5', peach = '#179299' } } })
vim.cmd("colorscheme catppuccin-latte")

-- The BAT_THEME controls the FZF preview colorscheme.
vim.env.BAT_THEME='Catppuccin Latte'
-- THE fzf_colors table controls the colors of the FZF interface itself
vim.g.fzf_colors = {
    fg = {'fg', 'Normal'},
    bg = {'bg', 'Normal'},
    ['preview-bg'] = {'bg', 'NormalFloat'},
    hl = {'fg', 'Comment'},
    ['fg+'] = {'fg', 'CursorLine', 'CursorColumn', 'Normal'},
    ['bg+'] = {'bg', 'CursorLine', 'CursorColumn'},
    ['hl+'] = {'fg', 'Statement'},
    info = {'fg', 'PreProc'},
    border = {'fg', 'Ignore'},
    prompt = {'fg', 'Conditional'},
    pointer = {'fg', 'Exception'},
    marker = {'fg', 'Keyword'},
    spinner = {'fg', 'Label'},
    header = {'fg', 'Comment'}
}

-- Configure lspfuzzy
require('lspfuzzy').setup {
  methods = 'all',         -- either 'all' or a list of LSP methods (see below)
  jump_one = true,         -- jump immediately if there is only one location
  callback = nil,          -- callback called after jumping to a location
  fzf_preview = {          -- arguments to the FZF '--preview-window' option
    'right:+{2}-/2'          -- preview on the right and centered on entry
  },
  fzf_action = {           -- FZF actions
    ['ctrl-t'] = 'tabedit',  -- go to location in a new tab
    ['ctrl-v'] = 'vsplit',   -- go to location in a vertical split
    ['ctrl-x'] = 'split',    -- go to location in a horizontal split
  },
  fzf_modifier = ':~:.',   -- format FZF entries, see |filename-modifiers|
  fzf_trim = true,         -- trim FZF entries
}

require('oil').setup()
vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Open parent directory' })

-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Auto-detect JSON files (even without extension)
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = {'*.json', '*.jsonl', '*.geojson'},
  command = 'setfiletype json'
})

-- Return module
return {}
