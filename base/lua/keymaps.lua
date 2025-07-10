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

-- Tab switching
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

vim.keymap.set("n", "<M-p>", vim.cmd.tabprevious, { desc = "Tabpage: Go to the [p]revious tabpage, shorthand of `:tabprevious`" })
vim.keymap.set("n", "<M-n>", vim.cmd.tabnext, { desc = "Tabpage: Go to the [n]ext tabpage, shorthand of `:tabnext`" })

-- Tab moving 
for i = 1, 10 do
  vim.keymap.set(
    "n",
    string.format("<M-S-%d>", i % 10),
    function ()
      if not pcall(vim.cmd.tabmove, i - (i < vim.fn.tabpagenr() and 1 or 0)) then
        vim.print(string.format("Tabpage %d does not exist", i))
      end
    end,
    { desc = string.format("Tabpage: Move current tabpage to the %d%s", i, ordinal_suffixes[i % 10] or "th") }
  )
end

vim.keymap.set("n", "<M-S-p>", function () vim.cmd.tabmove("-") end, { desc = "Tabpage: Move current tabpage leftwards, shorthand of `:tabmove -`" })
vim.keymap.set("n", "<M-S-n>", function () vim.cmd.tabmove("+") end, { desc = "Tabpage: Move current tabpage rightwards, shorthand of `:tabmove +`" })

-- Open Terminal
vim.keymap.set(
  "n", "<leader>tt",
  function ()
    vim.cmd.tabnew()
    vim.cmd.terminal()
    vim.cmd.startinsert()
  end,
  { desc = "Open builtin [t]erminal in a new tabpage" }
)

-- LazyGit trigger
vim.keymap.set(
  "n", "<leader>gl",
  function ()
    -- Use existing tabpage with a buffer (hopefully) running LazyGit
    local existing_buf = nil

    for _, b in pairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_get_name(b):match("/LazyGit$") then
        for i, t in ipairs(vim.api.nvim_list_tabpages()) do
          for _, w in pairs(vim.api.nvim_tabpage_list_wins(t)) do
            local buf = vim.api.nvim_win_get_buf(w)
            if buf == b then
              vim.cmd.tabn(i)
              vim.cmd.startinsert()
              return
            end
          end
        end
        existing_buf = b
        break
      end
    end

    vim.cmd.tabnew()
    if existing_buf then
      vim.api.nvim_win_set_buf(0, existing_buf)
    else
      vim.cmd.terminal()
      vim.fn.chansend(vim.bo.channel, "lazygit\n")
      vim.cmd[[keepalt file LazyGit]]
    end
    vim.cmd.startinsert()
  end,
  { desc = "Open Lazy[G]it in a builtin terminal in a new tabpage" }
)
