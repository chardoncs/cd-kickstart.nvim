return {
  -- Treesitter for syntax tree based highlight
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = false })()
    end,
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
          "lua",
          -- "python",
          -- "rust",
          -- "jsonc",
        },
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
  --
  -- Disable it if you don't like it.
  {
    "nvim-treesitter/nvim-treesitter-context",
    -- enabled = false,
    opts = {},
  },
}
