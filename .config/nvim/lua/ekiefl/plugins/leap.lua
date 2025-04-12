return {
	"ggandor/leap.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local leap = require("leap")
		leap.set_default_mappings()
	end,
}
