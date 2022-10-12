if vim.g.loaded_refgo == 1 then
  return
end
vim.g.loaded_refgo = 1

local refgo = require'refgo'

vim.api.nvim_create_user_command('RefCopy', function()
  refgo.copy()
end, {})

vim.api.nvim_create_user_command('RefGo', function(opts)
  local ref = opts.args
  refgo.open(ref)
end, {
  nargs = '?',
})
