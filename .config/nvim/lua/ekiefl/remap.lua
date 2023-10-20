-- Convenience remap
local noremap = function(lhs, rhs, opts)
    opts = opts or {}
    local mode = opts.mode or "n"
    local noremap = opts.noremap
    local silent = opts.silent

    if noremap == nil then
        noremap = true
    end

    if noremap == nil then
        silent = false
    end

    vim.keymap.set(mode, lhs, rhs, { noremap = noremap, silent = silent })
end

----------------------------------------------------------------------------------------

-- Fast save, write, close
noremap("<leader>w", ":w<CR>")
noremap("<leader>q", ":q<CR>")
noremap("<leader>fq", ":qa!<CR>")
noremap("<leader>e", ":e")

-- Split navigation with Ctrl + hjkl
noremap("<C-J>", "<C-W><C-J>")
noremap("<C-K>", "<C-W><C-K>")
noremap("<C-L>", "<C-W><C-L>")
noremap("<C-H>", "<C-W><C-H>")

-- Move by visual line instead of actual line (helpful for wrapped lines)
noremap("j", "gj")
noremap("k", "gk")
noremap("j", "gj", { mode = "v" })
noremap("k", "gk", { mode = "v" })
noremap("0", "g0")
noremap("^", "g^")
noremap("$", "g$")

-- Quickly open/edit config and shell-related files
noremap("<leader>eb", ":split ~/.bashrc<cr>")
noremap("<leader>ea", ":split ~/.bash_aliases<cr>")
noremap("<leader>ep", ":split ~/.bash_prompt<cr>")

-- Copy full path of the current file to clipboard
noremap("<c-y>", ":let @+ = expand('%:p')<cr>")

-- Easier on the fingies
noremap(",", "`")
noremap("`", "'")
noremap(",", "`", { mode = "v" })
noremap("`", "'", { mode = "v" })

-- Backwards search repeat is normally ","
noremap("<C-;>", ",")
noremap("<C-;>", ",", { mode = "v" })

-- Visual select what was just pasted
noremap("gp", "`[v`]")

-- Visual select block
noremap(",,", "vip")

-- In visual mode, move the selected lines downwards/upwards
noremap("J", ":m '>+1<CR>gv=gv", { mode = "v" })
noremap("K", ":m '<-2<CR>gv=gv", { mode = "v" })

-- Append current line to line above (with or without space)
noremap("MU", "mzJ`z")
noremap("Mu", "mzJx`z")

-- Make a marker every time you exit insert mode (return to it with ,f)
noremap("<esc>", "<esc>mf", { mode = "i" })

-- In insert mode, bash-style navigation to start/end of line
noremap("<C-e>", "<C-o>$", { mode = "i" })
noremap("<C-a>", "<C-o><S-i>", { mode = "i" })

-- Quickly navigate between and move around buffers
noremap("<s-h>", ":BufferPrevious<CR>")
noremap("<s-l>", ":BufferNext<CR>")
noremap("<leader>c", ":bw!<CR>")

-- In operator pending mode, change 'u' to target till underscore
noremap("u", "t_", { mode = "o" })

-- Retain clipboard state while pasting over something
noremap("<leader>p", "\"_dP", { mode = "x" })

-- Fly through quickfix lists
noremap("J", ":cnext<CR>zz")
noremap("K", ":cprev<CR>zz")
