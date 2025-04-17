-- Load lazy first
require("config.lazy")

-- Delay loading configs until after plugins are installed
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function()
    -- Now it's safe to load configs that depend on plugins
    require("config.lsp").setup()
    require("config.completion").setup()
    require("config.fidget").setup()
    require("config.treesitter").setup()
  end
})
