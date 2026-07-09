--- `nvim-cmp` adds code completion onto Neovim.
--- You can disable it to use LSP only.
local enable_cmp = true

local function register_lsp(default_config)
  --local root_pattern = require('lspconfig').util.root_pattern

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
    local names = {}

    for key, value in pairs(entries) do
      local name
      local config

      -- Assign `name` and `config` based on the key-value types
      if type(key) == "string" and type(value) == "table" then
        name = key
        config = concat_table(default_config, value)
      elseif type(value) == "string" then
        name = value
        config = default_config
      end

      if name and config then
        vim.lsp.config(name, config)
        table.insert(names, name)
      end
    end

    if #names > 0 then
      vim.lsp.enable(names)
    end
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
    --ts_ls = {
    --  root_markers = { "package.json" },
    --  filetypes = { "javascript", "jsx", "typescript", "tsx" }, -- Override filetypes
    --},
  })

  -- Other config here for LSP servers that need special care.
end

return {
  {
    "neovim/nvim-lspconfig",
    lazy = enable_cmp,
    init = function ()
      if not enable_cmp then
        register_lsp({})
      end
    end,
  },
  {
    "saghen/blink.cmp",
    event = enable_cmp and "VeryLazy" or nil,
    enabled = enable_cmp,
    dependencies = {
      "neovim/nvim-lspconfig",
      "rafamadriz/friendly-snippets",
    },
    version = '1.*',
    init = function ()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      register_lsp({
        capabilities = capabilities,
      })
    end,
    opts = {
      -- 'default' for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = 'super-tab' },

      completion = {
        documentation = {
          auto_show = true,
        },
      },
      sources = {
        --default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
    },
    opts_extend = { "sources.default" }
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
