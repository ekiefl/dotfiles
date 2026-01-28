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

-- Fast save, write, close (for closing buffer while retaining window layout, see remaps in barbar
-- plugin)
noremap("<leader>w", ":w<CR>")
noremap("<leader>q", ":q<CR>")
noremap("<leader>fq", ":qa!<CR>")
noremap("<leader>e", ":e")

-- Split navigation with Ctrl + hjkl
noremap("<C-J>", "<C-W><C-J>")
noremap("<C-K>", "<C-W><C-K>")
noremap("<C-L>", "<C-W><C-L>")
noremap("<C-H>", "<C-W><C-H>")

-- Quickly open/edit config and shell-related files
noremap("<leader>eb", ":split ~/.bashrc<cr>")
noremap("<leader>ea", ":split ~/.bash_aliases<cr>")
noremap("<leader>ep", ":split ~/.bash_prompt<cr>")

-- Copy full path of the current file to clipboard
noremap("<c-y>", ":let @+ = expand('%:p')<cr>")

-- Copy Python module path to clipboard
noremap("<C-S-Y>", function()
	local filepath = vim.fn.expand("%:p")
	if not filepath:match("%.py$") then
		print("Not a Python file")
		return
	end

	-- Find the module path by looking for common patterns
	local parts = {}
	for part in filepath:gmatch("[^/]+") do
		table.insert(parts, part)
	end

	-- Find where the module path starts by searching from left to right
	local start_idx = nil
	
	-- First, look for project root indicators (setup.py, pyproject.toml)
	for i = 1, #parts - 1 do
		local current_path = "/" .. table.concat({ unpack(parts, 1, i) }, "/")
		
		if vim.fn.filereadable(current_path .. "/setup.py") == 1 or
		   vim.fn.filereadable(current_path .. "/pyproject.toml") == 1 then
			-- Check if the next directory has __init__.py (it's a package)
			local next_path = current_path .. "/" .. parts[i + 1]
			if vim.fn.filereadable(next_path .. "/__init__.py") == 1 then
				start_idx = i + 1
				break
			end
		end
	end
	
	-- If not found, look for common structure indicators
	if not start_idx then
		for i = 1, #parts - 1 do
			if parts[i] == "src" or parts[i] == "lib" or parts[i]:match("%-") then
				-- Check if the next directory has __init__.py
				local check_path = "/" .. table.concat({ unpack(parts, 1, i + 1) }, "/")
				if vim.fn.filereadable(check_path .. "/__init__.py") == 1 then
					start_idx = i + 1
					break
				end
			end
		end
	end
	
	-- Last resort: find the topmost directory with __init__.py
	if not start_idx then
		for i = 1, #parts - 1 do
			local check_path = "/" .. table.concat({ unpack(parts, 1, i) }, "/")
			if vim.fn.filereadable(check_path .. "/__init__.py") == 1 then
				start_idx = i
				break
			end
		end
	end

	if not start_idx then
		print("Could not determine module path")
		return
	end

	-- Build the module path
	local module_parts = {}
	for i = start_idx, #parts do
		local part = parts[i]
		if i == #parts then
			-- Remove .py extension from last part
			part = part:gsub("%.py$", "")
		end
		table.insert(module_parts, part)
	end

	local module_path = table.concat(module_parts, ".")
	vim.fn.setreg("+", module_path)
	print("Copied: " .. module_path)
end)

-- Easier on the fingies
noremap(",", "`")
noremap("`", "'")
noremap(",", "`", { mode = "v" })
noremap("`", "'", { mode = "v" })

-- Backwards search repeat is normally ","
-- noremap("<C-;>", ",")
-- noremap("<C-;>", ",", { mode = "v" })

-- Visual select what was just pasted
noremap("gp", "`[v`]")

-- Visual select block
noremap(",,", "vip")

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

-- In operator pending mode, change 'u' to target till underscore
noremap("u", "t_", { mode = "o" })

-- Retain clipboard state while pasting over something
noremap("<leader>p", '"_dP', { mode = "x" })

-- Fly through quickfix lists
noremap("D", ":cnext<CR>zz")
noremap("U", ":cprev<CR>zz")
