if vim.g.loaded_refgo == 1 then
  return
end
vim.g.loaded_refgo = 1

local notify = require("refgo.notify");
local commands = require("refgo.commands");
local refgo = require("refgo")

vim.api.nvim_create_user_command("RefCopy", function()
  notify.warn("RefCopy is deprecated and will be removed soon, use `Refgo copy` instead")
  refgo.copy()
end, {})

vim.api.nvim_create_user_command("RefGo", function(opts)
  notify.warn("RefGo is deprecated and will be removed soon, use `Refgo open` instead")
  local ref = opts.args
  refgo.open(ref)
end, {
  nargs = "?",
})

vim.api.nvim_create_user_command("Refgo", function(opts)
  local args = opts.fargs
  if #args == 0 then
    notify.error("No command provided, please consult the docs: ':h refgo.nvim'")
    return
  end

  local command = commands.select(args, refgo)
  if not command then
    notify.error("Command '%s' not found, please consult the docs: ':h refgo.nvim'", commands.join(args, ' '))
    return
  end
  command();
end, {
  nargs = "*",
  complete = function(_, line)
    return commands.autocomplete(line, refgo)
  end
})
