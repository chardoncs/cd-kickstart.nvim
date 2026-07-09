return {
  {
    'https://codeberg.org/mfussenegger/nvim-dap',
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
          local name = string.lower(variable.name or "")
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

      -- Open the debug terminal in a bottom split instead of hijacking the current window
      dap.defaults.fallback.terminal_win_cmd = "botright new"

      -- dapui lifecycle: open on attach/launch, close only when no sessions remain
      dap.listeners.before.attach.dapui_config = dapui.open
      dap.listeners.before.launch.dapui_config = dapui.open
      dap.listeners.before.event_terminated.dapui_config = function ()
        if #dap.sessions() == 0 then dapui.close() end
      end
      dap.listeners.before.event_exited.dapui_config = function ()
        if #dap.sessions() == 0 then dapui.close() end
      end

      -- Buffer-local Alt+direction stepping keys, bound only while a session is active
      local step_keymaps = {
        { "<A-j>", dap.step_over,  "step over | [J] -> down/over" },
        { "<A-l>", dap.step_into,  "step into | [L] -> right/into" },
        { "<A-h>", dap.step_out,   "step out  | [H] -> left/out" },
        { "<A-k>", dap.step_back,  "step back | [K] -> up/back" },
        { "<A-c>", dap.continue,   "continue" },
      }
      local bind_step_keys = function ()
        for _, k in ipairs(step_keymaps) do
          vim.keymap.set("n", k[1], k[2], { buffer = 0, desc = "Debugger: " .. k[3] })
        end
      end
      local unbind_step_keys = function ()
        for _, k in ipairs(step_keymaps) do
          pcall(vim.keymap.del, "n", k[1], { buffer = 0 })
        end
      end
      dap.listeners.after.event_initialized["dap_step_keys"] = bind_step_keys
      dap.listeners.before.event_terminated["dap_step_keys"] = unbind_step_keys
      dap.listeners.before.event_exited["dap_step_keys"]    = unbind_step_keys

      -- Breakpoints
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "[D]ebugger: toggle [b]reakpoint" })
      vim.keymap.set("n", "<leader>dB", function ()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "[D]ebugger: set conditional [B]reakpoint" })
      vim.keymap.set("n", "<leader>dl", function ()
        dap.set_breakpoint(nil, nil, vim.fn.input("Logpoint message: "))
      end, { desc = "[D]ebugger: set [l]ogpoint" })
      vim.keymap.set("n", "<leader>dC", dap.clear_breakpoints, { desc = "[D]ebugger: [C]lear all breakpoints" })

      -- Session control
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "[D]ebugger: [c]ontinue / start" })
      vim.keymap.set("n", "<leader>dL", dap.run_last, { desc = "[D]ebugger: run [L]ast config" })
      vim.keymap.set("n", "<leader>dR", dap.repl.open, { desc = "[D]ebugger: open [R]EPL" })
      vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "[D]ebugger: [r]estart" })
      vim.keymap.set("n", "<leader>dT", dap.terminate, { desc = "[D]ebugger: [T]erminate session" })
      vim.keymap.set("n", "<leader>dq", function ()
        dap.terminate()
        if #dap.sessions() == 0 then dapui.close() end
      end, { desc = "[D]ebugger: [q]uit (terminate + close UI)" })
      vim.keymap.set("n", "<leader>dd", dapui.toggle, { desc = "[D]ebugger: toggle [d]ap-ui" })
      vim.keymap.set("n", "<leader>dG", dap.run_to_cursor, { desc = "[D]ebugger: run to cursor ([G]oto)" })

      -- Stepping (leader alternates for terminals where Alt-keys are awkward)
      vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "[D]ebugger: step [o]ver" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "[D]ebugger: step [i]nto" })
      vim.keymap.set("n", "<leader>dO", dap.step_out,  { desc = "[D]ebugger: step [O]ut" })
      vim.keymap.set("n", "<leader>dK", dap.step_back, { desc = "[D]ebugger: step bac[K]" })

      -- Inspection
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
