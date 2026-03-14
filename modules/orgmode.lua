return {
  {
  'nvim-orgmode/orgmode',
    event = "VeryLazy",
    opts = {
      org_agenda_files = "~/orgfiles/**/*",
      org_default_notes_file = "~/orgfiles/refile.org",
    },
    init = function ()
      -- Experimental LSP support
      vim.lsp.enable('org')
    end,
  },
  {
    "chipsenkbeil/org-roam.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-orgmode/orgmode",
    },
    opts = {
      directory = "~/org_roam_files",
      org_files = {
        --"~/another_org_dir",
        --"~/some/folder/*.org",
        --"~/a/single/org_file.org",
      },
    },
  },
  {
    "nvim-orgmode/telescope-orgmode.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-orgmode/orgmode",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("orgmode")

      vim.keymap.set("n", "<leader>r", require("telescope").extensions.orgmode.refile_heading)
      vim.keymap.set("n", "<leader>fo", require("telescope").extensions.orgmode.search_headings)
      vim.keymap.set("n", "<leader>li", require("telescope").extensions.orgmode.insert_link)
      vim.keymap.set("n", "<leader>ot", require("telescope").extensions.orgmode.search_tags)
    end,
  }
}
