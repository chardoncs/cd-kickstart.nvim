-- Display line number
vim.opt.number = true
-- Relative line number
-- e.g.
-- 
--   3  package main
--   2 
--   1  func swap[T interface{}](x, y *T) {
-- 4        tmp := *x| <- cursor here
-- 	 1      *x = *y
-- 	 2      *y = tmp
--   3  }
vim.opt.relativenumber = true

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
