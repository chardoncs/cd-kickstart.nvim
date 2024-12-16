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

vim.keymap.set("n", "<M-t>", vim.cmd.tabnew, { desc = "Tabpage: Create a new [t]abpage, shorthand of `:tabnew`" })

local ordinal_suffixes = { "st", "nd", "rd" }

for i = 1, 10 do
  vim.keymap.set(
    "n",
    string.format("<M-%d>", i % 10),
    function ()
      if not pcall(vim.cmd.tabn, i) then
        vim.print(string.format("Tabpage %d does not exist", i))
      end
    end,
    { desc = string.format("Tabpage: Go to the %d%s tabpage", i, ordinal_suffixes[i % 10] or "th") }
  )
end

vim.keymap.set("n", "<M-k>", vim.cmd.tabprevious, { desc = "Tabpage: Go to the previous tabpage, shorthand of `:tabprevious`" })
vim.keymap.set("n", "<M-j>", vim.cmd.tabnext, { desc = "Tabpage: Go to the next tabpage, shorthand of `:tabnext`" })
