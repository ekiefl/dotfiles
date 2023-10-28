return {
    'justinmk/vim-sneak',
    config = function ()
        local opts = { noremap = true, silent = true }

        vim.keymap.set("n", "<leader><leader>s", "<Plug>SneakLabel_f", opts)

        -- To be experimented with. This is a one letter equivalent
        -- (taken from 3-letter example in `wrap` docs)
        -- vim.keymap.set("n", "s", ":<C-U>call sneak#wrap('', 1, 0, 2, 1)<CR>", opts)

        -- Don't use ; and , to go back and forth with results, just use s and S
        -- To perform a new search, move the cursor (e.g. kj)
        vim.cmd("let g:sneak#s_next = 1")

        vim.cmd("let g:sneak#label = 1")

        -- Otherwise global lets (like sneak#s_next) don't take effect?
        vim.cmd("call g:sneak#init()")
    end
}
