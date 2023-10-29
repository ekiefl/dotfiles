-- If formatting is timing out, try increasing
local TIMEOUT = 3000

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
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = TIMEOUT,
      },
      -- This is where non-default format configs can be defined
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
