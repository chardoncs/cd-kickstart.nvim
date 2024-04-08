return {
  -- Themes go there
  {
    "EdenEast/nightfox.nvim",
    --"folke/tokyonight.nvim",
    --"catppuccin/nvim", name = "catppuccin",
    priority = 1000,
    opts = {},
    init = function ()
      -- Don't forget to change color scheme here.
      vim.cmd.colorscheme("carbonfox")
    end,
  },
}
