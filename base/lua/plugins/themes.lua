return {
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    opts = {
      style = "deep",
    },
    init = function ()
      require("onedark").load()
    end,
  },
}
