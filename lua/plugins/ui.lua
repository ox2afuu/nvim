return {
  {
    -- floating LSP previews
    "rmagatti/goto-preview",                  
    dependencies = { "rmagatti/logger.nvim" },
    event = "BufReadPre",
    config = function()
      require("goto-preview").setup {
        width  = 80,
        height = 15,
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        default_mappings = true,
      }
    end,
  },
}
