vim.g.mapleader = " "

-- Explorer
vim.keymap.set("n", "<leader>o", vim.cmd.Ex, { noremap = true })

-- Fast save, write, close
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true})
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true})
vim.keymap.set("n", "<leader>fq", ":qa!<CR>", { noremap = true})
vim.keymap.set("n", "<leader>e", ":e<space>", { noremap = true})

-- Split navigation
vim.keymap.set("n", "<C-J>", "<C-W><C-J>", { noremap = true})
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", { noremap = true})
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", { noremap = true})
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", { noremap = true})
