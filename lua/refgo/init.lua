local M = {};

local notify_fn = vim.notify_once or vim.notify

-- Copies the current line reference to the selection registers (* and +)
M.copy = function()
  local fp = vim.fn.expand('%')
  local cwd = vim.fn.getcwd()
  local relpath = string.gsub(fp, cwd .. "/", "")

  local winid = vim.api.nvim_get_current_win()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(winid))
  local ref = string.format("%s:%d", relpath, row)
  vim.fn.setreg("*", ref)
  notify_fn(string.format("Copied '%s' to clipboard", ref), vim.log.levels.INFO)
end

-- Opens the provided reference. If no reference is passed down, the selection
-- register will be used as the default reference value.
M.open = function(reference)
  if reference == nil or reference == "" then
    reference = vim.fn.getreg("*", 1)
  end

  local match = string.gmatch(reference, "(.+):(%d+)")
  local path, line = match()
  if path == nil then
    notify_fn(string.format("Could not parse '%s' as '<file path>:<line no>'", reference), vim.log.levels.WARN)
    return
  end
  vim.cmd(":e " .. path)
  vim.cmd(":" .. line)
end

return M
