local status = function() vim.cmd.Git() end
local blame = function() vim.cmd.Git("blame") end
local diff = function() vim.cmd.Gvdiffsplit() end
local push = function() vim.cmd.Git("push") end

vim.keymap.set("n", "<leader>gs", status);
vim.keymap.set("n", "<leader>gb", blame);
vim.keymap.set("n", "<leader>gd", diff);
vim.keymap.set("n", "<leader>gp", push);
