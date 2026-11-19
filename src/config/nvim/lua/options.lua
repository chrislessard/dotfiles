-- Options.lua: Vim options and settings

local opt = vim.opt

-- Presentation
opt.mouse = 'a'
opt.showmode = false               -- Don't show current mode
opt.number = true                  -- Show line numbers
opt.relativenumber = true          -- Make line numbers relative to cursor
opt.splitright = true              -- Vertical split to the right
opt.splitbelow = true              -- Horizontal split downwards
opt.cursorline = true              -- Show which line the cursor is on
opt.scrolloff = 10                 -- Always pad lines above/below this cursor
opt.inccommand = 'split'           -- Preview substitutions outside of current view
opt.undofile = true                -- Persistent history between sessions

-- Formatting
opt.backspace = 'indent,eol,start' -- Let backspace wrap
opt.whichwrap:append('<,>,h,l')    -- Let movement wrap
opt.expandtab = true               -- Use spaces instead of tabs
opt.smarttab = true                -- Be smart when using tabs
opt.shiftwidth = 2                 -- Tab width
opt.tabstop = 2                    -- "same"
opt.autoindent = true              -- Auto indent
opt.smartindent = true             -- Smart indent
opt.wrap = true                    -- Wrap lines
opt.textwidth = 120                -- Limit line length
opt.linebreak = true               -- Soft wrap at word boundaries
opt.foldmethod = 'indent'          -- Fold by indent
opt.foldlevel = 99                 -- Open all folds by default
opt.foldnestmax = 3                -- Maximum fold depth

-- Don't auto-insert newlines while typing (textwidth stays useful for manual `gq`).
-- Must be a FileType autocmd: ftplugins (e.g. markdown) re-add 't' after options.lua runs.
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove('t')
  end,
})

-- IDE-like behaviour
opt.ignorecase = true              -- Ignore case when searching
opt.hlsearch = true                -- Highlight search results
opt.incsearch = true               -- Search as I type
opt.smartcase = true               -- When searching try to be smart about cases
opt.signcolumn = 'yes'             -- Show the signcolumn, for debugging, git plugins, etc

-- Delay overrides. Only useful for suggestions plugin
opt.updatetime = 250               -- Decrease update time
opt.timeoutlen = 300               -- Decrease mapped sequence wait time

-- Sync clipboard between OS and Neovim. Schedule
-- post `UiEnter` to reduce startup time.
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

vim.env.FZF_DEFAULT_OPTS = '--ignore-case'
vim.env.FZF_DEFAULT_COMMAND = "rg --files --hidden --glob '!.git/**'"

-- Return module
return {}
