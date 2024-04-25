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
            -- Or Vim logo for nostalgic people =)
            -- icon = "",
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
        "r",
        "ruby",
        "sass",
        "scss",
        "typescript",
      })
    end
  },
  -- Large file loading acceleration
  --
  -- This plugin will shut down features like tree-sitter
  -- if the file is super large. Otherwise, Neovim will get stuck
  -- in a long loading.
  {
    'pteroctopus/faster.nvim',
    opts = {},
  },
}
