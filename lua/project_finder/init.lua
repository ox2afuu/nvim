---
--- project_finder/init.lua
---
--- Main entry for project_finder plugin. Provides repo discovery, picker, and custom action API.
---
local M = {}
local Job = require("plenary.job")
local Path = require("plenary.path")
local dashboard = require("project_finder.dashboard")
local config = require("project_finder.config")

--- Table of registered actions (name -> {description, action})
M.actions = {}

--- Register a custom action for the dashboard or repo picker.
--- @param name string: action name (unique key)
--- @param spec table: { description = string, action = function(repo_path) }
function M.register_action(name, spec)
  assert(type(name) == "string", "Action name must be a string")
  assert(type(spec) == "table" and type(spec.action) == "function", "spec must be a table with an action function")
  M.actions[name] = spec
end

-- Expand env vars and ~ in paths
default_dirs = function()
  local dirs = {}
  for _, dir in ipairs(config.dirs or {}) do
    table.insert(dirs, vim.fn.expand(dir))
  end
  for _, env in ipairs(config.env_vars or {}) do
    local val = os.getenv(env)
    if val then table.insert(dirs, vim.fn.expand(val)) end
  end
  return dirs
end

--- Find all git repos under the configured directories
function M.find_git_repos(cb)
  local dirs = default_dirs()
  local results = {}
  local pending = #dirs
  if pending == 0 then cb({}) return end
  for _, dir in ipairs(dirs) do
    Job:new({
      command = "fd",
      args = { "--type", "d", "--hidden", ".git", dir },
      on_exit = function(j)
        for _, path in ipairs(j:result()) do
          local repo = Path:new(path):parent():absolute()
          table.insert(results, repo)
        end
        pending = pending - 1
        if pending == 0 then
          cb(results)
        end
      end,
    }):start()
  end
end

--- Telescope picker for git repos
function M.telescope_picker()
  M.find_git_repos(function(repos)
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    pickers.new({}, {
      prompt_title = "Git Repos",
      finder = finders.new_table { results = repos },
      sorter = conf.generic_sorter({}),
      attach_mappings = function(_, map)
        map("i", "<CR>", function(prompt_bufnr)
          local selection = require("telescope.actions.state").get_selected_entry()
          require("telescope.actions").close(prompt_bufnr)
          actions.dashboard(selection[1])
        end)
        return true
      end,
    }):find()
  end)
end

--- Setup
function M.setup(opts)
  config.setup(opts)
end

return M
