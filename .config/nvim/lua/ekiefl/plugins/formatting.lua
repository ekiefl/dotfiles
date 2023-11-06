-- If formatting is timing out, try increasing
local TIMEOUT = 3000

-- Don't autoformat when saving for these filetypes
-- (call <leader>af if you want to format)
local NO_FORMAT_ON_SAVE = {
  "python",
}

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      -- :ConformInfo to see log file
      log_level = vim.log.levels.ERROR,
      formatters_by_ft = {
        python = { "isort", "black" },
        lua = { "my_stylua" },
      },
      format_on_save = function(bufnr)
        -- Disable autoformat on certain filetypes
        if vim.tbl_contains(NO_FORMAT_ON_SAVE, vim.bo[bufnr].filetype) then
          return
        end
        -- ...additional logic...
        return { timeout_ms = TIMEOUT, lsp_fallback = true, async = false }
      end,
      formatters = {
        nick_nack = {
          command = "patty_wack",
        },
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>af", function()
      conform.format({
        lsp_fallback = false,
        async = false,
        timeout_ms = TIMEOUT,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
