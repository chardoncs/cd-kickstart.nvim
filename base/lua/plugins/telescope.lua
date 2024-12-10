return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Native FZF replacement written in C
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- Requies a C compiler (GCC or Clang)
        -- ... and CMake
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
        -- ... or gmake
        --build = "make",
      },
    },
    opts = {
      defaults = {
        file_ignore_patterns = {
          "^node_modules/",
          ".min.js$",
        },
        preview = {
          filesize_limit = 0.1,
        },
      },
    },
    init = function ()
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Telescope: [F]ind [F]iles in working directory" })
      vim.keymap.set('n', '<leader>lg', builtin.live_grep, { desc = "Telescope: [L]ive [G]rep" })
      vim.keymap.set('n', '<leader>fu', builtin.buffers, { desc = "Telescope: [F]ind B[u]ffers" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Telescope: [F]ind [H]elp" })
      vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "Telescope: [F]ind [G]it Files" })
      vim.keymap.set('n', '<leader>km', builtin.keymaps, { desc = "Telescope: Search [K]ey[m]aps" })
      vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = "Telescope: [F]ind in [C]urrent buffer" })

      vim.keymap.set('n', '<leader>tb', builtin.builtin, { desc = "[T]elescope: [B]uiltins" })

      vim.keymap.set(
        "n",
        "<leader>f.",
        function ()
          require("telescope.builtin").find_files {
            cwd = vim.fn.stdpath("config"),
          }
        end,
        { desc = "Telescope: [F]ind in the config directory" }
      )

      vim.keymap.set(
        "n",
        "<leader>f/",
        function ()
          local path = vim.fn.input("Directory: ")
          if path == "" then
            return
          end

          require("telescope.builtin").find_files {
            cwd = path,
          }
        end,
        { desc = "Telescope: [F]ind in an arbitrary directory" }
      )
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function ()
      require("telescope").load_extension "file_browser"
    end,
    init = function ()
      vim.keymap.set(
        'n',
        '<leader>fb',
        function()
          require("telescope").extensions.file_browser.file_browser()
        end,
        { desc = "Telescope: [F]ile [B]rowser in working directory" }
      )

      vim.keymap.set(
        'n',
        '<leader>fB',
        function()
          local path = vim.fn.input("Directory: ")
          if path == "" then
            return
          end

          require("telescope").extensions.file_browser.file_browser({ path = path })
        end,
        { desc = "Telescope: [F]ile [B]rowser in an arbitrary directory" }
      )
    end,
  },
}

