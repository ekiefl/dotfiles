return {
  'stevearc/oil.nvim',
  config = function()
    require('oil').setup({
      keymaps = {
        ["<Esc>"] = "actions.close",
      }
    })
  end,
  keys = {
    { '-', '<cmd>Oil<cr>', mode = 'n', desc = "Open Filesystem" },
  },
}
