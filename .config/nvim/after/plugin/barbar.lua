local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader>1', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<leader>2', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<leader>3', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<leader>4', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<leader>5', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<leader>6', '<Cmd>BufferGoto 1<CR>', opts)

-- Pin/unpin buffer
map('n', '<leader>bb', '<Cmd>BufferPin<CR>', opts)
-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Move buffers around
map("n", "<c-s-h>", ":BufferMovePrevious<CR>", opts)
map("n", "<c-s-l>", ":BufferMoveNext<CR>", opts)
-- Close all but pinned
map("n", "<leader>bca", ":BufferCloseAllButCurrentOrPinned<CR>", opts)

---------------------------------------------------------------------------------------

-- https://github.com/romgrk/barbar.nvim
vim.g.barbar_auto_setup = false -- disable auto-setup

require'barbar'.setup {
    -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
    preset = 'default',
    icons = {
      -- Configure the base icons on the bufferline.
      -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
      button = '✖',
      -- Enables / disables diagnostic symbols
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = {enabled = false, icon = 'ﬀ'},
        [vim.diagnostic.severity.WARN] = {enabled = false},
        [vim.diagnostic.severity.INFO] = {enabled = false},
        [vim.diagnostic.severity.HINT] = {enabled = false},
      },
      gitsigns = {
        added = {enabled = true, icon = '+'},
        changed = {enabled = true, icon = '~'},
        deleted = {enabled = true, icon = '-'},
      },
      separator = {left = '▋', right = ''},
      -- If true, add an additional separator at the end of the buffer list
      separator_at_end = false,
      -- Configure the icons on the bufferline when modified or pinned.
      pinned = {button = '📍', filename = true},
      -- Configure the icons on the bufferline based on the visibility of a buffer.
      -- inactive = {button = '×'},
    },

    -- If set, the letters for each buffer in buffer-pick mode will be
    -- assigned based on their name. Otherwise or in case all letters are
    -- already assigned, the behavior is to assign letters in order of
    -- usability (see order below)
    semantic_letters = true,

    -- Set the filetypes which barbar will offset itself for
    sidebar_filetypes = {
      NvimTree = true,
      aerial = true,
    },
}
