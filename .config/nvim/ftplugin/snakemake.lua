-- This should be an exact copy of python.lua {{{

-- Wrap lines
vim.opt.wrap = false
vim.opt.linebreak = false

-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Line break
vim.opt.smartindent = true

vim.opt_local.textwidth = 88

-- Don't wrap while in insert mode
vim.opt_local.formatoptions:remove { "t" }

vim.cmd [[
  iabbrev ppp import ipdb; ipdb.set_trace()
  iabbrev ooo import pdb; pdb.set_trace()
  iabbrev iii import pytest; pytest.set_trace()
]]

-- }}}

-- Extra stuff goes here
