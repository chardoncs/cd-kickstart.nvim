return {
  {
    "lervag/vimtex",
    ft = { "tex", "bib" },
    config = function ()
      --vim.g.vimtex_compiler_latexmk_engines = {
      --  ["_"] = '-xelatex'
      --}

      --vim.g.vimtex_compiler_latexmk = {
      --  ['options'] = {
      --    "-verbose",
      --    "-file-line-error",
      --    "-synctex=1",
      --    "-interaction=nonstopmode",
      --    "-shell-escape",
      --  }
      --}
    end,
  },
  -- Equation display
  {
    'jbyuki/nabla.nvim',
    keys = {
      { '<leader>eqt', function () require("nabla").toggle_virt() end, desc = '[T]oggle math [eq]uations' },
      { '<leader>eqq', function () require("nabla").popup() end, desc = "Show math [eq]uation popup" },
    },
  },
  -- Telescope BibTeX integration
  {
    "nvim-telescope/telescope-bibtex.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function ()
      require("telescope").load_extension("bibtex")

      vim.keymap.set('n', '<leader>bt', function() vim.cmd.Telescope("bibtex") end, { desc = "Telescope: Find [B]ib[T]eX" })
    end
  },
}
