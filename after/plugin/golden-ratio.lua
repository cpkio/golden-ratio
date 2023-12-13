vim.api.nvim_create_augroup('GoldenRatio', {clear = true})
vim.api.nvim_create_autocmd(
  { "WinEnter" },
  {
    group = 'GoldenRatio',
    pattern = { '*' },
    callback = function()
      local ui_width = vim.api.nvim_list_uis()[1].width
      local win_current_id = vim.api.nvim_tabpage_get_win(0)
      local windows_ids = vim.api.nvim_tabpage_list_wins(0)
      for _,v in pairs(windows_ids) do
        if (v ~= win_current_id) then
          local other_width = math.floor(ui_width * 0.5 / (#windows_ids - 1))
          vim.api.nvim_win_set_width(v, other_width)
        else
          vim.api.nvim_win_set_width(win_current_id, math.floor(ui_width * 0.5) )
        end
      end
    end
  }
)
