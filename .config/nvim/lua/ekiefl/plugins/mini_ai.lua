return {
    'echasnovski/mini.ai',
    version = false,
    config = function ()
        require("mini.ai").setup({
            -- Module mappings. Use `''` (empty string) to disable one.
            mappings = {
                -- Next/last variants
                around_next = '',
                inside_next = '',
                around_last = '',
                inside_last = '',
            },

            -- How to search for object (first inside current line, then inside
            -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
            -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
            search_method = 'cover',
        })

        local opts = { noremap = true, silent = true }
        local tor = require("ekiefl.text_object_repeat")

        local movements = { "in", "an", "il", "al" }
        local characters = { "(", "[", "{", "<", ")", "]", "}", ">", "b", "\"", "'", "q", "?", "t", "f", "a" }

        for _, movement in ipairs(movements) do
            for _, char in ipairs(characters) do
                local keymap = movement .. char
                vim.keymap.set('v', keymap, function() tor.execute_and_remember(keymap) end, opts)
            end
        end

        vim.keymap.set('v', ';', tor.repeat_last_text_object, opts)
        vim.keymap.set('v', '<C-;>', tor.inverse_repeat_last_text_object, opts)

    end
}

