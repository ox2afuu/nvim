return {
  -- Core Treesitter support
  {
    "nvim-treesitter/nvim-treesitter",
    build        = ":TSUpdate",            -- run :TSUpdate after install
    event        = { "BufReadPost", "InsertEnter" },
    dependencies = {
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "p00f/nvim-ts-rainbow",
      "windwp/nvim-ts-autotag",
    },
    -- Defer actual setup until after Lazy has loaded all plugins
    config = function()
      require("config.treesitter").setup()
    end,
  },

  -- TS Playground for query testing
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
  },

  -- TextObjects: select functions, classes, etc.
  {
    "nvim-treesitter/nvim-treesitter-textobjects"
  },

  -- Rainbow parentheses
  {
    "p00f/nvim-ts-rainbow",
  },

  -- Auto‑close and auto‑rename HTML/JSX tags
  {
    "windwp/nvim-ts-autotag",
    ft     = { "html", "xml", "javascript", "typescript", "vue", "tsx" },
    config = true,
  },
}

