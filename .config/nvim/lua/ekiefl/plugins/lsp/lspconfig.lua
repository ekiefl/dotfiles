return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"ray-x/lsp_signature.nvim",
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")
		local lsp_signature = require("lsp_signature")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			lsp_signature.on_attach(client, bufnr)

			vim.diagnostic.config({
				virtual_text = false,
			})

			opts.buffer = bufnr

			opts.desc = "Toggle signature help"
			vim.keymap.set("i", "<C-k>", lsp_signature.toggle_float_win, opts)

			opts.desc = "Show LSP references"
			keymap.set("n", "<leader>rr", "<cmd>Telescope lsp_references<CR>", opts)

			opts.desc = "Go to definition"
			keymap.set("n", "<leader>d", "<cmd>Telescope lsp_definitions<CR>", opts)

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "<leader>s", vim.lsp.buf.hover, opts)

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>vca", vim.lsp.buf.code_action, opts)

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

			opts.desc = "Autoformat"
			keymap.set("n", "<leader>a", vim.lsp.buf.format, opts)
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- https://www.reddit.com/r/neovim/comments/161tv8l/comment/jzfen6b/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
		capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		)
		capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

		-- configure html server
		lspconfig["html"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure python server
		lspconfig["pyright"].setup({
			capabilities = capabilities,
			filetypes = { "python", "snakemake" },
			on_attach = on_attach,
		})
		lspconfig["ruff"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			-- Force UTF-16 encoding for ruff (required for Neovim 0.11+)
			--
			-- Ruff defaults to UTF-8 in Neovim 0.11+ when the client advertises support for it,
			-- which causes "multiple different client offset_encodings detected" warnings when
			-- other LSP servers in the same buffer use UTF-16.
			--
			-- This before_init hook forces ruff to use UTF-16 like other servers.
			-- In a future where Neovim better supports mixed encodings, this override
			-- might be removed to let ruff use its preferred UTF-8 encoding.
			before_init = function(_, config)
				config.capabilities = config.capabilities or {}
				config.capabilities.general = config.capabilities.general or {}
				config.capabilities.general.positionEncodings = { "utf-16" }
			end,
		})

		-- yaml
		lspconfig["yamlls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
	end,
}
