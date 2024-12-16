return {
  -- ThePrimeagen's Harpoon
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {},
    init = function ()
      local harpoon = require("harpoon")

      vim.keymap.set(
        "n",
        "<leader>hh",
        function()
          if pcall(function () harpoon:list():add() end) then
            vim.print("Buffer added to Harpoon list")
          else
            vim.api.nvim_err_writeln("Error: Failed to add buffer")
          end
        end,
        { desc = "[H]arpoon: Add current buffer to Harpoon list" }
      )

      local ordinal_suffixes = { "st", "nd", "rd" }

      for i = 1, 10 do
        vim.keymap.set(
          "n",
          string.format("<C-%d>", i % 10),
          function() harpoon:list():select(i) end,
          { desc = string.format("Harpoon: Select the %d%s buffer in the Harpoon list", i, ordinal_suffixes[i % 10] or "th") }
        )
      end

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set(
        "n",
        "<C-K>",
        function() harpoon:list():prev() end,
        { desc = "Harpoon: Switch to the previous buffer in the Harpoon list" }
      )
      vim.keymap.set(
        "n",
        "<C-J>",
        function() harpoon:list():next() end,
        { desc = "Harpoon: Switch to the next buffer in the Harpoon list" }
      )

      vim.keymap.set(
        "n",
        "<leader>hm",
        function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
        { desc = "[H]arpoon: Open Harpoon list [m]enu" }
      )
    end
  },
}
