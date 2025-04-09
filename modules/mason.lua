return {
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
    },
    opts = {
      ensure_installed = {
        -- LSPs kept installed without extra operations
      },
      -- Auto install LSPs
      automatic_installation = false,
      -- Handlers
      handlers = {
        function (lsp_id)
          require("lspconfig")[lsp_id].setup {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
          }
        end,
      },
    },
  },
}
