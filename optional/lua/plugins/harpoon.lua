return {
  -- Harpoon
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      --"nvim-telescope/telescope.nvim",
    },
    opts = {},
    init = function ()
      local harpoon = require("harpoon")

      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "[H]arpoon: " })

      vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
      vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      -- Telescope integration
      --vim.keymap.set(
      --  "n",
      --  "<C-e>",
      --  function ()
      --    local telescope_conf = require("telescope.config").values
      --    local files = harpoon:list()

      --    local paths = {}
      --    for _, item in ipairs(files) do
      --      table.insert(paths, item.value)
      --    end

      --    require("telescope.pickers").new({}, {
      --      prompt_title = "Harpoon",
      --      finder = require("telescope.finders").new_table({
      --          results = paths,
      --      }),
      --      previewer = telescope_conf.file_previewer({}),
      --      sorter = telescope_conf.generic_sorter({}),
      --    }):find()
      --  end,
      --  { desc = "[H]arpoon: Open harpoon window" }
      --)
    end
  },
}
