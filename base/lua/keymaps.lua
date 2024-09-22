-- Leader key
vim.g.mapleader = " "
-- Local leader key
vim.g.maplocalleader = " "

-- Toggle relative line number
vim.keymap.set(
  {"n", "v"},
  "<leader>]",
  function ()
    vim.wo.relativenumber = not vim.wo.relativenumber
    print("Line number mode: " .. (vim.wo.relativenumber and "relative" or "absolute"))
  end,
  { desc = "Toggle local relative line number" }
)

-- Moving selected text upwards/downwards
--
-- Thx ThePrimeagen btw :D
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move down selected text" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move up selected text" })

-- Spell check toggle
vim.keymap.set(
  "n", "<leader>s",
  function()
    vim.wo.spell = not vim.wo.spell
    print("Spell check " .. (vim.wo.spell and "on" or "off"))
  end,
  { desc = "Toggle [S]pell Check" }
)

-- LSP keymaps

-- Display info popup
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
-- Rename current variable/function
vim.keymap.set('n', '<leader>rm', vim.lsp.buf.rename)
