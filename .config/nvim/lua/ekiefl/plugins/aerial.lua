return {
    'stevearc/aerial.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        require('aerial').setup({
          -- optionally use on_attach to set keymaps when aerial has attached to a buffer
          on_attach = function(bufnr)
            -- Jump forwards/backwards with '{' and '}'
            vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
            vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
            vim.keymap.set('n', '<leader>gg', '<cmd>Telescope aerial<CR>', {buffer = bufnr})
          end,
          highlight_on_jump = 150,
        })
        require('telescope').load_extension('aerial')
        vim.keymap.set('n', '<leader>t', '<cmd>AerialToggle! left<CR>')
    end
}
