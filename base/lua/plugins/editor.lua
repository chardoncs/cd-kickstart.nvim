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
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      options = {
        component_separators = { left = "", right = ""},
        section_separators = { left = "", right = ""},
      },
      sections = {
        lualine_a = {
          {
            "mode",
            -- Display Neovim logo
            --icon = "",
            -- Or Vim logo for nostalgic folks =)
            --icon = "",
            fmt = function (str)
              local out = ""

              for part in string.gmatch(str, "[%w]+") do
                out = out .. string.sub(part, 0, 1)
              end

              return string.format("%-2s", out)
            end,
          },
        },
        lualine_x = {
          "encoding",
          {
            "fileformat",
            icons_enabled = true,
            symbols = {
              unix = "LF",
              dos = "CRLF",
              mac = "CR",
            },
          },
          "filetype",
        },
      },
    },
  },
  -- Tab bar
  {
    "nanozuki/tabby.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      line = function (line)
        return {
          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and "TabLineSel" or "TabLine"

            return {
              line.sep("", hl, "TabLineFill"),
              tab.number(),
              tab.name(),
              tab.close_btn(''),
              line.sep("", hl, "TabLineFill"),
              hl = hl,
              margin = " ",
            }
          end),
          line.spacer(),
          line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
            return {
              " ",
              win.buf_name(),
              " ",
              hl = "TabLine",
            }
          end),
          hl = "TabLineFill",
        }
      end,
    },
  },
  -- Indentation guessing
  {
    "chardoncs/indent-wizard.nvim",
    opts = {
      auto_guess = true,
      scan = {
        line_count = 60,
      },
      defaults = {
        {
          ft = "go",
          options = {
            expandtab = false,
            shiftwidth = 4,
          },
        },
        {
          ft = {
            "css",
            "dart",
            "elm",
            "gleam",
            "html",
            "javascript",
            "json",
            "jsonc",
            "lua",
            "ocaml",
            "r",
            "ruby",
            "typescript",
            "typescriptreact",
            "sass",
            "svelte",
            "yaml",
          },
          options = {
            shiftwidth = 2,
          },
        },
      },
    },
  },
  -- Large file loading acceleration
  --
  -- This plugin will shut down features like tree-sitter
  -- if the file is super large. Otherwise, Neovim will get stuck
  -- in a long loading with crazy RAM consumption.
  { "chardoncs/bigfile.nvim" },
  -- Trouble panel
  {
    "folke/trouble.nvim",
    lazy = true,
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Trouble: Toggle diagnostics",
      },
      {
        "<leader>xb",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Trouble: [B]uffer diagnostics",
      },
     {
        "<leader>xs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Trouble: Toggle [s]ymbols",
      },
      {
        "<leader>xl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "Trouble: Toggle [L]SP tree",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Trouble: Toggle [l]ocation List",
      },
      {
        "<leader>xq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Trouble: Toggle [Q]uickfix List",
      },
    },
  },
  -- Key hint
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "which-key: Buffer Local Keymaps",
      },
    },
  },
}
