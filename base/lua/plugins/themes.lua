return {
  -- Tokyo Night 
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      terminal_colors = false,
      styles = {
        sidebars = "transparent",
        floats = "dark",
      },
      lualine_bold = true,
      cache = true,
      plugins = {
        auto = true,
      },
      on_colors = function (colors)
        colors.border_highlight = colors.blue
        colors.BufferCurrentSign = colors.border_highlight
      end,
    },
    init = function ()
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
