local notify = require('refgo.notify');
local git = require('refgo.git');

local copyClipboard = function(ref)
  vim.fn.setreg("*", ref)
  vim.fn.setreg("+", ref)
  notify.info("Copied '%s' to clipboard", ref)
end

local getReference = function()
  local fp = vim.fn.expand("%")
  local cwd = vim.fn.getcwd()
  local filepath = string.gsub(fp, cwd .. "/", "")
  local winid = vim.api.nvim_get_current_win()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(winid))
  return {
    filepath = filepath,
    row = row
  }
end

return {
  subcommands = {
    ['copy'] = {
      default = function()
        local ref = getReference()
        copyClipboard(string.format("%s:%d", ref.filepath, ref.row))
      end,
      subcommands = {
        ['link'] = {
          default = function()
            local remote_url = git.git_remote_base_url()
            if not remote_url then
              notify.warn("Could not get remote URL")
              return
            end
            local ref = getReference()
            copyClipboard(string.format("%s/blob/master/%s#L%d", remote_url, ref.filepath, ref.row))
          end
        }
      },
    },
    ['open'] = {
      default = function(args)
        local reference = args[2]
        if reference == nil or reference == "" then
          reference = vim.fn.getreg("*", 1)
        end

        local match = string.gmatch(reference, "(.+):(%d+)")
        local path, line = match()
        if path == nil then
          notify.warn("Could not parse '%s' as '<file path>:<line no>'", reference)
          return
        end
        vim.cmd(":e " .. path)
        vim.cmd(":" .. line)
      end
    },
  },
}
