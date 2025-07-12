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
