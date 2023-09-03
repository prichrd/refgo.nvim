local notify = require('refgo.notify');

local M = {}

M.git_remote_base_url = function()
  local origin = vim.fn.systemlist({'git', 'ls-remote', '--get-url', 'origin'})
  if #origin == 0 then
    notify.error("Could not find git remote origin")
    return
  end
  print(vim.inspect(origin))

  local sshRegex = "[%w%W]@([%w%W%.]+):([%w%W/%.]+).git"
  local _, _, host, repo = string.find(origin[1], sshRegex)
  return string.format("https://%s/%s", host, repo)
end

return M
