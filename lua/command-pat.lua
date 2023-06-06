local M = {}

local function show(item)
  print(vim.inspect(item))
end

local api = vim.api

local function get_visual_selection()
  local left_pos = api.nvim_buf_get_mark(0, '<')
  local start_row = left_pos[1] - 1
  local start_col = left_pos[2]
  local right_pos = api.nvim_buf_get_mark(0, '>')
  local end_row = right_pos[1] - 1
  local end_col = right_pos[2] + 1

  -- Fixes visual select out of bounds
  if end_col == 2147483648 then
    end_col = string.len(vim.fn.getline(end_row + 1))
  end

  local text = api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})

  if #text < 1 then
    error("Visual selection required")
  end

  if #text > 1 then
    error("Visual selection can only be on 1 line")
  end

  return text[1]
end

local function get_text_under_cursor()
  return vim.fn.expand("<cword>")
end

local function norm_command(cmd)
  api.nvim_command('norm ' .. cmd)
end

local function clear_cmdline()
  vim.cmd([[redraw | echo '']])
end

local function operateOnSelection(selection_text)
  vim.ui.input({ prompt = "Enter norm command: " }, function(cmd)
    if cmd == "" then
      clear_cmdline()
      return
    end

    local line_count = api.nvim_buf_line_count(0)
    local lines = api.nvim_buf_get_lines(0, 0, line_count, true)

   -- Check for all occurences with pattern and run command on them
    for line_idx, line in ipairs(lines) do
      local pattern_start_idx = string.find(line, selection_text)

      if pattern_start_idx then
        api.nvim_win_set_cursor(0, { line_idx, pattern_start_idx - 1 })
        norm_command(cmd)
      end
    end

    clear_cmdline()
  end)
end

function M.OperateOnVSelection()
  operateOnSelection(get_visual_selection())
end

function M.OperateOnNSelection()
  operateOnSelection(get_text_under_cursor())
end

return M