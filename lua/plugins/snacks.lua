return {
  -- List of plugins here

  -- Snacks NVIM
  {
    "folke/snacks.nvim",
    priority = 1000,
    ---@type snacks.Config
    opts = {
      -- config options here if desired
      -- leave blank for defaults
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      debug = { enabled = true },
      explorer = {
        enabled = true,
        auto_open = false,
      },
      git = { enabled = true },
      gitbrowse = { enabled = true },
      indent = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      notify = { enabled = true },
      picker = { enabled = true },
      quickfile = { enabled = true },
      scratch = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      styles = {
        notification = {},
      },
      terminal = {
        enabled = true,
        open_mapping = "<leader>tt",
      },
      toggle = {
        enabled = true,
        keys = {
          close = "<leader>tc",
          next = "<leader>tn",
          prev = "<leader>tp",
        },
      },
      words = { enabled = true },
    },
  },

  -- echasnovski / mini.nvim
  {
    "echasnovski/mini.nvim",
    version = false,
  },

  -- nvim-tree / nvim-web-devicons
  { "nvim-tree/nvim-web-devicons", opts = {} },
}
