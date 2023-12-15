vim.api.nvim_create_augroup('GoldenRatio', {clear = true})
vim.api.nvim_create_autocmd(
  { "WinEnter" },
  {
    group = 'GoldenRatio',
    pattern = { '*' },
    callback = function()
      local win_current_id = vim.api.nvim_tabpage_get_win(0)
      if vim.api.nvim_win_get_config(win_current_id).relative ~= '' then
        return
      end

      local ui_width = vim.api.nvim_list_uis()[1].width
      local windows_ids = vim.api.nvim_tabpage_list_wins(0)

      local full_width_count = 0
      for _, v in pairs(windows_ids) do
        if (vim.api.nvim_win_get_width(v) == ui_width) then
          full_width_count = full_width_count + 1
        end
      end
      for _, v in pairs(windows_ids) do

        if (v ~= win_current_id) then
          if (vim.api.nvim_win_get_width(v) ~= ui_width) then
            local other_width = math.floor(ui_width * 0.5 / (#windows_ids - full_width_count - 1))
            vim.api.nvim_win_set_width(v, other_width)
          end
          if (vim.api.nvim_win_get_width(v) == ui_width) then
            -- do nothing
          end
        else

          if (vim.api.nvim_win_get_width(v) ~= ui_width) then
            vim.api.nvim_win_set_width(win_current_id, math.ceil(ui_width * 0.5) )
          end
          if (vim.api.nvim_win_get_width(v) == ui_width) then
            local other_width = math.floor(ui_width / (#windows_ids - full_width_count)) -- we dont know about multirow + multicolumn layout, only 1-row layout supported
            for _, w in pairs(windows_ids) do
              if (v ~= w) then
                vim.api.nvim_win_set_width(w, other_width)
              end
            end
          end
        end

      end
    end
  }
)
