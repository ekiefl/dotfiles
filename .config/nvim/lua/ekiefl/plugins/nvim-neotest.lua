local M = {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter"
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-python")({
                        dap = { justMyCode = false },
                        runner = "pytest",
                        python = {
                            ".pixi/envs/default/bin/python",
                        },
                    }),
                },
            })

            -- Keybindings for Neotest
            vim.api.nvim_set_keymap('n', '<leader>ii', ":lua require('neotest').summary.toggle()<CR>",
                { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>it', ":lua require('neotest').run.run(vim.fn.expand('%:p:h'))<CR>",
                { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>id', ":lua require('neotest').run.run({ strategy = 'dap' })<CR>",
                { noremap = true, silent = true })
        end,
    },
    "nvim-neotest/neotest-python",
}

return { M }
