local M = {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      indent = {
        enable = false,
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = {},
      },
    })
  end,
}

return { M }
