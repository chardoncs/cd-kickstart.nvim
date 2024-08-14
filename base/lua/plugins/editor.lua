return {
  -- Dev icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {},
  },
  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
      sections = {
        lualine_a = {
          {
            "mode",
            -- Display Neovim logo
            icon = "",
            -- Or Vim logo for nostalgic folks =)
            -- icon = "",
          },
        },
      },
    },
  },
  -- Tab bar
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function ()
      vim.g.barbar_auto_setup = false

      -- Move to previous/next buffer
      vim.keymap.set('n', '<A-h>', vim.cmd.BufferPrevious, { desc = "Previous buffer" })
      vim.keymap.set('n', '<A-l>', vim.cmd.BufferNext, { desc = "Next buffer" })
      -- Reorder buffer to previous/next
      vim.keymap.set('n', '<A-H>', vim.cmd.BufferMovePrevious, { desc = "Move current buffer forward" })
      vim.keymap.set('n', '<A-L>', vim.cmd.BufferMoveNext, { desc = "Move current buffer backward" })

      -- Goto buffer in position...
      for i = 1, 10 do
        vim.keymap.set(
          'n',
          string.format("<A-%d>", i % 10),
          function() vim.cmd.BufferGoto(i) end,
          { desc = string.format("Go to the #%d buffer", i), }
        )
      end
      vim.keymap.set('n', '<A-->', vim.cmd.BufferLast, { desc = "Go to the last buffer" })
      -- Pin/unpin buffer
      vim.keymap.set('n', '<A-p>', vim.cmd.BufferPin, { desc = "[P]in buffer" })
      -- Close buffer
      vim.keymap.set('n', '<A-x>', vim.cmd.BufferClose, { desc = "Close buffer" })
      -- Wipeout buffer
      --                 :BufferWipeout
      -- Close commands
      --                 :BufferCloseAllButCurrent
      --                 :BufferCloseAllButPinned
      --                 :BufferCloseAllButCurrentOrPinned
      --                 :BufferCloseBuffersLeft
      --                 :BufferCloseBuffersRight
      -- Magic buffer-picking mode
      vim.keymap.set('n', '<C-p>', vim.cmd.BufferPick)
      -- Sort automatically by...
      vim.keymap.set('n', '<leader>bb', vim.cmd.BufferOrderByBufferNumber, { desc = "[B]uffer order by [B]uffer number" })
      vim.keymap.set('n', '<leader>bd', vim.cmd.BufferOrderByDirectory, { desc = "[B]uffer order by [D]irectory" })
      vim.keymap.set('n', '<leader>bl', vim.cmd.BufferOrderByLanguage, { desc = "[B]uffer order by [L]anguage" })
      vim.keymap.set('n', '<leader>bw', vim.cmd.BufferOrderByWindowNumber, { desc = "[B]uffer order by [W]indow number" })
    end,
    opts = {},
  },
  -- Indentation guessing
  {
    "hrsh7th/nvim-dansa",
    event = "VeryLazy",
    config = function ()
      local setup = require("dansa").setup

      -- Default
      setup({
        scan_offset = 100,
        cutoff_count = 5,
        default = {
          expandtab = true,
          space = {
            shiftwidth = 4,
          },
          tab = {
            shiftwidth = 4,
          },
        },
      })

      -- Reserve tabs for Go
      setup.filetype('go', {
        default = {
          expandtab = false,
          tab = {
            shiftwidth = 4,
          },
        },
      })

      local function set_2_spaces(fts)
        for _, ft in pairs(fts) do
          setup.filetype(ft, {
            default = {
              space = {
                shiftwidth = 2,
              },
            },
          })
        end
      end

      -- 2-space indent by default for certain file types
      set_2_spaces({
        "css",
        "dart",
        "elm",
        "gleam",
        "html",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "r",
        "ruby",
        "typescript",
        "typescriptreact",
        "sass",
        "svelte",
        "yaml",
      })
    end
  },
  -- Large file loading acceleration
  --
  -- This plugin will shut down features like tree-sitter
  -- if the file is super large. Otherwise, Neovim will get stuck
  -- in a long loading with crazy RAM consumption.
  {
    'pteroctopus/faster.nvim',
    opts = {},
  },
  -- Trouble panel
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Trouble: Toggle diagnostics",
      },
      {
        "<leader>xb",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Trouble: [B]uffer diagnostics",
      },
     {
        "<leader>xs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Trouble: Toggle [s]ymbols",
      },
      {
        "<leader>xl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "Trouble: Toggle [L]SP tree",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Trouble: Toggle [l]ocation List",
      },
      {
        "<leader>xq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Trouble: Toggle [Q]uickfix List",
      },
    },
  },
  -- Key hint
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "which-key: Buffer Local Keymaps",
      },
    },
  },
}
