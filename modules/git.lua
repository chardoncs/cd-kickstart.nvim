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
    init = function ()
      -- Workaround for Neogit bug
      --
      -- See https://github.com/NeogitOrg/neogit/issues/1696
      vim.api.nvim_create_autocmd("User", {
        pattern = "NeogitCommitComplete",
        callback = function() vim.cmd.tabprevious() end
      })
    end,
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
