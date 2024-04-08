return {
  -- TeX/LaTeX helper
  {
    "lervag/vimtex",
    ft = { "tex", "bib" },
    config = function ()
      vim.g.vimtex_compiler_latexmk_engines = {
        -- LaTeX engine
        --["_"] = '-xelatex'
      }

      vim.g.vimtex_compiler_latexmk = {
        ['options'] = {
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
          -- If using `minted`
          -- "-shell-escape",
        }
      }
    end,
  },
}
