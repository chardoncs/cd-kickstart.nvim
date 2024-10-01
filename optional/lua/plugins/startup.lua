return {
  -- Startup screen
  {
    "startup-nvim/startup.nvim",
    config = function ()
      require("startup").setup()
    end,
  },
  -- Startup time statistics
  { "dstein64/vim-startuptime" },
}
