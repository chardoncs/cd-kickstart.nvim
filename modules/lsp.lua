return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-emoji",
      "f3fora/cmp-spell",
      "L3MON4D3/LuaSnip",
    },
    config = function ()
      local cmp = require('cmp')
      cmp.setup {
        snippet = {
          expand = function(args)
            local luasnip = require("luasnip")

            luasnip.lsp_expand(args.body)
            -- Map file type to snippets
            luasnip.filetype_extend('quarto', { 'markdown' })
            luasnip.filetype_extend('rmarkdown', { 'markdown' })
          end,
        },
        window = {},
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
          ["<C-e>"] = cmp.mapping.abort(),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = "path" },
          { name = "calc" },
          { name = "emoji" },
          { name = "spell" },
          { name = "otter" },
        }
      }
    end,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    event = "VeryLazy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = function ()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      --local root_pattern = require("lspconfig").util.root_pattern

      local function concat_table(first, second)
        local output = {}

        for key, value in pairs(first) do
          output[key] = value
        end

        for key, value in pairs(second) do
          output[key] = value
        end

        return output
      end

      local function enable_configs(entries)
        local default_extension = {
          capabilities = capabilities,
        }

        local names = {}

        for key, value in pairs(entries) do
          local name
          local config

          -- Assign `name` and `config` based on the key-value types
          if type(key) == "string" and type(value) == "table" then
            name = key
            config = concat_table(default_extension, value)
          elseif type(value) == "string" then
            name = value
            config = default_extension
          end

          if name and config then
            vim.lsp.config(name, config)
            table.insert(names, name)
          end
        end

        vim.lsp.enable(names)
      end

      enable_configs({
        -- LSP names here for configuration
        --
        -- Check `:help lspconfig-all` for all options.
        --
        -- E.g.
        --
        --"bashls",
        --"clangd",
        --"rust_analyzer",
        --"zls",
        --denols = {
        --  root_markers = { "deno.json", "deno.jsonc" },
        --},
        --eslint = {
        --  root_dir = root_pattern('^eslint%.config%.[mc]?[jt]s$') or vim.fn.getcwd(),
        --},
        --lua_ls = {
        --  on_init = function(client)
        --    local path = vim.fn.getcwd()
        --    -- Use local config file if exists
        --    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
        --      return
        --    end

        --    -- Default config
        --    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        --      runtime = {
        --        version = 'LuaJIT'
        --      },
        --      workspace = {
        --        checkThirdParty = false,
        --        library = {
        --          -- Make the server aware of Neovim runtime files
        --          vim.env.VIMRUNTIME,
        --        },
        --      },
        --    })
        --  end,
        --  settings = {
        --    Lua = {},
        --  },
        --},
      })

      -- Other config here for LSP servers that need special care.
    end,
  },
  -- Trouble panel
  {
    "folke/trouble.nvim",
    lazy = true,
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
}
