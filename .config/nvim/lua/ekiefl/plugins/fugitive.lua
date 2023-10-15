return {
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set("n", "<leader>gs", function() vim.cmd.Git() end);
        vim.keymap.set("n", "<leader>gb", function() vim.cmd.Git("blame") end);
        vim.keymap.set("n", "<leader>gd", function() vim.cmd.Gvdiffsplit() end);
        vim.keymap.set("n", "<leader>gp", function() vim.cmd.Git("push") end);
    end,
}
