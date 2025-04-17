local project_finder = require('project_finder')
local busted = require('plenary/busted')

describe('project_finder', function()
  it('expands static directories and env vars', function()
    local config = require('project_finder.config')
    config.setup({
      dirs = { '~/testdir' },
      env_vars = { 'HOME' },
    })
    local dirs = {}
    for _, dir in ipairs(config.dirs) do
      table.insert(dirs, vim.fn.expand(dir))
    end
    for _, env in ipairs(config.env_vars) do
      local val = os.getenv(env)
      if val then table.insert(dirs, vim.fn.expand(val)) end
    end
    assert.is_true(#dirs >= 1)
  end)

  it('registers custom actions', function()
    local called = false
    project_finder.register_action('test', {
      description = 'Test Action',
      action = function(repo_path)
        called = repo_path
      end
    })
    assert.is_not_nil(project_finder.actions['test'])
    project_finder.actions['test'].action('dummy_path')
    assert.are.same('dummy_path', called)
  end)
end)
