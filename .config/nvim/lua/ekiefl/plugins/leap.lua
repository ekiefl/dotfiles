return {
	"ggandor/leap.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local leap = require("leap")
		leap.set_default_mappings()

		leap.opts.case_sensitive = true

		-- Define equivalence classes for brackets and quotes, in addition to
		-- the default whitespace group:
		require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }

		-- Use the traversal keys to repeat the previous motion without
		-- explicitly invoking Leap:
		require("leap.user").set_repeat_keys("<enter>", "<backspace>")

		-- Define a preview filter (skip the middle of alphanumeric words):
		require("leap").opts.preview_filter = function(ch0, ch1, ch2)
			return not (ch1:match("%s") or ch0:match("%w") and ch1:match("%w") and ch2:match("%w"))
		end
	end,
}
