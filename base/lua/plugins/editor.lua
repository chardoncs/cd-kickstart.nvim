return {
  -- Dev icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {},
  },
  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
      sections = {
        lualine_a = {
          {
            "mode",
            -- Display Neovim logo
            icon = "",
          },
        },
      },
    },
  },
  -- Tab bar
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function ()
      vim.g.barbar_auto_setup = false
    end,
    opts = {},
  },
  -- Indentation guessing
  {
    "hrsh7th/nvim-dansa",
    event = "VeryLazy",
    config = function ()
      local setup = require("dansa").setup

      -- Default
      setup({
        scan_offset = 100,
        cutoff_count = 5,
        default = {
          expandtab = true,
          space = {
            shiftwidth = 4,
          },
          tab = {
            shiftwidth = 4,
          },
        },
      })

      -- Reserve tabs for Go
      setup.filetype('go', {
        default = {
          expandtab = false,
          tab = {
            shiftwidth = 4,
          },
        },
      })

      local function set_2_spaces(fts)
        for _, ft in pairs(fts) do
          setup.filetype(ft, {
            default = {
              space = {
                shiftwidth = 2,
              },
            },
          })
        end
      end

      -- 2-space indent by default for certain file types
      set_2_spaces({
        "css",
        "html",
        "javascript",
        "lua",
        "sass",
        "scss",
        "typescript",
      })
    end
  },
  -- Math equation display
  {
    'jbyuki/nabla.nvim',
    keys = {
      mode = "n",
      { '<leader>eqt', function () require("nabla").toggle_virt() end, desc = 'Toggle math [eq]uations' },
      { '<leader>eqq', function () require("nabla").popup() end, desc = "Show math [eq]uation popup" },
    },
  },
  -- Large file loading acceleration
  {
    'pteroctopus/faster.nvim',
    opts = {},
  },
}
