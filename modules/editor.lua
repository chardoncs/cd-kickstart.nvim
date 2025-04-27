return {
  -- Tab bar
  {
    "nanozuki/tabby.nvim",
    opts = {
      line = function (line)
        return {
          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and "TabLineSel" or "TabLine"

            return {
              line.sep("", hl, "TabLineFill"),
              tab.number(),
              tab.name(),
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
      auto_guess = false,
      scan = {
        line_count = 20,
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
}
