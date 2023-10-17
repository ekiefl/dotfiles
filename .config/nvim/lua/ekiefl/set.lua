vim.g.mapleader = " "

-- Insert mode block cursor
vim.opt.guicursor = ""

vim.o.termguicolors = true

-- Relative numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- Wrap lines
vim.opt.wrap = true

-- Synchronizing Vim and OS clipboards for yank/paste operations.
vim.o.clipboard = "unnamed"

-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8

-- No need to show insert/visual mode with status bar plugin
vim.cmd("set noshowmode")

-- No ~ EOF signifier in line number column
vim.cmd("set fillchars+=eob:\\ ")

-- When editing a file, always jump to the last cursor position
local vimscript_code = [[
autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" |
\ endif |
\ endif
]]
vim.api.nvim_exec(vimscript_code, false)
