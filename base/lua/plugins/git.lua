return {
  -- LazyGit in neovim
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "<leader>gg",
        function () vim.cmd[[LazyGit]] end,
        desc = "Lazy[G]it.nvim: Launch LazyGit in a Neovim window (requiring LazyGit installed on your computer)"
      },
    }
  },
  -- Git conflict highlight
  {
    'akinsho/git-conflict.nvim',
    opts = {},
    event = "VeryLazy",
  },
}
