local M = {
  installed_fts = {},
  available_fts = {},
}

local function has_value(arr, val)
    for _, value in ipairs(arr) do
        if value == val then
            return true
        end
    end

    return false
end

function M:init()
  self:update_fts()
  self.available_fts = require("nvim-treesitter").get_available()
end

function M:update_fts()
  self.installed_fts = require("nvim-treesitter").get_installed()
end

return {
  -- Treesitter pattens
  --
  -- NOTE: Requires a C compiler (GCC or Clang) and libstdc++ for compiling patterns
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    opts = {
      --install_dir = vim.fn.stdpath('data') .. '/site',
    },
    init = function ()
      M:init()

      local group = vim.api.nvim_create_augroup("treesitter-automation", { clear = false })

      vim.api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = "*",
        callback = function()
          local ft = vim.bo.filetype

          -- Activate Tree-sitter when available
          if has_value(M.available_fts, ft) then
            -- Install filetype
            if not has_value(M.installed_fts, ft) then
              require("nvim-treesitter").install(ft)
              M:update_fts()
            end

            vim.treesitter.start()
          end
        end,
      })

      -- Fold
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo[0][0].foldmethod = 'expr'

      -- Indentation (experimental)
      --vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  },
  -- Display current scope at the top
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {},
  },
}
