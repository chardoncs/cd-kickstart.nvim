return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
  },
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
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
      local lspconfig = require("lspconfig")

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local function default_config(t)
        for _, name in ipairs(t) do
          lspconfig[name].setup {
            capabilities = capabilities,
          }
        end
      end

      default_config({
        -- LSP names here for default configuration
        --
        -- Check `:help lspconfig-all` for all options.
        --
        -- E.g.
        --
        -- "bashls",
        -- "clangd",
        -- "rust_analyzer",
        -- "zls",
      })

      -- Conditionally enable LSP servers based on configuration files

      ---- Deno
      --if next(vim.fs.find("deno.json", { type = "file", upward = true })) ~= nil then
      --  default_config({ "denols" })
      --end

      ---- JavaScript/TypeScript
      --if next(vim.fs.find("package.json", { type = "file", upward = true })) ~= nil then
      --  default_config({ "ts_ls" })
      --end

      ---- ESLint
      --if next(vim.fs.find(function (name) return name:match('^eslint%.config%.[mc]?[jt]s$') end, { type = "file", upward = true })) ~= nil then
      --  default_config({ "eslint" })
      --end

      -- Lua
      lspconfig.lua_ls.setup {
        on_init = function(client)
          local path = client.workspace_folders[1].name
          -- Use local config file if exists
          if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
            return
          end

          -- Default config
          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT'
            },
            workspace = {
              checkThirdParty = false,
              library = {
                -- Make the server aware of Neovim runtime files
                vim.env.VIMRUNTIME,
              },
            },
          })
        end,
        settings = {
          Lua = {},
        },
        capabilities = capabilities,
      }

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
