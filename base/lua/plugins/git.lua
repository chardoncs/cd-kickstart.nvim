return {
  -- Neogit
  {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
    },
    config = function ()
      require("neogit").setup {}

      vim.keymap.set('n', '<leader>gg', vim.cmd.Neogit, { desc = "[G]it viewer by Neo[g]it" })
    end,
  },
  -- Git conflict highlight
  {
    'akinsho/git-conflict.nvim',
    config = true,
    event = "VeryLazy",
  },
}
