local PREVIEW = "vertical" -- horizontal, vertical, flex

return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")
		local utils = require("telescope.utils")

		require("telescope").setup({
			defaults = {
				layout_strategy = PREVIEW,
				layout_config = { height = 0.93, width = 0.85, scroll_speed = 1 },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<Up>"] = actions.preview_scrolling_up,
						["<Down>"] = actions.preview_scrolling_down,
						["<C-l>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
					n = {
						["<Up>"] = actions.preview_scrolling_up,
						["<Down>"] = actions.preview_scrolling_down,
					},
				},
			},
		})

		require("telescope").load_extension("fzf")

		----------------------------------------------------------------------------------------
		-- Custom search functions
		----------------------------------------------------------------------------------------

		-- Search files, asking which directory to search within
		local function find_files_prompt()
			local def_search_dir = vim.fn.expand("%:p:h")

			vim.ui.input({
				prompt = string.format("Enter search directory:", def_search_dir),
				completion = "dir", -- optional directory completion
				default = def_search_dir,
			}, function(search_dir)
				if search_dir == "" then
					search_dir = def_search_dir
				end

				builtin.find_files({ search_dirs = { search_dir } })
			end)
		end

		local function find_nvim_config_files()
			builtin.find_files({
				search_dirs = { vim.fn.stdpath("config") },
				cwd = vim.fn.stdpath("config"),
				hidden = true,
			})
		end

		-- Helper function to get git root based on current buffer
		local function get_git_root()
			local buffer_dir = utils.buffer_dir()
			local cmd = string.format(
				"cd %s && git rev-parse --show-toplevel 2>/dev/null || echo ''",
				vim.fn.shellescape(buffer_dir)
			)
			local git_root = vim.fn.trim(vim.fn.system(cmd))

			if git_root ~= "" then
				return git_root
			end

			-- Fallback to nvim's startup directory if no git repo found for current buffer
			cmd = "git rev-parse --show-toplevel 2>/dev/null || echo ''"
			git_root = vim.fn.trim(vim.fn.system(cmd))

			return git_root ~= "" and git_root or vim.fn.getcwd()
		end

		-- Search files within the git project
		local function find_files_git()
			local git_root = get_git_root()

			if git_root ~= "" then
				builtin.git_files({
					cwd = git_root,
					recurse_submodules = true,
				})
			else
				-- Fallback to normal find_files if not in a git repo
				builtin.find_files()
			end
		end

		-- Git grep within git project
		local function live_grep_git_files()
			local rg_args = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--follow",
			}

			local git_root = get_git_root()

			builtin.live_grep({
				cwd = utils.buffer_dir(),
				search_dirs = { git_root },
				vimgrep_arguments = rg_args,
			})
		end

		-- Grep in files with directory prompt
		local function live_grep_prompt()
			local def_search_dir = vim.fn.expand("%:p:h")

			vim.ui.input({
				prompt = string.format("Enter search directory:", def_search_dir),
				completion = "dir", -- optional directory completion
				default = def_search_dir,
			}, function(search_dir)
				if search_dir == "" then
					search_dir = def_search_dir
				end

				local rg_args = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--follow",
				}

				builtin.live_grep({
					cwd = search_dir,
					search_dirs = { search_dir },
					vimgrep_arguments = rg_args,
				})
			end)
		end

		vim.keymap.set("n", "<leader>gc", find_nvim_config_files, {})
		vim.keymap.set("n", "<leader>gf", find_files_prompt, {})
		vim.keymap.set("n", "<leader>lf", live_grep_prompt, {})
		vim.keymap.set("n", "<leader>f", find_files_git, {})
		vim.keymap.set("n", "<leader>lg", live_grep_git_files, {})
	end,
}
