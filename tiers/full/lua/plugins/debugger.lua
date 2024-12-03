return {
  {
    'mfussenegger/nvim-dap',
    event = "VeryLazy",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function ()
      local dap = require("dap")
      local dapui = require("dapui")

      require("dapui").setup()
      require("nvim-dap-virtual-text").setup {
        display_callback = function (variable, _, _, _, options)
          -- Hide sensitive information
          local name = string.lower(variable)
          local patterns = {
            "secret",
            "key",
          }

          for _, pattern in ipairs(patterns) do
            if name:match(pattern) then
              return "******"
            end
          end

          -- strip out new line characters
          if options.virt_text_pos == 'inline' then
            return ' = ' .. variable.value:gsub("%s+", " ")
          else
            return variable.name .. ' = ' .. variable.value:gsub("%s+", " ")
          end
        end,
      }

      -- dapui attachment
      dap.listeners.before.attach.dapui_config = dapui.open
      dap.listeners.before.launch.dapui_config = dapui.open
      dap.listeners.before.event_terminated.dapui_config = dapui.close
      dap.listeners.before.event_exited.dapui_config = dapui.close

      -- Keymaps
      vim.keymap.set("n", "<leader>dd", dap.toggle_breakpoint, { desc = "[D]ebugger: toggle breakpoint" })
      vim.keymap.set("n", "<leader>db", dap.set_breakpoint, { desc = "[D]ebugger: set [b]reakpoint" })

      vim.keymap.set("n", "<leader>dlp", function ()
        require("dap").set_breakpoint(nil, nil, vim.fn.input("Enter logpoint message: "))
      end, { desc = "[D]ebugger: set [l]og[p]oint" })

      vim.keymap.set("n", "<leader>d<leader>", dap.repl.open, { desc = "[D]ebugger: open REPL (read-eval-print loop) console" })
      vim.keymap.set("n", "<leader>dll", dap.run_last, { desc = "[D]ebugger: rerun the [l]ast debug adapter" })

      vim.keymap.set({ "n", "v" }, "<leader>dh", function () require("dap.ui.widgets").hover() end, { desc = "[D]ebugger: display evaluation in floating window" })
      vim.keymap.set({ "n", "v" }, "<leader>dp", function () require("dap.ui.widgets").preview() end, { desc = "[D]ebugger: display evaluation in [p]review window" })

      vim.keymap.set('n', '<leader>df', function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.frames)
      end, { desc = "[D]ebugger: display [f]rames" })

      vim.keymap.set('n', '<leader>ds', function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.scopes)
      end, { desc = "[D]ebugger: display [s]copes" })

      -- Movement keymaps
      vim.keymap.set("n", "<leader>d<Enter>", dap.continue, { desc = "Debugger: continue until next breakpoint" })

      vim.keymap.set("n", "<leader>d<A-j>", dap.step_over, { desc = "Debugger: step over | [J] -> down/over" })
      vim.keymap.set("n", "<leader>d<A-l>", dap.step_into, { desc = "Debugger: step into | [L] -> right/into" })
      vim.keymap.set("n", "<leader>d<A-h>", dap.step_out, { desc = "Debugger: step out | [H] -> left/out" })
      vim.keymap.set("n", "<leader>d<A-k>", dap.step_back, { desc = "Debugger: step back | [K] -> up/back" })

      vim.keymap.set("n", "<leader>dc", dap.run_to_cursor, { desc = "[D]ebugger: run to the [c]ursor position" })
      vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "[D]ebugger: [r]estart" })
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
