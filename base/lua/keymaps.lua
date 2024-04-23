-- Leader key
vim.g.mapleader = " "
-- Local leader key
vim.g.maplocalleader = " "

-- Toggle relative line number
vim.keymap.set(
  {"n", "v"},
  "<leader>rr",
  function ()
    vim.wo.relativenumber = not vim.wo.relativenumber
  end,
  { desc = "Toggle [r]elative line number for current buffer" }
)

-- Moving selected text upwards/downwards
--
-- Thx ThePrimagen btw :D
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

-- Buffer shifting (useful with barbar.nvim)

-- Move to previous/next buffer
vim.keymap.set('n', '<A-h>', vim.cmd.BufferPrevious, { desc = "Previous buffer" })
vim.keymap.set('n', '<A-l>', vim.cmd.BufferNext, { desc = "Next buffer" })
-- Reorder buffer to previous/next
vim.keymap.set('n', '<A-H>', vim.cmd.BufferMovePrevious, { desc = "Move current buffer forward" })
vim.keymap.set('n', '<A-L>', vim.cmd.BufferMoveNext, { desc = "Move current buffer backward" })

-- Goto buffer in position...
for i = 1, 10 do
  vim.keymap.set(
    'n',
    string.format("<A-%d>", i % 10),
    function() vim.cmd.BufferGoto(i) end,
    { desc = string.format("Go to the #%d buffer", i), }
  )
end
vim.keymap.set('n', '<A-->', vim.cmd.BufferLast, { desc = "Go to the last buffer" })
-- Pin/unpin buffer
vim.keymap.set('n', '<A-p>', vim.cmd.BufferPin, { desc = "[P]in buffer" })
-- Close buffer
vim.keymap.set('n', '<A-x>', vim.cmd.BufferClose, { desc = "Close buffer" })
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
vim.keymap.set('n', '<C-p>', vim.cmd.BufferPick)
-- Sort automatically by...
vim.keymap.set('n', '<leader>bb', vim.cmd.BufferOrderByBufferNumber, { desc = "[B]uffer order by [B]uffer number" })
vim.keymap.set('n', '<leader>bd', vim.cmd.BufferOrderByDirectory, { desc = "[B]uffer order by [D]irectory" })
vim.keymap.set('n', '<leader>bl', vim.cmd.BufferOrderByLanguage, { desc = "[B]uffer order by [L]anguage" })
vim.keymap.set('n', '<leader>bw', vim.cmd.BufferOrderByWindowNumber, { desc = "[B]uffer order by [W]indow number" })

-- LSP keymaps

-- Display info popup
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
-- Rename current variable/function
vim.keymap.set('n', '<leader>rm', vim.lsp.buf.rename)
