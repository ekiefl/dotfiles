return {
    "takac/vim-hardtime",
    config = function()
        vim.api.nvim_set_keymap("n", "<leader><leader>j", ":HardTimeToggle<CR>", {})
        vim.g.hardtime_allow_different_key = 1
        vim.g.hardtime_motion_with_count_resets = 1
        vim.g.hardtime_default_on = 1
    end
}
