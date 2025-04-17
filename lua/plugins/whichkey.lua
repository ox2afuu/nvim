-- lua/plugins/whichkey.lua
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      -- Helper: check if a plugin is available
      local function has(plugin)
        return pcall(require, plugin)
      end

      -- Treesitter submenu
      local treesitter_menu = {
        name = "Treesitter",
        i = { ":TSNodeUnderCursor<cr>", "Show Node Info" },
        p = { ":TSPlaygroundToggle<cr>", "Playground" },
        r = { ":TSHighlightCapturesUnderCursor<cr>", "Highlight Capture" },
        f = { ":TSToggle fold<cr>", "Toggle Fold" },
        s = { ":TSBufEnable incremental_selection<cr>", "Enable Incremental Sel" },
        S = { ":TSBufDisable incremental_selection<cr>", "Disable Incremental Sel" },
        n = { 'Increment Node', "Inc Node (visual)" },
        N = { 'Decrement Node', "Dec Node (visual)" },
        -- Add more Treesitter actions as needed
      }

      -- Telescope submenu (only if available)
      local telescope_menu = nil
      if has("telescope") then
        telescope_menu = {
          name = "Telescope",
          f = { ":Telescope find_files<cr>", "Find Files" },
          g = { ":Telescope live_grep<cr>", "Live Grep" },
          b = { ":Telescope buffers<cr>", "Buffers" },
          h = { ":Telescope help_tags<cr>", "Help Tags" },
          p = { ":Telescope projects<cr>", "Projects" },
        }
      end

      -- Plenary submenu (if available)
      local plenary_menu = nil
      if has("plenary") then
        plenary_menu = {
          name = "Plenary",
          t = { ":PlenaryBustedFile<cr>", "Run Plenary Tests" },
        }
      end

      -- NUI submenu (if available)
      local nui_menu = nil
      if has("nui") then
        nui_menu = {
          name = "NUI UI",
          d = { function() require("nui.popup").show({ enter = true }) end, "Demo Popup" },
        }
      end

      -- Normal mode mappings
      local normal = {
        ["<leader>"] = {
          p = { name = "Plugins", s = { ":Lazy sync<cr>", "Sync Plugins" }, u = { ":Lazy update<cr>", "Update Plugins" }, c = { ":Lazy compile<cr>", "Compile Config" }, i = { ":Lazy install<cr>", "Install Plugins" }, r = { ":Lazy clean<cr>", "Clean Unused" } },
          m = { name = "Mason", m = { ":Mason<cr>", "Open Mason UI" }, I = { ":MasonInstall<cr>", "Install Tools" }, U = { ":MasonUpdate<cr>", "Update Installed" } },
          l = { name = "LSP", d = { ":lua vim.lsp.buf.definition()<cr>", "Definition" }, D = { ":lua vim.lsp.buf.declaration()<cr>", "Declaration" }, i = { ":lua vim.lsp.buf.implementation()<cr>", "Implementation" }, R = { ":lua vim.lsp.buf.references()<cr>", "References" }, r = { ":lua vim.lsp.buf.rename()<cr>", "Rename" }, a = { ":lua vim.lsp.buf.code_action()<cr>", "Code Action" }, f = { ":lua vim.lsp.buf.format({ async=true })<cr>", "Format" }, s = { ":lua vim.lsp.buf.signature_help()<cr>", "Signature Help" }, h = { ":lua vim.lsp.buf.hover()<cr>", "Hover" }, t = { ":lua vim.lsp.buf.type_definition()<cr>", "Type Def" }, w = { name = "Workspace", a = { ":lua vim.lsp.buf.add_workspace_folder()<cr>", "Add Folder" }, r = { ":lua vim.lsp.buf.remove_workspace_folder()<cr>", "Remove Folder" }, l = { ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", "List Folders" } } },
          c = { name = "Completion", t = { ":lua require('cmp').complete()<cr>", "Trigger Completion", mode = "i" }, n = { ":lua require('cmp').select_next_item()<cr>", "Next Item", mode = { "i", "s" } }, N = { ":lua require('cmp').select_prev_item()<cr>", "Prev Item", mode = { "i", "s" } } },
          t = treesitter_menu,
          f = telescope_menu,
          u = { name = "Toggle", s = { ":set spell!<cr>", "Spell Check" }, w = { ":set wrap!<cr>", "Line Wrap" }, l = { ":set relativenumber!<cr>", "Relative Number" }, d = { ":lua require('snacks').toggle.diagnostics()<cr>", "Diagnostics" }, T = { ":lua require('snacks').toggle.treesitter()<cr>", "Tree-sitter" } },
          P = plenary_menu,
          U = nui_menu,
        }
      }

      -- Visual mode mappings
      local visual = {
        ["<leader>"] = {
          t = {
            name = "Treesitter",
            i = { ":TSNodeUnderCursor<cr>", "Show Node Info" },
            s = { ":lua require'nvim-treesitter.incremental_selection'.init_selection()<cr>", "Init Selection" },
            n = { ":lua require'nvim-treesitter.incremental_selection'.node_incremental()<cr>", "Node +" },
            N = { ":lua require'nvim-treesitter.incremental_selection'.node_decremental()<cr>", "Node -" },
            S = { ":lua require'nvim-treesitter.incremental_selection'.scope_incremental()<cr>", "Scope +" },
          },
        }
      }

      -- Register mappings
      wk.register(normal["<leader>"], { prefix = "<leader>", mode = "n" })
      wk.register(visual["<leader>"], { prefix = "<leader>", mode = "v" })
    end,
  },
}
