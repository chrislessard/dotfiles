vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Presentation
vim.opt.mouse = 'a'                    -- I'm not there yet 
vim.opt.showmode = false               -- Don't show current mode
vim.opt.number = true 		             -- Show line numbers
vim.opt.relativenumber = true          -- Make line numbers relative to cursor
vim.opt.splitright = true              -- Vertical split to the right
vim.opt.splitbelow = true              -- Horizontal split downwards
vim.opt.cursorline = true              -- Show which line the cursor is on 
vim.opt.scrolloff = 10                 -- Always pad lines above/below this cursor
vim.opt.inccommand = 'split'           -- Preview substitutions outside of current view
vim.opt.undofile = true                -- Persistent history between sessions

-- Formatting
vim.opt.backspace = 'indent,eol,start' -- Let backspace wrap
vim.opt.whichwrap:append('<,>,h,l')    -- Let movement wrap
vim.opt.expandtab = true               -- Use spaces instead of tabs
vim.opt.smarttab = true                -- Be smart when using tabs
vim.opt.shiftwidth = 2                 -- Tab width
vim.opt.tabstop = 2                    -- "
vim.opt.autoindent = true              -- Auto indent
vim.opt.smartindent = true             -- Smart indent
vim.opt.wrap = true                    -- Wrap lines
vim.opt.textwidth = 80                 -- Limit line length
vim.opt.linebreak = true               -- Soft wrap at word boundaries

-- IDE-like behaviour
vim.opt.ignorecase = true              -- Ignore case when searching
vim.opt.hlsearch = true                -- Highlight search results
vim.opt.incsearch = true               -- Search as I type
vim.opt.smartcase = true               -- When searching try to be smart about cases
vim.opt.signcolumn = 'yes'             -- Show the signcolumn, for debugging, git plugins, etc

-- Delay overrides. Only useful for suggestions plugin
vim.opt.updatetime = 250               -- Decrease update time
vim.opt.timeoutlen = 300               -- Decrease mapped sequence wait time

-- Sync clipboard between OS and Newovim. Schedule
-- post `UiEnter` to reduce startup time.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Keymaps

-- Clear search highlights when pressing <Esc>
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Open file navigation
vim.keymap.set('n', '<C-p>', ':GFiles<CR>', { noremap = true, silent = true })
-- Open Buffers
vim.keymap.set('n', '<C-t>', ':Buffers<CR>', { noremap = true, silent = true })
-- Open a generic Ag search
vim.keymap.set('n', '<C-S-f>', ':Ag<CR>', { noremap =true, silent = true})

-- Ag search the word under the cursor
vim.keymap.set('n', '<C-f>', function()
  local word = vim.fn.expand('<cword>')  -- Get the word under the cursor
  vim.cmd('Ag ' .. word)
end, {silent = true, noremap = true})

-- Fast split panes
vim.keymap.set('n', '<leader>h', ':split<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>v', ':vsplit<CR>', { noremap = true, silent = true })

-- Smart way to move between windows
vim.api.nvim_set_keymap('n', '<C-j>', '<C-W>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-W>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-W>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-W>l', { noremap = true })

local Plug = vim.fn['plug#']
vim.fn['plug#begin']()

Plug 'NLKNguyen/papercolor-theme'    -- Pretty colors
Plug 'tpope/vim-sensible'            -- Sensible defaults
Plug 'junegunn/fzf'                  -- Fuzzy searching
Plug 'junegunn/fzf.vim'              -- Idem
Plug 'github/copilot.vim'            -- Smart autocomplete
Plug 'tpope/vim-fugitive'            -- Git commands
Plug 'tpope/vim-rhubarb'             -- Allows visiting Github URLs
Plug 'neovim/nvim-lspconfig'         -- LSP Support
Plug 'airblade/vim-gitgutter'        -- Shows git diff in the gutter
Plug 'ojroques/nvim-lspfuzzy'        -- LSP Results use FZF
Plug 'hrsh7th/nvim-cmp'

-- Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'

vim.fn['plug#end']()

-- Set the background and colorscheme
vim.opt.termguicolors = true
vim.o.background = "light"
vim.cmd("colorscheme PaperColor")

-- Automatically match FZF to the current colorscheme
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

-- LSP
local lspconfig = require 'lspconfig'

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader><leader>', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
end

lspconfig.ruby_lsp.setup({ on_attach = on_attach })
lspconfig.sorbet.setup({ on_attach = on_attach })

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

-- Language Support

-- Ruby
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  command = "setlocal iskeyword-=."
})
vim.g.rails_projections = {
  ["config/routes.rb"] = {
    command = "routes"
  },
  ["spec/features/*_spec.rb"] = {
    type = "feature",
    template = {
      "require 'rails_helper'",
      "",
      "feature '{underscore|capitalize|blank}' do",
      "",
      "end"
    }
  }
}
vim.g.rails_gem_projections = {
  ["factory_bot_rails"] = {
    ["spec/factories/*.rb"] = {
      type = "factory",
      template = {
        "FactoryBot.define do",
        "  factory :{underscore} do",
        "",
        "  end",
        "end"
      },
      related = "app/models/{}.rb"
    }
  }
}

-- Fade out sorbet signatures
vim.api.nvim_create_augroup("format_ruby", { clear = true })
vim.api.nvim_create_autocmd("Syntax", {
  pattern = "ruby",
  command = "syntax region sorbetSig start='sig {' end='}'",
  group = "format_ruby"
})
vim.api.nvim_create_autocmd("Syntax", {
  pattern = "ruby",
  command = "syntax region sorbetSig start='sig do' end='end'",
  group = "format_ruby"
})
vim.api.nvim_create_autocmd("Syntax", {
  pattern = "ruby",
  command = "highlight link sorbetSig Comment",
  group = "format_ruby"
})

vim.g.splitjoin_trailing_comma = 1
vim.g.splitjoin_ruby_hanging_args = 0
vim.g.splitjoin_ruby_curly_braces = 0
vim.g.splitjoin_ruby_options_as_arguments = 1

-- Autocommands

-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Autodisable stuff for ruby lsp
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.name == "ruby_lsp" then
      client.server_capabilities.definitionProvider = nil
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

