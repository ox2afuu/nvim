local M = {}

M.dirs = {}
M.env_vars = {}
M.actions = {}

function M.setup(opts)
  opts = opts or {}
  M.dirs = opts.dirs or {}
  M.env_vars = opts.env_vars or {}
  M.actions = opts.actions or {}
end

return M
