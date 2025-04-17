local M = {}

function M.setup()
  -- IMPORTANT: Make sure to set up mason first
  require("mason").setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
      border = "rounded",
    },
  })
  
  -- Configure mason-lspconfig
  require("mason-lspconfig").setup({
    -- Automatically install these LSPs
    ensure_installed = {
      "lua_ls",       -- Lua
      "tsserver",     -- TypeScript/JavaScript
      "pyright",      -- Python
      -- Add more language servers as needed
    },
    -- Auto-install configured servers (with lspconfig)
    automatic_installation = true,
  })

  -- Import lspconfig
  local lspconfig = require("lspconfig")
  
  -- Import cmp-nvim-lsp capability provider
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  
  -- Setup LSP keymaps when an LSP attaches to a buffer
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    
    -- See `:help vim.lsp.*` for documentation on these functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  end
  
  -- Configure individual language servers
  
  -- Lua Language Server setup
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }, -- Recognize 'vim' global in Lua files
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false, -- Disable third-party library check prompt
        },
        telemetry = { enable = false },
      },
    },
  })
  
  -- TypeScript/JavaScript setup
  lspconfig.tsserver.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
  
  -- Python setup with Pyright
  lspconfig.pyright.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- Add more language servers as needed, following the same pattern
  
  -- Configure diagnostic display
  vim.diagnostic.config({
    virtual_text = {
      prefix = '●', -- Could be '■', '▎', 'x', etc.
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })
  
  -- Add borders to LSP windows
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end
end

return M
