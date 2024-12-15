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
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "vim.lsp: Show information popup for hovered variable/function" })
-- Rename current variable/function
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "vim.lsp: [R]e[n]ame hovered variable/function" })
-- Format buffer
vim.keymap.set("n", "F", vim.lsp.buf.format, { desc = "vim.lsp: [F]ormat buffer" })

-- Tabpage and buffer control

vim.keymap.set("n", "<leader>tt", vim.cmd.tabnew, { desc = "Tabpage: Create a new [t]abpage, shorthand of `:tabnew`" })

vim.keymap.set("n", "<C-x>", vim.cmd.bdelete, { desc = "Buffer: remove current buffer, shorthand of `:bdelete`" })
