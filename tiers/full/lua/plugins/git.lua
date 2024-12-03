return {
  -- Neogit
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
    },
    opts = {},
    keys = {
      {"<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit: Open [G]it viewer"},
    },
  },
  -- Git conflict highlight
  {
    'akinsho/git-conflict.nvim',
    opts = {},
    event = "VeryLazy",
  },
}
