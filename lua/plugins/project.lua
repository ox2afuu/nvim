  return {
  {
    -- project detection & Telescope integration
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("project_nvim").setup({
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "Makefile", "package.json" },
      })
      -- make :Telescope projects available
      require("telescope").load_extension("projects")
    end,
  },
}
