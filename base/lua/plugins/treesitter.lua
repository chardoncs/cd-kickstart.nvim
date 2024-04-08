return {
  -- Treesitter for syntax tree based highlight
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    run = function () vim.cmd.TSUpdate() end,
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "go",
          "javascript",
          "julia",
          "lua",
          "python",
          "rust",
          "typescript",
          "vim",
          "vimdoc",
          "query",
          "jsonc",
        },

        sync_install = false,
        auto_install = true,
        ignore_install = {},
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
