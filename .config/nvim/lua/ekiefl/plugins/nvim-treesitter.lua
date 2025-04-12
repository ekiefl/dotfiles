local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		require("nvim-treesitter.install").compilers = { "gcc", "clang" }
		
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			indent = {
				enable = true,
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			ensure_installed = {
				"lua",
				"vim",
				"python",
				"markdown",
				"markdown_inline",
			},
			sync_install = false,
		})
	end,
}

return { M }
