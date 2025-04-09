return {
  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      options = {
        component_separators = { left = "", right = ""},
        section_separators = { left = "", right = ""},
      },
      sections = {
        lualine_a = {
          --{
          --  "mode",
          --  -- Display Neovim logo
          --  --icon = "",
          --  -- Or Vim logo for nostalgic folks =)
          --  --icon = "",
          --},
        },
        lualine_x = {
          "encoding",
          {
            "fileformat",
            icons_enabled = true,
            symbols = {
              unix = "LF",
              dos = "CRLF",
              mac = "CR",
            },
          },
          "filetype",
        },
      },
    },
  },
}
