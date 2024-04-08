return {
  -- Locating files and other stuff by telescope.nvim
  --
  -- Big shout out to TJ!
  {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function ()
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<leader>`', builtin.buffers, { desc = "Find [B]uffers" })

      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "[F]ind [F]iles" })
      vim.keymap.set('n', '<leader>lg', builtin.live_grep, { desc = "[L]ive [G]rep" })
      vim.keymap.set('n', '<leader>fu', builtin.buffers, { desc = "[F]ind B[u]ffers" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "[F]ind [H]elp Tags" })
      vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "[F]ind [G]it Files" })
      vim.keymap.set('n', '<leader>km', builtin.keymaps, { desc = "Search [K]ey[m]aps" })
      vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = "[F]ind in [C]urrent buffer" })

      vim.keymap.set('n', '<leader>tb', builtin.builtin, { desc = "[T]elescope [B]uiltins" })
    end,
  },
  -- File browser extension
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function ()
      vim.keymap.set('n', '<leader>fb', function() vim.cmd.Telescope("file_browser") end, { desc = "[F]ile [B]rowser" })
    end,
  },
  -- BibTeX extension
  --
  -- Disable this if you don't use LaTeX.
  {
    "nvim-telescope/telescope-bibtex.nvim",
    -- enabled = false,
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function ()
      require("telescope").load_extension("bibtex")

      vim.keymap.set('n', '<leader>bt', function() vim.cmd.Telescope("bibtex") end, { desc = "Find [B]ib[T]eX" })
    end
  },
}

