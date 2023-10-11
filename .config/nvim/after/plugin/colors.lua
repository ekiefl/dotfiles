require('rose-pine').setup({
	disable_italics = true,
	groups = {
		background = '#111111',
	},

})

function ColorMyPencils(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)
end

ColorMyPencils()
