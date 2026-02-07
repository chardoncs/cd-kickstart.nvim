local function find_lazygit_buffer()
  for _, b in pairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_name(b):match("LazyGit$") then
      for i, t in ipairs(vim.api.nvim_list_tabpages()) do
        for _, w in pairs(vim.api.nvim_tabpage_list_wins(t)) do
          local buf = vim.api.nvim_win_get_buf(w)
          if buf == b then
            return {
              active_tabpage = i,
              buf = buf,
            }
          end
        end
      end
      return {
        active_tabpage = nil,
        buf = b,
      }
    end
  end

  return {
    active_tabpage = nil,
    buf = nil,
  }
end

vim.keymap.set(
  "n", "<leader>gl",
  function()
    -- Use existing tabpage with a buffer (hopefully) running LazyGit
    local result = find_lazygit_buffer()
    local active_tabpage = result.active_tabpage
    local buf = result.buf

    if active_tabpage ~= nil then
      vim.cmd.tabn(active_tabpage)
    else
      vim.cmd.tabnew()
    end

    if buf then
      vim.api.nvim_win_set_buf(0, buf)
    end

    if vim.bo.buftype ~= 'terminal' then
      vim.cmd.terminal()
      vim.fn.chansend(vim.bo.channel, "lazygit\n")
      vim.cmd [[keepalt file LazyGit]]
    end
    vim.cmd.startinsert()
  end,
  { desc = "Open Lazy[G]it in a builtin terminal in a new tabpage" }
)
