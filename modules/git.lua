return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = {
      {
        "<leader>gg",
        "<cmd>Neogit<cr>",
        desc = "Neo[g]it: Open Neogit",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
  },
  -- Git conflict highlight
  {
    'akinsho/git-conflict.nvim',
    opts = {},
    event = "VeryLazy",
  },
}
