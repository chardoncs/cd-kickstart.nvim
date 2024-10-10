-- Display line number
vim.opt.number = true

-- Relative line number
-- e.g.
--
--   6  package main
--   5
--   4  import "fmt"
--   3
--   2  func swap[T interface{}](x, y *T) {
-- 	 1      *x, *y = *y, *x
-- 7    }| <- your cursor here
--   1
--   2  func main() {
-- 	 3      a, b := 1, 2
--   4
-- 	 5      swap(&a, &b)
--   6
-- 	 7      fmt.Println(a, b)
--   8  }
vim.opt.relativenumber = true

-- Smart relative line number
--
-- Using absolute line in insert mode, otherwise using relative.
local smart_relative_line = false

if smart_relative_line then
  vim.api.nvim_create_autocmd({ "InsertEnter" }, {
    desc = "Disable relative line numbers in insert mode",
    callback = function () vim.opt.relativenumber = false end,
  })

  vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    desc = "Enable relative line number outside insert mode",
    callback = function () vim.opt.relativenumber = true end,
  })
end

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- Tab to space
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.smartindent = true

vim.opt.incsearch = true

-- Wrap
vim.opt.wrap = false
-- True color display
vim.opt.termguicolors = true

-- Sign column on the left
vim.opt.signcolumn = 'yes'
--vim.opt.colorcolumn = ''

-- Buffer update time
vim.opt.updatetime = 50

-- Spell check
--vim.opt.spell = true
vim.opt.spelllang = 'en_us'

-- Margin size between the cursor and the top/bottom edge
vim.opt.scrolloff = 8

-- Mode display at bottom-left side.
--
-- e.g.
--
-- `-- INSERT --` while Neovim is in insert mode.
--
-- > Lualine shows mode also, so no need of double display.
vim.opt.showmode = false
