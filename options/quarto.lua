return {
  -- Quarto publishing tool helper
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto" },
    dependencies = {
      "jmbuhr/otter.nvim",
      "benlubas/molten-nvim",
    },
    config = function ()
      local quarto = require("quarto")

      quarto.setup {
        lspFeatures = {
          languages = { 'r', 'python', 'julia', 'bash', 'lua', 'html', 'dot', 'javascript', 'typescript', 'ojs' },
        },
        codeRunner = {
          enabled = true,
          default_method = 'molten',
        },
      }

      local runner = require("quarto.runner")

      vim.keymap.set("n", "<localleader>qq", quarto.quartoPreview, { noremap = true, desc = "[Q]uarto [P]review" })
      vim.keymap.set("n", "<localleader>rr", runner.run_cell, { desc = "[R]un current cell" })
      vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "[R]un [a]bove cells" })
      vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "[R]un [A]ll cells" })
      vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "[R]un [L]ine" })
      vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "[R]un range" })
      vim.keymap.set("n", "<localleader>r<tab>", function () runner.run_all(true) end, { desc = "[R]un all cells regardless of langauges" })
    end,
  },
  -- LSP support for cells
  {
    "jmbuhr/otter.nvim",
    lazy = true,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'neovim/nvim-lspconfig',
      'hrsh7th/nvim-cmp',
    },
    opts = {
      buffers = {
        set_filetype = true,
      },
      handle_leading_whitespace = true,
    },
  },
  -- Jupyter running helper
  {
    'benlubas/molten-nvim',
    lazy = true,
    build = function () vim.cmd.UpdateRemotePlugins() end,
    init = function()
      -- Image display engine
      --
      -- `image.nvim` or `wezterm`, but needs extra installation and configuration
      vim.g.molten_image_provider = nil
      -- Max height of output window
      vim.g.molten_output_win_max_height = 20
      -- Output window auto open
      vim.g.molten_auto_open_output = false
    end,
  },
}
