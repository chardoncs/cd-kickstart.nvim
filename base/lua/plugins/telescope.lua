return {
  {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function ()
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Telescope: [F]ind [F]iles" })
      vim.keymap.set('n', '<leader>lg', builtin.live_grep, { desc = "Telescope: [L]ive [G]rep" })
      vim.keymap.set('n', '<leader>fu', builtin.buffers, { desc = "Telescope: [F]ind B[u]ffers" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Telescope: [F]ind [H]elp Tags" })
      vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "Telescope: [F]ind [G]it Files" })
      vim.keymap.set('n', '<leader>km', builtin.keymaps, { desc = "Telescope: Search [K]ey[m]aps" })
      vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = "Telescope: [F]ind in [C]urrent buffer" })

      vim.keymap.set('n', '<leader>tb', builtin.builtin, { desc = "[T]elescope: [B]uiltins" })
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function ()
      vim.keymap.set('n', '<leader>fb', function() vim.cmd.Telescope("file_browser") end, { desc = "Telescope: [F]ile [B]rowser" })
    end,
  },
}

