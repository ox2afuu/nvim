-- lua/plugins/whichkey.lua
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        presets = {
          operators    = true,
          motions      = true,
          text_objects = true,
          windows      = true,
          nav          = true,
          z            = true,
          g            = true,
        },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      wk.register({
        -- Plugin manager (lazy.nvim)
        p = { name = "Plugins" },
        ps = { "<cmd>Lazy sync<cr>",    "Sync Plugins" },
        pu = { "<cmd>Lazy update<cr>",  "Update Plugins" },
        pc = { "<cmd>Lazy compile<cr>", "Compile Config" },
        pi = { "<cmd>Lazy install<cr>", "Install Plugins" },
        pr = { "<cmd>Lazy clean<cr>",   "Clean Unused" },

        -- Mason
        m  = { name = "Mason" },
        mm = { "<cmd>Mason<cr>",         "Open Mason UI" },
        mI = { "<cmd>MasonInstall<cr>",  "Install Tools" },
        mU = { "<cmd>MasonUpdate<cr>",   "Update Installed" },

        -- LSP (nvim-lspconfig)
        l  = { name = "LSP" },
        ld = { "<cmd>lua vim.lsp.buf.definition()<cr>",     "Definition" },
        lD = { "<cmd>lua vim.lsp.buf.declaration()<cr>",    "Declaration" },
        li = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation" },
        lR = { "<cmd>lua vim.lsp.buf.references()<cr>",     "References" },
        lr = { "<cmd>lua vim.lsp.buf.rename()<cr>",         "Rename" },
        la = { "<cmd>lua vim.lsp.buf.code_action()<cr>",    "Code Action" },
        lf = { "<cmd>lua vim.lsp.buf.format({ async=true })<cr>", "Format" },
        ls = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
        lh = { "<cmd>lua vim.lsp.buf.hover()<cr>",          "Hover" },
        lt = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Definition" },

        -- Workspace sub‑group
        lw = { name = "Workspace" },
        lwa = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>",    "Add Folder" },
        lwr = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", "Remove Folder" },
        lwl = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", "List Folders" },

        -- Completion (nvim-cmp)
        c  = { name = "Completion" },
        ct = { "<cmd>lua require('cmp').complete()<cr>",               "Trigger Completion", mode = "i" },
        cn = { "<cmd>lua require('cmp').select_next_item()<cr>",        "Next Item",        mode = { "i","s" } },
        cN = { "<cmd>lua require('cmp').select_prev_item()<cr>",        "Prev Item",        mode = { "i","s" } },

        -- Snacks toggles
        u  = { name = "Toggle" },
        us = { "<cmd>set spell!<cr>",                                  "Spell Check" },
        uw = { "<cmd>set wrap!<cr>",                                   "Line Wrap" },
        ul = { "<cmd>set relativenumber!<cr>",                         "Relative Number" },
        ud = { "<cmd>lua require('snacks').toggle.diagnostics()<cr>",  "Diagnostics" },
        uT = { "<cmd>lua require('snacks').toggle.treesitter()<cr>",   "Tree‑sitter" },
      }, { prefix = "<leader>" })
    end,
  },
}

