return {
  {
    "stevearc/oil.nvim",
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    init = function ()
      vim.api.nvim_create_user_command("Explore", "Oil", { desc = "Alias of `Oil`" })
      vim.api.nvim_create_user_command(
        "Sexplore",
        function ()
          vim.cmd.split()
          vim.cmd.Oil()
        end,
        { desc = "Split the window horizontally and open file manager (oil.nvim)" }
      )
      vim.api.nvim_create_user_command(
        "Vexplore",
        function ()
          vim.cmd.vsplit()
          vim.cmd.Oil()
        end,
        { desc = "Split the window vertically and open file manager (oil.nvim)" }
      )
    end,
  },
}
