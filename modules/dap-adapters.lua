return {
  -- CodeLLDB
  {
    "julianolf/nvim-dap-lldb",
    event = "VeryLazy",
    dependencies = {
      "https://codeberg.org/mfussenegger/nvim-dap",
    },
    opts = {
      codelldb_path = "/usr/bin/codelldb",
    },
  },
  -- Go
  {
    "leoluz/nvim-dap-go",
    event = "VeryLazy",
    dependencies = {
      "https://codeberg.org/mfussenegger/nvim-dap",
    },
    opts = {},
  },
  -- Python
  {
    "https://codeberg.org/mfussenegger/nvim-dap-python",
    event = "VeryLazy",
    dependencies = {
      "https://codeberg.org/mfussenegger/nvim-dap",
    },
    config = function ()
      require("dap-python").setup("python3")
    end,
  },
}
