return {
  -- gitignore files
  {
    "wintermute-cell/gitignore.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function ()
      require("gitignore")
    end,
    cmd = "Gitignore",
    keys = {
      { "<leader>gi", function () require("gitignore").generate() end, desc = "Generate [g]it[i]gnore file" },
    },
  },
}
