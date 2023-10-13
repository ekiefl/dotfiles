local DEFAULT = "rose-pine"

function ColorMyPencils(color)
    color = color or DEFAULT
    vim.cmd.colorscheme(color)
end

require('rose-pine').setup({
	--- @usage 'auto'|'main'|'moon'|'dawn'
	variant = 'auto',
	--- @usage 'main'|'moon'|'dawn'
	dark_variant = 'main',
	bold_vert_split = false,
	dim_nc_background = false,
	disable_background = false,
	disable_float_background = false,
	disable_italics = false,

	--- @usage string hex value or named color from rosepinetheme.com/palette
	groups = {
		background = '#111111',
		background_nc = '_experimental_nc',
		panel = 'surface',
		panel_nc = 'base',
		border = 'highlight_med',
		comment = 'muted',
		link = 'iris',
		punctuation = 'subtle',

		error = 'love',
		hint = 'iris',
		info = 'foam',
		warn = 'gold',

		headings = {
			h1 = 'iris',
			h2 = 'foam',
			h3 = 'rose',
			h4 = 'gold',
			h5 = 'pine',
			h6 = 'foam',
		}
		-- or set all headings at once
		-- headings = 'subtle'
	},

	-- Change specific vim highlight groups
	-- https://github.com/rose-pine/neovim/wiki/Recipes
	highlight_groups = {
		ColorColumn = { bg = 'rose' },

		-- Blend colours against the "base" background
		CursorLine = { bg = 'foam', blend = 10 },
		StatusLine = { fg = 'love', bg = 'love', blend = 10 },

		-- By default each group adds to the existing config.
		-- If you only want to set what is written in this config exactly,
		-- you can set the inherit option:
		Search = { bg = '#333333', inherit = false },
	}
})

require("everforest").setup({
  ---Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
  ---Default is "medium".
  background = "hard",
  ---How much of the background should be transparent. 2 will have more UI
  ---components be transparent (e.g. status line background)
  transparent_background_level = 0,
  ---Whether italics should be used for keywords and more.
  italics = false,
  ---Disable italic fonts for comments. Comments are in italics by default, set
  ---this to `true` to make them _not_ italic!
  disable_italic_comments = true,
  ---By default, the colour of the sign column background is the same as the as normal text
  ---background, but you can use a grey background by setting this to `"grey"`.
  sign_column_background = "none",
  ---The contrast of line numbers, indent lines, etc. Options are `"high"` or
  ---`"low"` (default).
  ui_contrast = "low",
  ---Dim inactive windows. Only works in Neovim. Can look a bit weird with Telescope.
  ---
  ---When this option is used in conjunction with show_eob set to `false`, the
  ---end of the buffer will only be hidden inside the active window. Inside
  ---inactive windows, the end of buffer filler characters will be visible in
  ---dimmed symbols. This is due to the way Vim and Neovim handle `EndOfBuffer`.
  dim_inactive_windows = false,
  ---Some plugins support highlighting error/warning/info/hint texts, by
  ---default these texts are only underlined, but you can use this option to
  ---also highlight the background of them.
  diagnostic_text_highlight = false,
  ---Which colour the diagnostic text should be. Options are `"grey"` or `"coloured"` (default)
  diagnostic_virtual_text = "coloured",
  ---Some plugins support highlighting error/warning/info/hint lines, but this
  ---feature is disabled by default in this colour scheme.
  diagnostic_line_highlight = false,
  ---By default, this color scheme won't colour the foreground of |spell|, instead
  ---colored under curls will be used. If you also want to colour the foreground,
  ---set this option to `true`.
  spell_foreground = false,
  ---Whether to show the EndOfBuffer highlight.
  show_eob = true,
  ---You can override specific highlights to use other groups or a hex colour.
  ---This function will be called with the highlights and colour palette tables.
  ---@param highlight_groups Highlights
  ---@param palette Palette
  on_highlights = function(highlight_groups, palette) end,
  ---You can override colours in the palette to use different hex colours.
  ---This function will be called once the base and background colours have
  ---been mixed on the palette.
  ---@param palette Palette
  colours_override = function (palette)
    palette.bg0 = "#111111"
  end
})


ColorMyPencils()
