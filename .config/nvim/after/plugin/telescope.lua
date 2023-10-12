local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>f', function()
    local curr_dir = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':h')
	builtin.git_files({ cwd = curr_dir, use_git_root = true });
end)

