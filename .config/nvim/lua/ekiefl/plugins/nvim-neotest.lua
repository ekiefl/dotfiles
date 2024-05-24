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
            vim.api.nvim_set_keymap('n', '<leader>i', ":lua require('neotest').summary.toggle()<CR>",
                { noremap = true, silent = true })
        end,
    },
    "nvim-neotest/neotest-python",
}

return { M }
