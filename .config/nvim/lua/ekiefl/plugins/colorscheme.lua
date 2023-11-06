local DEFAULT = "gruvbox"
local LIGHT_OR_DARK = "dark"

----------------------------------------------------------------------------------------
-- Utilities
----------------------------------------------------------------------------------------

vim.keymap.set("n", "<C-p>", function()
    require("telescope.builtin").colorscheme({ enable_preview = true })
end, {})

local _set_default = function()
    vim.cmd(string.format("colorscheme %s", DEFAULT))
    vim.o.background = LIGHT_OR_DARK
end

----------------------------------------------------------------------------------------
-- Colorscheme plugins
----------------------------------------------------------------------------------------

local MATERIAL = {
    "marko-cerovac/material.nvim",
    config = function()
        _set_default()
    end,
}

local GRUVBOX = {
    "ellisonleao/gruvbox.nvim",
    config = function()
        require("gruvbox").setup({
            -- 'hard', 'soft', or ''
            contrast = "",
            transparent_mode = false,
            palette_overrides = {
                dark0 = "#1d2021",
                dark0_hard = "#111111",
            },
            overrides = {
                CursorLine = { bg = "#2E3032" },
                CursorLineNr = { bg = "#2E3032" },
                CursorLineSign = { bg = "#2E3032" },
                SignColumn = { bg = "#1d2021" },
                GruvboxRedSign = { fg = "#fb4934", bg = "#1d2021" },
                GruvboxGreenSign = { fg = "#b8bb26", bg = "#1d2021" },
                GruvboxYellowSign = { fg = "#fabd2f", bg = "#1d2021" },
                GruvboxBlueSign = { fg = "#83a598", bg = "#1d2021" },
                GruvboxPurpleSign = { fg = "#d3869b", bg = "#1d2021" },
                GruvboxAquaSign = { fg = "#8ec07c", bg = "#1d2021" },
                GruvboxOrangeSign = { fg = "#fe8019", bg = "#1d2021" },
                TabLineSel = { bg = "#1d2021", fg = "#FE7417", bold = 1 },
            },
        })
        _set_default()
    end,
}

return {
    MATERIAL,
    GRUVBOX,
}
