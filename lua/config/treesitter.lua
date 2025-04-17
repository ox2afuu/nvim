local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup {
    -- parsers to install
    ensure_installed = { "python", "c", "cpp", "lua", "rust", "go" },
    auto_install   = true,    -- install missing parsers when entering buffer
    sync_install   = false,   -- install parsers synchronously (only set to true if you need it)

    -- syntax highlighting
    highlight = {
      enable                    = true,
      additional_vim_regex_highlighting = false,
    },

    -- indentation (improves on built‑in indent.lua)
    indent = {
      enable = true,
    },

    -- incremental selection with treesitter nodes
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection    = "gnn",  -- start selection
        node_incremental  = "grn",  -- go to next node
        scope_incremental = "grc",  -- go to next scope
        node_decremental  = "grm",  -- go back to previous node
      },
    },

    -- Nvim Rainbow config
    rainbow = {
       enable = true,
       extended_mode = true,
       max_file_lines = nil,
    },

    -- playground for inspecting the AST
    playground = {
      enable          = true,
      updatetime      = 25,    -- debounced time for highlighting nodes
      persist_queries = false, -- save queries across sessions
    },

    -- you can add more modules here (e.g. textobjects) as you need
  }

  -- use treesitter for folding
  vim.opt.foldmethod     = "expr"
  vim.opt.foldexpr       = "nvim_treesitter#foldexpr()"
  vim.opt.foldlevelstart = 99
end

return M

