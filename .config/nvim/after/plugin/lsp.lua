-------------------------------------------------------------------------------
-- Initialize LSP zero
-------------------------------------------------------------------------------

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "<leader>d", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.lsp.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)

  -- Currently (un/under)utilized
  -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  -- vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  -- vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
end)

-------------------------------------------------------------------------------
-- Define all LSPs and their options
-------------------------------------------------------------------------------

-- Setting up Lua LSP
local lua_ls_setup = function ()
  require'lspconfig'.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            version = 'LuaJIT'
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
            }
          }
        }
      })
      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}
end

-- Setting up python LSP
local pyright_setup = function ()
  require'lspconfig'.pyright.setup({})
end

-------------------------------------------------------------------------------
-- Now install all the defined LSPs
-------------------------------------------------------------------------------

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'pyright', 'lua_ls'},
  handlers = {
    lsp_zero.default_setup,
    lua_ls = lua_ls_setup,
    pyright = pyright_setup,
  },
})

-------------------------------------------------------------------------------
-- Also take the opportunity to install any tools/linters/formatters
-------------------------------------------------------------------------------

-- Browse available tools with :Mason
local tool_names = {
    black = {},
    isort = {},
}

for name, opts in pairs(tool_names) do
    local tool = require('mason-registry').get_package(name)
    if not tool:is_installed() then
        tool:install(opts)
    end
end


-------------------------------------------------------------------------------
-- Define the autocompletion controls
-------------------------------------------------------------------------------

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<Up>'] = cmp.mapping.scroll_docs(-3),
    ['<Down>'] = cmp.mapping.scroll_docs(3),
  })
})
