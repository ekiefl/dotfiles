-- Wrap lines
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.textwidth = 0

-- Move by visual line instead of actual line (helpful for wrapped lines)
-- Note this is not a global remap (nvim_buf_set_keymap)
vim.api.nvim_buf_set_keymap(0, "n", "j", "gj", { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, "n", "k", "gk", { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, "v", "j", "gj", { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, "v", "k", "gk", { noremap = true, silent = true })

vim.keymap.set("n", "0", "g0")
vim.keymap.set("n", "^", "g^")
vim.keymap.set("n", "$", "g$")
