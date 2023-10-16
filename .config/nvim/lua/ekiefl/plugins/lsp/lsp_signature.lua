return {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  opts = {
      floating_window = true,
      hint_enable = false,
      select_signature_key = nil,
      move_cursor_key = nil,
  },
  config = function(_, opts) require'lsp_signature'.setup(opts) end
}
