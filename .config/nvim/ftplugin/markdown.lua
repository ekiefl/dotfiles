-- Wrap lines
vim.opt.wrap = true
vim.opt.linebreak = true

-- Move by visual line instead of actual line (helpful for wrapped lines)
-- Note this is not a global remap (nvim_buf_set_keymap)
vim.api.nvim_buf_set_keymap("j", "gj")
vim.api.nvim_buf_set_keymap("k", "gk")
vim.api.nvim_buf_set_keymap("j", "gj", { mode = "v" })
vim.api.nvim_buf_set_keymap("k", "gk", { mode = "v" })

vim.keymap.set("n", "0", "g0")
vim.keymap.set("n", "^", "g^")
vim.keymap.set("n", "$", "g$")
