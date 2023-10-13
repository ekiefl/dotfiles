-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.3',
      requires = {{'nvim-lua/plenary.nvim'}},
  }

  use({
	  'rose-pine/neovim',
	  as = 'rose-pine',
	  config = function()
		  vim.cmd('colorscheme rose-pine')
	  end
  })

  use {
	  'nvim-treesitter/nvim-treesitter',
	  run = function()
		  local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
		  ts_update()
	  end,}

  use("tpope/vim-fugitive")
  use("neanias/everforest-nvim")

  -- Requires a nerdfont. Check
  -- https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts
  use('nvim-tree/nvim-web-devicons')

  use("nvim-tree/nvim-tree.lua")

  use {
      "nvim-telescope/telescope-file-browser.nvim",
      requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }

  use('feline-nvim/feline.nvim')
  use("romgrk/barbar.nvim")
  use("stevearc/aerial.nvim")

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v3.x',
	  requires = {
		  --- Uncomment these if you want to manage LSP servers from neovim
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'L3MON4D3/LuaSnip'},
	  }
  }

end)
