# project_finder.nvim

A Neovim plugin to discover, manage, and interact with your git repositories across multiple directories and environment variables, with Telescope and which-key integration.

## Features
- Find all git repos under user-specified directories or environment variables
- Fuzzy-search repos with Telescope (fzf-native supported)
- Open a project dashboard for high-level project management
- Register custom actions (API provided)
- which-key integration for discoverability

## Installation
Add to your plugin manager (e.g., lazy.nvim):
```lua
{
  'project_finder',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
}
```

## Configuration
```lua
require('project_finder').setup({
  dirs = { '~/code', '~/work' },
  env_vars = { 'WORK', 'CODE', 'PROJECTS' },
  actions = {
    default = 'dashboard',
    -- custom actions can be added here
  },
})
```

## Usage
- `<leader>gr` launches the repo finder Telescope picker
- Select a repo to open its dashboard

## Custom Actions
Register your own actions for the dashboard or picker:
```lua
require('project_finder').register_action('deploy', {
  description = 'Deploy Project',
  action = function(repo_path)
    print('Deploying ' .. repo_path)
  end
})
```

## Testing
Run tests with plenary:
```
:PlenaryBustedDirectory tests/
```

## License
MIT
