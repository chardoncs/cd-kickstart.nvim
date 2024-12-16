return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-emoji',
      'f3fora/cmp-spell',
      'L3MON4D3/LuaSnip',
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
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
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
        -- vim.fn.findfile("deno.json", vim.fn.getcwd()) and "denols" or "ts_ls",
      })

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
}
