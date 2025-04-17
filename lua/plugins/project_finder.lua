-- Plugin loader for project_finder
return {
  "project_finder",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  config = function()
    require("project_finder").setup({
      dirs = { "~/code", "~/work" },
      env_vars = { "WORK", "CODE", "PROJECTS" },
      actions = {
        default = "dashboard",
        -- custom actions can be added here
      },
    })
    -- which-key integration (add to your which-key config if preferred)
    local wk = require("which-key")
    wk.register({
      g = {
        name = "Git/Projects",
        r = { function() require("project_finder").telescope_picker() end, "Find Git Repo" },
      },
    }, { prefix = "<leader>" })
  end,
}
