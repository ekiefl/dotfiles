return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",     -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false

    local function ensureSessionDir()
      local session_dir = vim.fn.stdpath('config') .. '/sessions'
      if vim.fn.isdirectory(session_dir) == 0 then
        vim.fn.mkdir(session_dir, 'p')
      end
      return session_dir
    end

    local function saveSession(session_name)
      local session_dir = ensureSessionDir()
      local session_file = session_name ~= "" and session_name or 'default.vim'
      local full_path = session_dir .. '/' .. session_file

      local state = require('barbar.state')
      local barbar_buffer_list = state.get_buffer_list()

      -- Close all unpinned buffers as seen by barbar
      for _, bufnr in ipairs(barbar_buffer_list) do
        print(state.is_pinned(bufnr))
        if not state.is_pinned(bufnr) then
          print("removing!")
          state.close_buffer(bufnr, true) -- Assuming true is for do_name_update
        end
      end

      -- Close all unpinned buffers as seen by neovim
      local buffers = vim.api.nvim_list_bufs()
      for _, buf in ipairs(buffers) do
        if not require('barbar.state').is_pinned(buf) then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end

      -- Remove all filenames from arglist
      vim.cmd('argdelete *')

      -- Save the session
      vim.opt.sessionoptions:append('globals')
      vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })
      vim.cmd('mksession! ' .. vim.fn.fnameescape(full_path))
      print('Session saved to: ' .. full_path)
    end

    local function loadSession(session_name)
      local session_dir = ensureSessionDir()
      local session_file = session_name ~= "" and session_name or 'default.vim'
      local full_path = session_dir .. '/' .. session_file
      if vim.fn.filereadable(full_path) == 1 then
        vim.cmd('source ' .. vim.fn.fnameescape(full_path))
        print('Session loaded from: ' .. full_path)
      else
        print('Session file does not exist: ' .. full_path)
      end
    end

    -- Save the session with a command, default to 'Session.vim' if no name is provided
    vim.api.nvim_create_user_command(
      'SaveSession',
      function(opts)
        saveSession(opts.args)
      end,
      { nargs = '?', complete = 'file' }
    )

    -- Load the session with a command, default to 'Session.vim' if no name is provided
    vim.api.nvim_create_user_command(
      'LoadSession',
      function(opts)
        loadSession(opts.args)
      end,
      { nargs = '?', complete = 'file' }
    )

    -- Autocmd to save session on VimLeave
    vim.api.nvim_create_autocmd("VimLeavePre", {
      pattern = '*',
      callback = function()
        saveSession() -- Call saveSession with no arguments to use 'default.vim'
      end,
    })
  end,
  config = function()
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    -- Load session
    map("n", "<leader><leader>l", "<Cmd>silent LoadSession<CR>", opts)

    map("n", "<leader>1", "<Cmd>BufferGoto 1<CR>", opts)
    map("n", "<leader>2", "<Cmd>BufferGoto 2<CR>", opts)
    map("n", "<leader>3", "<Cmd>BufferGoto 3<CR>", opts)
    map("n", "<leader>4", "<Cmd>BufferGoto 4<CR>", opts)
    map("n", "<leader>5", "<Cmd>BufferGoto 5<CR>", opts)
    map("n", "<leader>6", "<Cmd>BufferGoto 6<CR>", opts)

    -- Pin/unpin buffer
    map("n", "<leader>bb", "<Cmd>BufferPin<CR>", opts)
    -- Move buffers around
    map("n", "<c-s-h>", ":BufferMovePrevious<CR>", opts)
    map("n", "<c-s-l>", ":BufferMoveNext<CR>", opts)
    -- Close all but pinned
    map("n", "<leader>bc", ":BufferCloseAllButPinned<CR>", opts)
    -- Close buffer (without ruining window layout)
    map("n", "<leader>c", "<Cmd>BufferClose!<CR>", opts)

    require("barbar").setup({
      -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
      preset = "default",
      icons = {
        -- Configure the base icons on the bufferline.
        -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
        button = "✖",
        -- Enables / disables diagnostic symbols
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = false, icon = "ﬀ" },
          [vim.diagnostic.severity.WARN] = { enabled = false },
          [vim.diagnostic.severity.INFO] = { enabled = false },
          [vim.diagnostic.severity.HINT] = { enabled = false },
        },
        gitsigns = {
          added = { enabled = true, icon = "+" },
          changed = { enabled = true, icon = "~" },
          deleted = { enabled = true, icon = "-" },
        },
        separator = { left = "▌", right = "" },
        -- If true, add an additional separator at the end of the buffer list
        separator_at_end = false,
        -- Configure the icons on the bufferline when modified or pinned.
        pinned = { button = "📍", filename = true },
        -- Configure the icons on the bufferline based on the visibility of a buffer.
        -- inactive = {button = '×'},
        filetype = {
          -- Sets the icon's highlight group.
          -- If false, will use nvim-web-devicons colors
          custom_colors = false,

          -- Requires `nvim-web-devicons` if `true`
          enabled = true,
        },
      },

      -- If set, the letters for each buffer in buffer-pick mode will be
      -- assigned based on their name. Otherwise or in case all letters are
      -- already assigned, the behavior is to assign letters in order of
      -- usability (see order below)
      semantic_letters = true,

      -- Exclude quickfix menu
      exclude_ft = { "qf" },

      highlight_visible = true,
      modified = { button = "●" },

      -- Set the filetypes which barbar will offset itself for, doesn't work
      sidebar_filetypes = {
        -- NvimTree = true,
        -- aerial = true,
      },
    })
  end,
  version = "^1.0.0", -- optional: only update when a new 1.x version is released
}
