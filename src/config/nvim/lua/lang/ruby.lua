-- Ruby specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  command = "setlocal iskeyword-=."
})

-- Rails projections
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

-- Rails gem projections
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

-- Return module
return {}