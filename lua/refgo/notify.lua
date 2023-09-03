local M = {}
local prefix = "[refgo] "

local notify_fn = vim.notify;

local print_cb = function(lvl, fmt, ...)
  notify_fn(prefix .. string.format(fmt, ...), lvl)
end

M.info = function(fmt, ...)
  print_cb(vim.log.levels.INFO, fmt, ...)
end

M.warn = function(fmt, ...)
  print_cb(vim.log.levels.WARN, fmt, ...)
end

M.error = function(fmt, ...)
  print_cb(vim.log.levels.ERROR, fmt, ...)
end

return M
