return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofmt" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        javascript = { "prettierd", "prettier", stop_after_first = true },
      },
      --format_on_save = {
      --  -- These options will be passed to conform.format()
      --  timeout_ms = 500,
      --  lsp_format = "fallback",
      --},
    },
    init = function()
      vim.keymap.set(
        "n",
        "<leader>w",
        function() require("conform").format() end,
        { desc = "Conform: Format this buffer and [w]rite into it" }
      )
    end,
  },
}
