return {
  -- Image pasting
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      filetypes = {
        markdown = {
          url_encode_path = true,
          template = '![$CURSOR]($FILE_PATH)',
          drag_and_drop = {
            download_images = false,
          },
        },
        quarto = {
          url_encode_path = true,
          template = '![$CURSOR]($FILE_PATH)',
          drag_and_drop = {
            download_images = false,
          },
        },
      },
    },
    keys = {
      { "<leader>pi", function () vim.cmd.PasteImage() end, desc = "[P]aste [i]mage from system clipboard" },
    },
  },
}
