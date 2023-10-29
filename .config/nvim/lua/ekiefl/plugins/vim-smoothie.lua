local SPEED = 14

return {
  "psliwka/vim-smoothie",
  config = function()
    vim.cmd("let g:smoothie_enabled = 1")
    vim.cmd("let g:smoothie_no_default_mappings = 1")

    -- Defaults are 10
    vim.cmd("let g:smoothie_speed_constant_factor = " .. SPEED)
    vim.cmd("let g:smoothie_speed_linear_factor = " .. SPEED)

    local opts = { noremap = true, silent = true }

    vim.keymap.set("n", "<S-j>", '<cmd>call smoothie#do("\\<C-D>") <CR>', opts)
    vim.keymap.set("v", "<S-j>", '<cmd>call smoothie#do("\\<C-D>") <CR>', opts)
    vim.keymap.set("n", "<S-k>", '<cmd>call smoothie#do("\\<C-U>") <CR>', opts)
    vim.keymap.set("v", "<S-k>", '<cmd>call smoothie#do("\\<C-U>") <CR>', opts)
  end,
}
