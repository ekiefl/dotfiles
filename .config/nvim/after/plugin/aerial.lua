----------------------------------------------------------------------------------------
-- Relies on treesitter. If not working for a language, add language to treesitter config
----------------------------------------------------------------------------------------

require('aerial').setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
    vim.keymap.set('n', '<leader>gg', '<cmd>Telescope aerial<CR>', {buffer = bufnr})
  end
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set('n', '<leader>t', '<cmd>AerialToggle! left<CR>')
