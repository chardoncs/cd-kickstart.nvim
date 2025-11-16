return {
  "nvim-neotest/neotest",
  event = "VeryLazy",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("neotest").setup({
      adapters = {
      },
    })

    vim.keymap.set("n", "<leader>tc", function ()
      require("neotest").run.run(vim.fn.expand("%"))
    end, { desc = "Neotest: [T]est [c]urrent file" })

    vim.keymap.set("n", "<leader>tt", function ()
      require("neotest").run.run_last()
    end, { desc = "Neotest: Run [l]ast test" })

    vim.keymap.set("n", "<leader>tn", function ()
      require("neotest").run.run()
    end, { desc = "Neotest: Run [n]earest test" })

    vim.keymap.set("n", "<leader>ta", function ()
      require("neotest").run.attach()
    end, { desc = "Neotest: [A]ttach nearest test" })

    vim.keymap.set("n", "<leader>ts", function ()
      require("neotest").summary.toggle()
    end, { desc = "Neotest: Toggle test [s]ummary" })

    vim.keymap.set("n", "<leader>to", function ()
      require("neotest").output.open()
    end, { desc = "Neotest: Open [o]utput" })

    vim.keymap.set("n", "<leader>tp", function ()
      require("neotest").output_panel.toggle()
    end, { desc = "Neotest: Toggle output [p]anel" })
  end,
}
