local M = {}

function M.setup(client)
  local ts = require "typescript"
  ts.setup()
end

return M
