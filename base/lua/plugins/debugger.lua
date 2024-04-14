return {
  {
    'mfussenegger/nvim-dap',
    event = "VeryLazy",
    config = function ()
      local dap = require("dap")

      vim.keymap.set("n", "<leader>dd", dap.toggle_breakpoint, { desc = "[D]ebugger: toggle breakpoint" })
      vim.keymap.set("n", "<leader>db", dap.set_breakpoint, { desc = "[D]ebugger: set [b]reakpoint" })

      vim.keymap.set("n", "<leader>dlp", function ()
        require("dap").set_breakpoint(nil, nil, vim.fn.input("Enter logpoint message: "))
      end, { desc = "[D]ebugger: set [l]og[p]oint" })

      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "[D]ebugger: open [R]EPL (read-eval-print loop) console" })
      vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "[D]ebugger: rerun the [l]ast debug adapter" })

      vim.keymap.set({ "n", "v" }, "<leader>dh", function () require("dap.ui.widgets").hover() end, { desc = "[D]ebugger: display evaluation in floating window" })
      vim.keymap.set({ "n", "v" }, "<leader>dp", function () require("dap.ui.widgets").preview() end, { desc = "[D]ebugger: display evaluation in [p]review window" })

      vim.keymap.set('n', '<Leader>df', function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.frames)
      end, { desc = "[D]ebugger: display [f]rames" })
      vim.keymap.set('n', '<Leader>ds', function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.scopes)
      end, { desc = "[D]ebugger: display [s]copes" })

      -- Movement keymaps

      vim.keymap.set("n", "<A-Shift-Enter>", dap.continue, { desc = "Debugger: continue until next breakpoint" })

      vim.keymap.set("n", "<A-J>", dap.step_over, { desc = "Debugger: step over" })
      vim.keymap.set("n", "<A-L>", dap.step_into, { desc = "Debugger: step into" })
      vim.keymap.set("n", "<A-H>", dap.step_out, { desc = "Debugger: step out" })
    end,
  },
  -- Telescope integration
  {
    'nvim-telescope/telescope-dap.nvim',
    event = "VeryLazy",
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-telescope/telescope.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function ()
      require("telescope").load_extension("dap")

      local ext = require('telescope').extensions.dap

      vim.keymap.set("n", "<leader>fdb", ext.list_breakpoints, { desc = "Telescope: [f]ind [d]ebug [b]reakpoints" })
      vim.keymap.set("n", "<leader>fdv", ext.variables, { desc = "Telescope: [f]ind [d]ebug [v]ariables" })
      vim.keymap.set("n", "<leader>fdf", ext.frames, { desc = "Telescope: [f]ind [d]ebug [f]rames" })
    end,
  },
}
