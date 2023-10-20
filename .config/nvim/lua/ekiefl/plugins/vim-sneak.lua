return {
    'justinmk/vim-sneak',
    config = function ()
        local opts = { noremap = true, silent = true }
        -- vim.keymap.set("n", "s", "<Plug>Sneak_s", opts)
        -- vim.keymap.set("n", "S", "<Plug>Sneak_S", opts)
        -- vim.keymap.set("x", "s", "<Plug>Sneak_s", opts)
        -- vim.keymap.set("x", "S", "<Plug>Sneak_S", opts)
        -- vim.keymap.set("o", "s", "<Plug>Sneak_s", opts)
        -- vim.keymap.set("o", "S", "<Plug>Sneak_S", opts)

        -- vim.keymap.set("n", "f", "<Plug>Sneak_f", opts)
        -- vim.keymap.set("n", "F", "<Plug>Sneak_F", opts)
        -- vim.keymap.set("x", "f", "<Plug>Sneak_f", opts)
        -- vim.keymap.set("x", "F", "<Plug>Sneak_F", opts)
        -- vim.keymap.set("o", "f", "<Plug>Sneak_f", opts)
        -- vim.keymap.set("o", "F", "<Plug>Sneak_F", opts)

        -- vim.keymap.set("n", "t", "<Plug>SneakLabel_f", opts)
        -- vim.keymap.set("n", "T", "<Plug>SneakLabel_F", opts)
        -- vim.keymap.set("x", "t", "<Plug>SneakLabel_f", opts)
        -- vim.keymap.set("x", "T", "<Plug>SneakLabel_F", opts)
        -- vim.keymap.set("o", "t", "<Plug>SneakLabel_f", opts)
        -- vim.keymap.set("o", "T", "<Plug>SneakLabel_F", opts)

        vim.cmd("let g:sneak#s_next = 1")

        -- Otherwise global lets (like sneak#s_next) doesn't take effect?
        vim.cmd("call g:sneak#init()")
    end
}
