return {
  -- Treesitter pattens
  --
  -- NOTE: Requires a C compiler (GCC or Clang) and libstdc++ for compiling patterns
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          -- Add configs that should always get installed.
          -- Otherwise, the plugin will not install them until
          -- Neovim encounters corresponding file types.
          --
          -- Check supported languages at:
          -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
          --
          -- E.g.
          -- "lua",
          -- "python",
          -- "rust",
          -- "jsonc",
        },
        -- Use with `ensure_installed`
        sync_install = false,
        auto_install = true,
        ignore_install = {
          -- Ignored file types here
        },
        highlight = {
          enable = true,
          disable = {},
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  },
  -- Display current scope at the top
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {},
  },
}
