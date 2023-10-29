local DEFAULT = "gruvbox"
local LIGHT_OR_DARK = "dark"

----------------------------------------------------------------------------------------
-- Utilities
----------------------------------------------------------------------------------------

vim.keymap.set("n", "<C-p>", function()
  require("telescope.builtin").colorscheme({ enable_preview = true })
end, {})

local _set_default = function()
  vim.cmd(string.format("colorscheme %s", DEFAULT))
  vim.o.background = LIGHT_OR_DARK
end

----------------------------------------------------------------------------------------
-- Colorscheme plugins
----------------------------------------------------------------------------------------

local MATERIAL = {
  "marko-cerovac/material.nvim",
  config = function()
    _set_default()
  end,
}

local GRUVBOX = {
  "ellisonleao/gruvbox.nvim",
  config = function()
    require("gruvbox").setup({
      -- 'hard', 'soft', or ''
      contrast = "",
      palette_overrides = {
        dark0 = "#1d2021",
        dark0_hard = "#111111",
      },
    })
    _set_default()
  end,
}

return {
  MATERIAL,
  GRUVBOX,
}
