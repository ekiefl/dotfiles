-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- setup with some options
require("nvim-tree").setup({
  filters = {
    dotfiles = true,
  },
})

vim.keymap.set("n", "<leader>o", ":NvimTreeFindFileToggle!<CR>")
