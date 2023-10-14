local DEFAULT = 'gruvbox';

local _set_default = function()
    vim.cmd(string.format('colorscheme %s', DEFAULT))
end

local MATERIAL = {
    'marko-cerovac/material.nvim',
    name = 'material',
    config = function()
        -- darker
        -- lighter
        -- oceanic
        -- palenight
        -- deep ocean
        vim.g.material_style = "darker"
        _set_default()
    end
}

local GRUVBOX = {
    'ellisonleao/gruvbox.nvim',
    name = 'gruvbox',
    config = function()
        require("gruvbox").setup({
            contrast = "",
            palette_overrides = {
                dark0 = "#1d2021",
            },
        })
        vim.o.background = "dark" -- or "light" for light mode
        _set_default()
    end
}

return { MATERIAL, GRUVBOX }
