local M = {}

M.autocomplete = function(line, commands)
  local l = vim.split(line, "%s+")
  local matches = {}
  local subcommands = commands.subcommands;
  for i = 1, #l - 1 do
    if subcommands[l[i]] then
      subcommands = subcommands[l[i]].subcommands
    end
  end
  if subcommands == nil then
    return matches
  end
  for k, _ in pairs(subcommands) do
    if vim.startswith(k, l[#l]) then
      table.insert(matches, k);
    end
  end
  return matches
end

M.select = function(args, command, pos)
  if pos == nil then
    pos = 1
  end
  if command.subcommands == nil then
    return command.default
  end
  local c = command.subcommands[args[pos]]
  if not c then
    return command.default
  else
    return M.select(args, c, pos + 1)
  end
end

M.join = function(args, sep)
  local s = ""
  for i, v in ipairs(args) do
    if i > 1 then
      s = s .. sep
    end
    s = s .. v
  end
  return s
end

return M
