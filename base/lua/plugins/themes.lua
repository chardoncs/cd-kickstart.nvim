return {
  {
    "Shatur/neovim-ayu", name = "ayu",
    --"folke/tokyonight.nvim",
    -- "catppuccin/nvim", name = "catppuccin",
    priority = 1000,
    opts = {},
    init = function ()
      vim.cmd.colorscheme("ayu-dark")
    end,
  },
}
